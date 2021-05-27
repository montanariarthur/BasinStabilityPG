function dx = kuramoto_powergrid(t,x,Ng,wref,K,H,A,D,gamma)
% Network of second-order Kuramoto oscillators. 
% Implements model (1) in our paper.
%       x     -  state variable vector, structured as [phi_1, phi_2, ... ,
%                phi_Ng, omega_1, omega_2, ... , omega_Ng]^T, where phi_i
%                and omega_i are the phase angle and instantaneous 
%                frequency of oscillator 'i', respectively. This is a
%                2Ng-dimensional array.
%       Ng    -  number of oscillators
%       wref  -  reference frequency
%       A     -  Ng-dimensional array, power injection
%       K     -  Ng x Ng matrix, coupling factor
%       D     -  Ng-dimensional array, damping constant
%       H     -  Ng-dimensional array, inertia constant
%       gamma -  Ng x Ng  matrix, phase shift

% Copyright (C) 2019  Arthur Montanari (May 2019)
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

x1(:,1) = x(1:Ng)';               % phase vector
x2(:,1) = x(Ng+1:2*Ng)';          % frequency vector

dx1 = x2;
dx2 = wref./(2*H).*( A - (D/wref).*x2 + sum( sin(ones(Ng,1)*x1' - x1*ones(1,Ng) + gamma).*K , 2) );

dx = [dx1; dx2];                  % return

end
