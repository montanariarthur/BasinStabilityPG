function D = default_D(P)
%default_D  Default method for estimating the damping coefficients D_i.
%   D = default_D(P) returns a vector of D_i values, with each component
%   D_i = 50 p.u. (corresponding to generator i). This is the method used
%   in Refs. [1,2] and is equivalent to setting
%
%       D_{m,i} = 0 * P_R/omega_R
%       D_{e,i} = 0 * P_R/omega_R
%       R_i = 0.02 * omega_R/P_R
%
%   in the notations used in Ref. [1]. The input P (the column vector of
%   power injected by generators, P^*_{g,i}) is not used here, but required
%   because the functions EN_model, SP_model, and SM_model allow for
%   user-defined estimator functions that depend on these parameters.
%
%   References:
%
%   [1] T. Nishikawa and A. E. Motter, Comparative analysis of existing
%   models for power-grid synchronization, New J. Phys. 17, 015012 (2015).
%
%   [2] A. E. Motter, S. A. Myers, M. Anghel, and T. Nishikawa, Spontaneous
%   synchrony in power-grid networks, Nat. Phys. 9, 191-197 (2013).
%
%   See also default_H, default_x_d, EN_model, SP_model, SM_model

%
% Copyright (C) 2015  Takashi Nishikawa
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

%   Last modified by Takashi Nishikawa on 1/27/2015

D = 50*ones(size(P));