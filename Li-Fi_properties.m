%% Parameters
% Tower positions [x, y] (meters)
tower_positions = [0 0; 5 0; 10 0];   % three towers along x-axis
h_tx = 2.0;   % LED height (m)
h_rx = 0.3;   % Receiver height on ROV (m)

% LED parameters
P_t = 1.0;        % Optical power of LED (W)
phi_half_deg = 60; % Semi-angle at half power (deg)
phi_half = deg2rad(phi_half_deg);
m = -log(2)/log(cos(phi_half));  % Lambertian order

% Receiver (solar panel) properties
A_rx = 4e-3;    % Receiver area (m^2)
Ts = 1.0;       % Optical filter gain
FOV_deg = 85;   % Field of view (deg)
FOV = deg2rad(FOV_deg);
n_refr = 1.0;   % Refractive index (1 = none)
eta = 0.20;     % PV efficiency (20%)

% Concentrator gain function
g_conc = @(psi) (psi <= FOV) .* ( (n_refr==1.0).*1.0 + ...
    (n_refr~=1.0).*(n_refr.^2 ./ (sin(FOV).^2)) );

%% ROV trajectory
N = 601;  % number of samples
t = linspace(0,12,N);
x_path = linspace(-1,12,N);
y_path = 2.0 + 0.3*sin(0.8*x_path);  % small oscillation

num_towers = size(tower_positions,1);
Pr_all = zeros(num_towers,N);

%% Compute received power
for i = 1:num_towers
    tx = tower_positions(i,:);
    
    dx = x_path - tx(1);
    dy = y_path - tx(2);
    dz = h_tx - h_rx;
    d = sqrt(dx.^2 + dy.^2 + dz.^2);
    
    % LED pointing down -> cos(phi) = dz/d
    cos_phi = dz ./ d;
    phi = acos(cos_phi);
    
    % Receiver faces up -> psi = phi
    psi = phi;
    
    H = zeros(1,N);
    mask = psi <= FOV;
    H(mask) = ((m+1) * A_rx .* (cos_phi(mask).^m) .* cos(psi(mask))) ...
              ./ (2*pi.*d(mask).^2) .* Ts .* g_conc(psi(mask));
    
    Pr_all(i,:) = P_t .* H;
end

% Pick strongest tower at each step
[Pr_max, best_tower] = max(Pr_all,[],1);
P_elec = eta .* Pr_max;

%% Plots
figure;
plot(t, sqrt((x_path - tower_positions(best_tower,1)).^2 + ...
             (y_path - tower_positions(best_tower,2)).^2 + ...
             (h_tx - h_rx)^2));
xlabel('Path parameter');
ylabel('Distance to best tower (m)');
title('Distance vs path');
grid on;

figure;
semilogy(t, Pr_max);
xlabel('Path parameter');
ylabel('Received optical power (W)');
title('Received optical power vs path');
grid on;

figure;
plot(t, P_elec);
xlabel('Path parameter');
ylabel('Electrical power (W)');
title(sprintf('Electrical power vs path (Efficiency = %.0f%%)', eta*100));
grid on;

figure;
scatter(tower_positions(:,1), tower_positions(:,2),120,'^','filled'); hold on;
for i = 1:num_towers
    text(tower_positions(i,1), tower_positions(i,2)+0.2, sprintf('Tower %d',i-1), ...
        'HorizontalAlignment','center');
end
scatter(x_path, y_path, 8, best_tower,'filled');
xlabel('X (m)'); ylabel('Y (m)');
title('ROV path and tower coverage (color = best tower)');
axis equal; grid on; colorbar;
