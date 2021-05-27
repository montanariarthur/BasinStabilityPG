function p = defines_parameters(Ng,mpc)

% NOTE:
% Functions "EN_model.m", "default_D.m", "default_H.m" and "default_x_d.m"
% are available online by the authors at 
% https://sourceforge.net/projects/pg-sync-models/.
% If you use this code to any future work, please do not forget to provide 
% credit to the original authors by referencing their work.

% Copyright (C) 2019 Arthur Montanari, Ercilio I. Moreira & Luis A. Aguirre (May 2019)
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

% Following the EN model paradigm, this code estimates the parameters of a 
% network of Kuramoto oscillators from the power grid dataset ("mpc" 
% struct) and from the steady-state solution of power flow, computed
% through the MATPOWER toolbox.

% In this work, we investigate how the basin stability is affected by the
% choice of tripping time. Since isolating a generator from its bus leads
% to a different steady-state solution of the system's power flow, this
% means that there is a set of parameters (A,K,D,H,gamma) that describes
% the network dynamics *before* the i-th generator isolation, and another 
% set (A^i,K^i,D^i,H^i,gamma^i) that describes the network dynamics *after* 
% the i-th generator isolation.

%       p     -  (Ng+1)-tuple, where...
%       p{i}  -  if i == Ng+1, then p{i} is a tuple of the estimations of 
%                (A,K,D,H,gamma) when no generator is isolated from its
%                bus;
%                otherwise, then p{i} is a tuple of the estimations of 
%                (A^i,K^i,D^i,H^i,gamma^i) when the i-th generator is 
%                isolated from its bus.
%       Ng    -  number of generator nodes
%       mpc   -  MATPOWER case struct

%       A     -  Ng-dimensional array, where i-th element corresponds to 
%                power injection of node i
%       K     -  Ng x Ng matrix, where (i,j) element corresponds to the
%                coupling weight between nodes (i,j) 
%       D     -  Ng-dimensional array, where i-th element corresponds to 
%                damping constant of node i
%       H     -  Ng-dimensional array, where i-th element corresponds to 
%                inertia constant of node i
%       gamma -  Ng x Ng matrix, where (i,j) element corresponds to the
%                phase shift between nodes (i,j)
%       phi   -  Ng-dimensional array, where i-th element corresponds to
%                the phase angle of generator i at steady-state
%     omega_R -  reference frequency (scalar)


for i = 1:Ng+1
    
    % Parameter estimation when no node is isolated.
    if i == Ng + 1
        [p{i},~] = EN_model(mpc);           % computes EN model parameters

    % Parameter estimation when the i-th generator is isolated from the
    % corresponding bus.
    else
        mpc_aux = mpc;
        bus_gen = find(mpc_aux.bus(:,2)==2);  % generator buses indices
        mpc_aux.gen(i,8) = 0;                 % defines i-th generator as 
                                              % out of service
        
        % Power supply from the i-th generator is equally redistributed to 
        % the other generators
        mpc_aux.gen(:,2) = mpc_aux.gen(:,2) + mpc_aux.gen(i,2)/(Ng-1);    
                                            % redistributes P(i)
        mpc_aux.gen(:,3) = mpc_aux.gen(:,3) + mpc_aux.gen(i,3)/(Ng-1);    
                                            % redistributes Q(i)
        mpc_aux.gen(i,2:3) = zeros(1,2);    % P(i) = 0 and Q(i) = 0, i.e.
                                            % no power supply from bus i
       
        % Computes EN model parameters
        [p_aux, ~] = EN_model(mpc_aux);
        
        % Since the isolation of generator 'i' implies that node 'i' in the
        % EN model (the Kuramoto network) is removed, we add this node once
        % again with zero power injection and no coupling.
        if i == 1
                p_aux.A = [0; p_aux.A];
                p_aux.H = [p_aux.H(1); p_aux.H];
                p_aux.D = [p_aux.D(1); p_aux.D];
                p_aux.phi = [0; p_aux.phi];
                p_aux.gamma = [zeros(1,Ng-1); p_aux.gamma];
                p_aux.gamma = [zeros(Ng,1) p_aux.gamma];
                p_aux.K = [zeros(1,Ng-1); p_aux.K];
                p_aux.K = [zeros(Ng,1) p_aux.K];
            elseif i == Ng
                p_aux.A = [p_aux.A; 0];
                p_aux.H = [p_aux.H; p_aux.H(1)];
                p_aux.D = [p_aux.D; p_aux.D(1)];
                p_aux.phi = [p_aux.phi; 0];
                p_aux.gamma = [p_aux.gamma; zeros(1,Ng-1)];
                p_aux.gamma = [p_aux.gamma zeros(Ng,1)];
                p_aux.K = [p_aux.K; zeros(1,Ng-1)];
                p_aux.K = [p_aux.K zeros(Ng,1)];
            else
                p_aux.A = [p_aux.A(1:i-1); 0; p_aux.A(i:end)];
                p_aux.H = [p_aux.H(1:i-1); p_aux.H(1); p_aux.H(i:end)];
                p_aux.D = [p_aux.D(1:i-1); p_aux.D(1); p_aux.D(i:end)];
                p_aux.phi = [p_aux.phi(1:i-1); 0; p_aux.phi(i:end)];
                p_aux.gamma = [p_aux.gamma(1:i-1,:); zeros(1,Ng-1); p_aux.gamma(i:end,:)];
                p_aux.gamma = [p_aux.gamma(:,1:i-1) zeros(Ng,1) p_aux.gamma(:,i:end)];
                p_aux.K = [p_aux.K(1:i-1,:); zeros(1,Ng-1); p_aux.K(i:end,:)];
                p_aux.K = [p_aux.K(:,1:i-1) zeros(Ng,1) p_aux.K(:,i:end)];
        end
        
        p{i} = p_aux;
        clearvars mpc_v p_aux
    end         % end if
    
    p{i}.D = p{i}.D*2;
        % we double this parameter to guarantee a faster convergence of
        % model (1). Previous studies (e.g. Ref. 14) show that this
        % parameter does not affect the basin stability estimation.
    p{i}.K = p{i}.K.*(ones(Ng,Ng)-eye(Ng,Ng));
        % we nullify the diagonal since the summation term in model (1) has
        % the condition i\neq j.
        
end             % end for
