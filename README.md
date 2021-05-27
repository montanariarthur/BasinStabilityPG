# BasinStabilityPG
This repository contains the MATLAB codes used to estimate the basin stability
of a set of randomly generated power grids as well as a simplified model of the 
Brazilian power grid, as described in Ref. [1]. Please, refer to this paper for further details.

The codes syntax were adjusted to be better aligned with the paper notation. 
This is not the most computationally efficient implementation of our algorithm, 
however it is, in our opinion, the most readable one.
The contents of this repository were firstly reported at https://doi.org/10.13140/RG.2.2.11054.15685.

# Usage

For more details, see the full description at each file. To execute the codes, run file `main_powergridstability.m`.
- `main_powergridstability.m` : Numerical setup and basin stability estimation of an ensemble of random power grids.
- `defines_mpc.m` : Defines the power grid dataset with a random network topology as a MPC (MATPOWER case) struct.
- `defines_casebr.m` : Defines the dataset of a simplified model of the Brazilian (hydroelectrical) power grid as MPC struct.
- `defines_basinstability.m` : Estimates the basin stability (resilience) of each generator (node) against random perturbations within the specified bounds.
- `defines_parameters.m` : Estimates the parameters of a network of Kuramoto oscillators from the power grid dataset, following the EN model paradigm.
- `kuramoto_powergrid.m` : Differential equations of a network of second-order Kuramoto oscillators.
- `odeRK.m` : Implements the numerical integration algorithm Runge Kutta 4th order.
- `randomgraphs.mat` : Data file that contains a set of 1,000 randomly generated adjacency matrices.

# Dependency 

The following codes were reported in Ref. [2] (available at https://sourceforge.net/projects/pg-sync-models/). If you use this code to any future work, please do not forget to provide credit to the original authors by referencing Ref. [2].
- `EN_model.m` : Computes the parameters of the effective network (EN) model for the dynamics of the power system given by a MPC struct.
- `default_D.m` : Default method for estimating the damping coefficients D_i.
- `default_H.m` : Default method for estimating the inertia constants H_i.
- `default_x_d.m` : Default method for estimating the transient reactances x'_{d,i}.

Matpower 6.0 (https://matpower.org/download/) is required for the power flow calculation.

# References
1. Arthur N. Montanari, Ercilio I. Moreira, Luis A. Aguirre (**2020**). Effects of network heterogeneity and tripping time on the basin stability of power systems. *Communications in Nonlinear Science and Numerical Simulation*, 89, 105296. https://doi.org/10.1016/j.cnsns.2020.105296.
2. Takashi Nishikawa and Adilson E. Motter (**2015**). Comparative analysis of existing models for power-grid synchronization. *New Journal of Physics.* 17, 015012. https://doi.org/10.1088/1367-2630/17/1/015012.
