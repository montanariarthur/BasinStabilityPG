function [mpc, Ng, Nl] = defines_mpc(Nt,Adj,Pdistrib)
% This code defines the power grid dataset as a MPC struct 
% (following MATPOWER struct).
%       mpc  -  MATPOWER case struct (power grid dataset)
%       Ng   -  number of generator nodes
%       Nl   -  number of load nodes
%       Nt   -  total number of nodes
%       Adj  -  unweighted adjacency matrix (network topology)
%       Pdistrib  -  power distribution (see "main_powergridstability.m"
%                    file for details)

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

%% Scalar variables
mpc.ref_freq = 60;      % reference frequency
mpc.baseMVA = 100;      % base power MVA
mpc.version = '2';      % MPC version

%% Distribution of generators and loads as nodes in the adjacency matrix.
% Half the nodes are generators and the other half loads. 
Ng = Nt/2;                  % number of generators
Nl = Nt/2;                  % number of loads
mpc.bus(:,1) = 1:Nt;        % BUS index
mpc.bus(datasample(1:Nt,Nt,'Replace',false),2) = [2*ones(Ng,1); ones(Nl,1)];     
                            % BUS type (index 1 for loads, 2 for
                            % generators) is randomly determined
                            
% Indexing which buses (nodes) are generators
mpc.gen(:,1) = find(mpc.bus(:,2)==2);       % Generator BUS

%% Power distribution across the power grid buses (nodes).
% The X% of generators withholding the highest percentage of power supply 
% are chosen randomly throughout the network, where each one has a power 
% supply of Y/(50X)% of the total power supply Ptotal (active power) and 
% Qtotal (reactive power). 
% The remaining (100-Y)% of Ptotal and Qtotal is distributed equally 
% among the remaining (100-X)% generators.

% Total power supply
Ptotal = 75e3;              % active power
Qtotal = 0.2*Ptotal;        % reactive power


% Power generation distribution
ngi_highp = round(Pdistrib(1)*Ng);     % X% of generators (rounded)
ngi_lowp = Ng - ngi_highp;             % (100-X)% of generators

mpc.gen(:,2:3) = zeros(Ng,2);          % inicialization
random_Pdist = datasample(1:Ng,Ng,'Replace',false);   
    % From this random sample of the generators index, let the first 
    % ngi_highp (X%) concentrate Y% of the total power Ptotal, 
    % while the last ngi_lowp (100-X)% concentrate (100-Y)% of Ptotal.
mpc.gen(random_Pdist(1:ngi_highp),2) = Pdistrib(2)*Ptotal/ngi_highp;            
    % each node of the X% supplies (Y*Ptotal)/(X*Ng)
mpc.gen(random_Pdist(1:ngi_highp),3) = Pdistrib(2)*Qtotal/ngi_highp;       
    % each node of the X% supplies (Y*Qtotal)/(X*Ng)
mpc.gen(random_Pdist(ngi_highp+1:end),2) = (1-Pdistrib(2))*Ptotal/ngi_lowp;
    % each node of the (100-X)% supplies ((100-Y)*Ptotal)/((1-X)*Ng)
mpc.gen(random_Pdist(ngi_highp+1:end),3) = (1-Pdistrib(2))*Qtotal/ngi_lowp;
    % each node of the (100-X)% supplies ((100-Y)*Qtotal)/((100-X)*Ng)

    
% Power consumption/demand is equally distributed among the load
% (node) buses.
Pd = Ptotal/Nl; 
Qd = Qtotal/Nl;
mpc.bus(:,3:4) = zeros(Nt,2);                         % inicialization
mpc.bus(find(mpc.bus(:,2)==1),3) = Pd*ones(Nl,1);     % Pd (power demand)
mpc.bus(find(mpc.bus(:,2)==1),4) = Qd*ones(Nl,1);     % Qd
    
    
% Other parameters of the generators/loads are homogenized throughout the
% network.
mpc.gen(:,4) = 20e3*ones(Ng,1);    % Qmax
mpc.gen(:,5) = 0*mpc.gen(:,3);     % Qmin
mpc.gen(:,6) = ones(Ng,1);         % Vg (voltage magnitude setpoint)
mpc.gen(:,7) = mpc.baseMVA*ones(Ng,1);     % base of this machine (MVA)
mpc.gen(:,8) = ones(Ng,1);         % status = 1, in service
mpc.gen(:,9) = 20e3*ones(Ng,1);    % Pmax
mpc.gen(:,10:21) = zeros(Ng,12);   % other parameters = zero

mpc.bus(:,5:6) = zeros(Nt,2);         % no shunt conductance/susceptance
mpc.bus(:,7) = ones(Nt,1);            % area number = 1
mpc.bus(:,8) = 1*ones(Nt,1);          % Vm (voltage magnitude, in p.u.)
mpc.bus(:,9) = 0*ones(Nt,1);          % Va (voltage angle, in degrees)
mpc.bus(:,10) = 500*ones(Nt,1);       % base voltage (kV)
mpc.bus(:,11) = ones(Nt,1);           % zone
mpc.bus(:,12) = 1.1*ones(Nt,1);       % Vmax (maximum voltage)
mpc.bus(:,13) = 0.9*ones(Nt,1);       % Vmin (minimum voltage)

%% Transmission lines parameters.

% Defines the edges of the adjacency matrix as branches (transmission
% lines) in the "mpc" struct.
Adj_list = sparse(triu(Adj));
[mpc.branch(:,1),mpc.branch(:,2)] = find(Adj_list);
branch_size = size(mpc.branch(:,1),1);

% Parameters were homogeneously set as...
R = 0; X = 0.001875; B = 0.02;
mpc.branch(:,3) = R*ones(branch_size,1);        % series resistance
mpc.branch(:,4) = X*ones(branch_size,1);        % series reactance
mpc.branch(:,5) = B*ones(branch_size,1);        % shunt susceptance

mpc.branch(:,6:9) = zeros(branch_size,4);       % no "rates"
mpc.branch(:,10) = zeros(branch_size,1);        % angles = 0
mpc.branch(:,11) = ones(branch_size,1);         % all lines are in service
mpc.branch(:,12) = -360*ones(branch_size,1);    % angle min = -360
mpc.branch(:,13) = +360*ones(branch_size,1);    % anglesmax = +360

% The first load bus is arbitrarily chosen as a reference (index 3)
mpc.bus(find(mpc.bus(:,2)==1,1),2) = 3; 
                            
end
