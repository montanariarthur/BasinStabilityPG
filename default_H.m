function H = default_H(P)
%default_H  Default method for estimating the inertia constants H_i.
%   H = default_H(P) returns a vector the values (in seconds), computed
%   as
%
%       H_i = 0.04 * |P^*_{g,i}|
%
%   in the notation of Ref. [1] (an empirical relation observed and used in
%   Ref. [2]), while imposing a minimum value of 0.1 p.u. This is the
%   method used in Ref. [1].
%
%   References:
%
%   [1] T. Nishikawa and A. E. Motter, Comparative analysis of existing
%   models for power-grid synchronization, New J. Phys. 17, 015012 (2015).
%
%   [2] A. E. Motter, S. A. Myers, M. Anghel, and T. Nishikawa, Spontaneous
%   synchrony in power-grid networks, Nat. Phys. 9, 191-197 (2013).
%
%   See also default_D, default_x_d, EN_model, SP_model, SM_model

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

H_min = 0.1;
H = max([0.04*P, H_min*ones(size(P))], [], 2);
