function x_d = default_x_d(P)
%DEFAULT_X_D    Default method for estimating the transient reactances x'_{d,i}.
%   x_d = DEFAULT_X_D(P) returns a vector of x'_{d,i} values computed
%   accoding to the empirical relation observed and used in Ref. [2]:
%
%       x_{d,i} = 92.8 * |P^*_{g,i}|^{-1.3}
%
%   in the notation of Ref. [1], while imposing a maximum value of 1 p.u.
%   This is the method used in Ref. [1].
%
%   References:
%
%   [1] T. Nishikawa and A. E. Motter, Comparative analysis of existing
%   models for power-grid synchronization, New J. Phys. 17, 015012 (2015).
%
%   [2] A. E. Motter, S. A. Myers, M. Anghel, and T. Nishikawa, Spontaneous
%   synchrony in power-grid networks, Nat. Phys. 9, 191-197 (2013).
%
%   See also default_D, default_H, EN_model, SP_model, SM_model

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

x_d_max = 1;
x_d = min([92.8*P.^(-1.3), x_d_max*ones(size(P))], [], 2);
% x_d = zeros(size(x_d));
