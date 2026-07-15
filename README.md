# Adaptive Gradient MPPT Reproducibility Package

This repository contains the custom algorithm implementation and simulation data supporting the manuscript:

**Adaptive Gradient Descent–Based Maximum Power Point Tracking Algorithm for Low-Power Photovoltaic Systems with Complexity-Aware Performance Analysis**

Authors: Kimia Ahmadi and Wouter A. Serdijn  
Affiliation: Department of Microelectronics, Delft University of Technology, The Netherlands

## Repository contents

### `code`

This folder contains the text implementation of the proposed adaptive gradient-descent-based perturb-and-observe MPPT algorithm, including:

- analytical power–voltage gradient evaluation;
- adaptive duty-cycle step calculation;
- threshold-based perturbation suppression;
- optional initialization routine for partial-shading conditions.

### `simulation_data`

This folder contains the MATLAB simulation data supporting the manuscript, including:

- irradiance input profiles;
- partial-shading scenarios;
- temperature-variation profiles;
- PV and converter parameters;
- controller parameters;
- numerical simulation results.

## Software

The simulations were performed using MATLAB and Simulink.

## Related benchmarking materials

Pseudocode representations of selected reference MPPT algorithms and the computational-complexity benchmarking methodology are available separately through Zenodo:

https://doi.org/10.5281/zenodo.18198514

## Citation

The archived version of this reproducibility package is available via Zenodo:

https://doi.org/10.5281/zenodo.21375280



## Contact

Kimia Ahmadi  
Department of Microelectronics  
Delft University of Technology  
Email: k.Ahmadi@tudelft.nl
