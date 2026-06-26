# Throughput and Delay Optimization Routing for CR-VANETs

A MATLAB-based research project proposing a **2-hop routing framework for Cognitive Radio Vehicular Ad Hoc Networks (CR-VANETs)** using **Harris Hawks Optimization (HHO)** to improve Vehicle-to-Everything (V2X) communication.

## Overview

Vehicular Ad Hoc Networks (VANETs) often suffer from high packet delays and reduced throughput due to rapid topology changes and congestion in the 5.9 GHz Dedicated Short-Range Communications (DSRC) band.

This project introduces a **2-hop forwarding strategy** that leverages **Harris Hawks Optimization (HHO)** to intelligently select relay vehicles based on:

* Vehicle Direction
* Vehicle Mobility
* Channel Availability

By combining optimization techniques with Cognitive Radio technology, the proposed framework aims to improve communication reliability, reduce routing overhead, and maintain stable network performance in dynamic traffic environments.

---

## Key Features

* 2-hop routing strategy for CR-VANETs
* Harris Hawks Optimization (HHO)-based relay selection
* Cognitive Radio spectrum-aware communication
* Multi-objective fitness function for forwarder selection
* Dynamic spectrum sensing and channel allocation
* Performance evaluation using throughput and end-to-end delay

---

## Tech Stack

* MATLAB
* Harris Hawks Optimization (HHO)
* Cognitive Radio
* Vehicular Ad Hoc Networks (VANETs)
* Vehicle-to-Everything (V2X)
* Dedicated Short-Range Communication (DSRC)

---

## Methodology

1. Sense DSRC and cognitive radio channels to identify available spectrum.
2. Collect vehicle mobility information including speed, position, and direction.
3. Discover neighboring vehicles within a localized 2-hop range.
4. Compute a fitness score for candidate relay vehicles based on direction, mobility, and channel availability.
5. Select the optimal forwarding node using Harris Hawks Optimization principles.
6. Transmit packets and evaluate network performance.

---

## Performance Metrics

The proposed routing framework is evaluated using:

* Throughput
* End-to-End Delay
* Packet Delivery Ratio (PDR)
* Routing Overhead

Simulation results demonstrate improved communication efficiency and stable performance under varying vehicular densities.

---

## Project Figures


### Flowchart

<img width="641" height="628" alt="image" src="https://github.com/user-attachments/assets/ae2bec2c-e1f4-4fc7-87a2-a8a3d56a61b6" />

### 2-Hop Routing Architecture

<img width="915" height="593" alt="2-hop routing with depiction of best and alternate route" src="https://github.com/user-attachments/assets/22013903-ff30-4b98-8c41-c9ce53ade71e" />

### Data Flow Management

<img width="457" height="347" alt="Data flow management at a crossing" src="https://github.com/user-attachments/assets/c73dd990-941a-4928-9c5b-f56e58fb7f19" />

### Throughput vs Vehicular Density

<img width="1378" height="626" alt="image" src="https://github.com/user-attachments/assets/65167517-72cb-41e5-82a1-70f3e98db1ee" />

### End-to-End Delay vs Vehicular Density

<img width="1378" height="627" alt="image" src="https://github.com/user-attachments/assets/c0cf4629-077a-4416-9053-c99445fc4637" />


---


---

## Future Enhancements

* Integration with NS-3 and SUMO for large-scale traffic simulations
* AI-assisted adaptive routing strategies
* Real-time vehicular mobility datasets
* Advanced optimization for packet delivery and latency reduction

