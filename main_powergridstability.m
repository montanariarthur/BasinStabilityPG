%% Numerical setup and basin stability estimation of an ensemble of random power grids
% For details on application, results and conclusions, please refer to:
% Effects of network heterogeneity and tripping time on the basin stability
% of power systems,
% by Arthur N. Montanari, Ercilio I. Moreira & Luis A. Aguirre (May 2019)

% Copyright (C) 2019  Arthur Montanari, Ercilio I. Moreira & Luis A. Aguirre (May 2019)
% 
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or (at
% your option) any later version.
% 
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
% USA.

%   Last modified by Arthur Montanari on 5/17/2019

clear all; close all; clc;

%% Change parameters here...

% This code follows the procedure described in Algorithm 1. Note that this
% code *does not* implement the first "for" structure (which varies the
% random power grid realization from 1 to M=100). Instead, the simulation 
% is computed for a single random network realization only, defined by the 
% 'net_realization' variable:
net_realization = 2;        % can be set as (1,2,...,1000)

% Defines the heterogeneity of the power distribution across generators in
% the power system. Let Pdistrib = [X Y], where X% of the generators
% concentrate Y% of the total power. In our paper, power was distributed in
% five distinct manners, from the most homogeneous to most heterogeneous 
% network: [0.5 0.5], [0.43 0.57], [0.35 0.65], [0.28 0.72] and [0.2 0.8].
Pdistrib = [0.5 0.5];                 

% Tripping time: Required time for a protection device to isolate the
% perturbed generator (node) from the rest of the network. In this work, we
% evaluated the basin stability of power grids for the following choices of
% tripping time: 0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.40, 0.50, 0.65,
% 0.80, 1.20, 1.70, 2.30, 3.00, and "infinity" (i.e. no node is removed).
% To set "infinity" just choose ttrip > tf, e.g. ttrip = 30.
ttrip = 0.05;
    % Trivia: The tripping time (rate break) of protection devices can be
    % found on circuit breakers' datasheets. For instance, a dead tank
    % circuit breaker, from SIEMENS, designed for applications from 72.5 to
    % 550kV has a tripping time of 3 cycles (approx. 0.05 s). See link
    % below:
    % https://new.siemens.com/global/en/products/energy/high-voltage/hv-switchgear/circuit-breakers/dead-tank.html
    % Last accessed on April 26th, 2019.
    
%% Ensemble of randomly generated power grid topologies.
% Power grid topologies are randomly generated following Schultz and 
% coworker's algorithm.
% Reference: P. Schultz, J. Heitzig, and J. Kurths. "A random growth model 
% for power grids and other spatially embedded infrastructure networks."
% European Physical Journal: Special Topics 223, 2593 (2014).
% Code available in Python at https://gitlab.com/luap-public/random-powergrid.

% File "randomgraphs.mat" has a set of 1,000 randomly generated networks
% generated with the code above. Variable "Adj_all" is a 1,000-tuple of 
% NtxNt matrices where each matrix represents the adjacency matrix of a 
% random network realization. In this dataset, parameters were set as 
% Nt = 100, n0 = 10, p = 0.2, q = 0.3, r = 1/3, s = 0.1.
% If you use this file to any future work, please do not forget to provide 
% credit to the original authors by referencing their work.
load randomgraphs.mat

% Note that, in this code, we only estimate the basin stability (per node) 
% Si in a *single random network realization*. Nevertheless, one can 
% reproduce the results of our paper by estimating Si in a set of the first 
% M=100 adjacency matrices in "randomgraphs.mat" file -- which is a 
% computationally expensive procedure.
Adj = Adj_all(:,:,net_realization);      % adjacency matrix
Nt = 100;                                % total number of nodes

%% Power system dataset/parameters.
% The power system parameters (dataset) defined here follow a struct
% named "mpc" (MATPOWER case struct). Except for the system operation 
% frequency and base power (in MVA), each data variable is a matrix, where 
% a row corresponds to a single bus, branch, gen, etc. In this code, we
% briefly explain the meaning of each column of the data variable.

% The MATPOWER notation is pretty much standard on the "power systems 
% community". For more details, the user is referred to code at
% http://www.pserc.cornell.edu/matpower/docs/ref/matpower5.0/caseformat.html

% To compute the steady-state distribution of power flow across the power
% grid, we use the MATPOWER toolbox, accessible at
% http://www.pserc.cornell.edu/matpower/. Please, if you use this toolbox
% for future work, do not forget to reference the original work:
% R. D. Zimmerman, C. E. Murillo-Sánchez, and R. J. Thomas, "MATPOWER: 
% Steady-State Operations, Planning and Analysis Tools for Power Systems 
% Research and Education," IEEE Transactions on Power Systems 26, pp. 12-19
% (2011).
[mpc, Ng, Nl] = defines_mpc(Nt,Adj,Pdistrib);

%% If you want to simulate the simplified model of Brazilian
% (hydroelectrical) power system, please comment the line above and
% uncomment the line below.
% % % [mpc, Ng, Nl, Nt] = defines_casebr;

%% Parameter estimation of the Kuramoto oscillators.
% From the power grid dataset defined above, it is necessary to estimate
% parameters (A,K,D,H,gamma) in order to simulate the dynamics of the
% nonlinear model (1). To that end, we follow the "effective-newtork model"
% (EN model) paradigm described in reference:
% T. Nishikawa and A. E. Motter. "Comparative analysis of existing models 
% for power-grid synchronization". New Journal of Physics 17, 015012 (2015).
% Code available in MATLAB at https://sourceforge.net/projects/pg-sync-models/.
% If you use this code to any future work, please do not forget to provide 
% credit to the original authors by referencing their work.
p = defines_parameters(Ng,mpc);

%% Basin stability estimation.
% This code numerically estimates the basin stability per generator node 
% S_i against perturbation within the specified bounds.
S = defines_basinstability(p,Ng,ttrip);
disp(S);
