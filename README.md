# Li-Fi Enabled Communication Simulation for Autonomous Robotic Vehicle Application

## Overview
This project simulates a **Li-Fi (Visible Light Communication) link** between multiple LED transmitters mounted on towers and a mobile **Remotely Operated Vehicle (ROV)** equipped with a solar-panel receiver.  

The simulation helps analyze how **distance, orientation, and motion** affect the **received optical power and harvested electrical power**, before moving to hardware prototyping.

---

## Features
- Models **Lambertian LED emission** and **optical wireless channel gain**  
- Simulates **Autonomous Robotic Vehicle trajectory** under multiple LED towers  
- Computes:
  - Distance to nearest tower  
  - Received **optical power** (W)  
  - Converted **electrical power** (W) based on PV efficiency  
- Visualizations:
  1. Distance to best tower  
  2. Received optical power (log scale)  
  3. Harvested electrical power  
  4. ROV path and tower coverage (color-coded best transmitter)  

---

## Code Description
- **System Parameters**: Tower locations, LED properties (power, beamwidth), and receiver specs (area, FOV, efficiency)  
- **Trajectory Generation**: Models ROV path `(x,y)` with small oscillations  
- **Channel Computation**: Implements VLC channel DC gain equation for each tower  
- **Tower Handover**: At each ROV position, selects the strongest tower  
- **Plots**: Automatically generated after simulation  

---

## Key Equation
The LOS (Line-of-Sight) DC channel gain is given by:

\[
H(0) = \frac{(m+1)A}{2\pi d^2}\cos^m(\phi)\cos(\psi)\,T_s\,g(\psi)
\]

Where:  
- \(m\) = Lambertian order of LED  
- \(A\) = receiver area  
- \(d\) = distance between transmitter and receiver  
- \(\phi\) = irradiance angle  
- \(\psi\) = incidence angle  
- \(T_s\) = optical filter gain  
- \(g(\psi)\) = concentrator gain  

---

## Applications

This simulation and prototype concept can be applied in multiple domains:

- **Mobile Robotics**
  - Optical communication for ROVs, UAVs, or ground robots
  - Indoor navigation using Li-Fi beacons instead of GPS
  - Handover management between multiple optical transmitters

- **Energy Harvesting**
  - Dual use of solar panels for both **data reception** and **power generation**
  - Evaluating harvested energy for powering low-power embedded systems

- **Industrial & Defense ROVs**
  - Reliable short-range communication in environments where RF is unreliable
  - Underwater optical communication (adapted with high-power LEDs/lasers)
  - ROV inspection tasks in smart factories, pipelines, or hazardous areas

- **Smart Cities & IoT**
  - Li-Fi enabled streetlights providing both **illumination + data** to autonomous vehicles
  - Integration of visible light communication for IoT sensor networks

- **Research & Education**
  - Benchmarking Li-Fi channel models
  - Studying handover, coverage, and energy trade-offs in mobile communication
  - Training projects for optical wireless communication and robotics

## How to Run
1. Clone this repository:
   ```bash
   git clone https://github.com/dhanush-darpan/Simulation-of-Li-Fi-Enabled-Communication-for-Autonomous-Robotic-Vehicle-Application.git
   cd Simulation-of-Li-Fi-Enabled-Communication-for-Autonomous-Robotic-Vehicle-Application
