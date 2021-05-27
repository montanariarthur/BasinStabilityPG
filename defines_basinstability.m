function S = defines_basinstability(p,Ng,ttrip)
% Estimates the basin stability per generator node S_i against perturbation 
% within the specified bounds.
%       S  -  Ng-dimensional array, where the i-th element corresponds to 
%             the basin stability S_i of the i-th node
%       p  -  (Ng+1)-tuple of parameters
%      Ng  -  number of generators (nodes)
%   ttrip  -  tripping time

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

%% Defines parameters.

% Numerical integration parameters
t0 = 0;                     % initial time
tf = 10;                    % final time
dt = 0.02;                  % integration step
tspan_bftrip = t0:dt/2:ttrip; % time span before isolating the perturbed node
tspan_aftrip = ttrip:dt:tf;   % time span after isolating the perturbed node

% Perturbation bounds
thetamin = -pi*3/4;
thetamax = +pi*3/4;
omegamin = -5;
omegamax = +5;

% Basin stability estimation parameters
N_I = 200;                  % number of simulations
tol_stability = 0.1;
    % tolerance constant so that oscillators are assumed to be synchronized
    % (i.e. converged to the stable synchronous manifold A')


%% Finds the steady-state condition of the network of Kuramoto oscillators
% when all oscillators are operating with no perturbations or isolations.
% The steady-state condition determines the stable synchronous manifold A.
x0 = [p{Ng+1}.phi; zeros(Ng,1)];      
        % the initial conditions are set as x_i(t0) = [phi_i; 0] to ensure
        % fast convergence, as recommended in Ref. 11 of our paper
[t,x] = odeRK(@(t,x)kuramoto_powergrid(t,x,Ng,p{Ng+1}.omega_R,p{Ng+1}.K,p{Ng+1}.H,p{Ng+1}.A,p{Ng+1}.D,p{Ng+1}.gamma),[0 dt 20], x0');
x_ss = x(end,:);            % steady-state solution (stable point A)

% Plots the dynamical evolution of the network of Kuramoto oscillator when
% no perturbation or isolation is considered.
figure(1)
subplot(121); plot(t,x(:,1:Ng)); xlabel('t'); ylabel('\phi_i(t)');
title('Phase evolution')
subplot(122); plot(t,x(:,Ng+1:end)); xlabel('t'); ylabel('\omega_i(t)')
title('Frequency evolution')
suptitle('Network state evolution with no perturbations or isolations')


%% The basin stability Si is estimated for each node 'i' in the random
% network.
S = zeros(1,Ng);
for i = 1:Ng
    disp(['Estimating basin stability of ' num2str(i) '/' num2str(Ng) ' nodes.'])
    N_A = 0;        % counter for number of times system (1) converged 
                    % after perturbation
                    
    % And to estimate Si, N_I simulations must be performed
    for sim = 1:N_I
        
        % Perturbation is added to the steady-state solution x_ss of node i
        x_ps = x_ss;
        x_ps(i) = x_ps(i) + thetamin + (thetamax - thetamin)*rand(1,1);
                % perturbed phase state
        x_ps(Ng+i) = x_ps(i) + omegamin + (omegamax - omegamin)*rand(1,1);
                % perturbed frequency state
                
        % Before tripping time: system (1) is numerically integrated from
        % [t0, ttrip] using parameter set in p{Ng+1} (no nodes isolated)
        [~,x_bf] = odeRK(@(t,x)kuramoto_powergrid(t,x,Ng,p{Ng+1}.omega_R,p{Ng+1}.K,p{Ng+1}.H,p{Ng+1}.A,p{Ng+1}.D,p{Ng+1}.gamma),tspan_bftrip, x_ps);
        
        % After tripping time: system (1) is numerically integrated from
        % [ttrip, tf] using parameter set in p{i} (node i is isolated)
        [~,x_af] = odeRK(@(t,x)kuramoto_powergrid(t,x,Ng,p{i}.omega_R,p{i}.K,p{i}.H,p{i}.A,p{i}.D,p{i}.gamma),tspan_aftrip, x_bf(end,:));
        
        % Checks if system (1) converged after perturbation
        if norm(x_af(end,Ng+1:end)) <= tol_stability
            N_A = N_A + 1;
        end
        
    end
    S(i) = N_A/N_I;         % basin stability estimation   
end

%% Note from authors:
% Although we made it available online our MATLAB code, the numerical
% estimation of the basin stability presented in our paper results was 
% computed in JULIA programming language, which features, as a part of the 
% DifferentialEquations.jl package, the numerical integration method 
% "Tsitouras 5/4 Runge-Kutta (Tsit5)" (using the same fixed step time 
% implemented here). This change of programming languages was performed to 
% improve simulation time and, therefore, make simulations a lot more 
% feasible. Nevertheless, despite for simulation time, both codes implement 
% this algorithm identitically.

end