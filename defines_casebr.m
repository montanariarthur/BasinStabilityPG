function [mpc,Ng,Nl,Nt] = defines_casebr
% This code defines the dataset of a simplified model of the Brazilian
% (hydroelectrical) power grid.
% For more details, we refer the user to our code 'defines_mpc.m'.
%       mpc -  MATPOWER case struct (power grid dataset)
%       Ng  -  number of generator nodes
%       Nl  -  number of load nodes
%       Nt  -  total number of nodes

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
Ng = 18;                % number of generators
Nl = 26;                % number of loads
Nt = 44;                % number of nodes

%% Bus data

P_total = 35e3;
type_r = 3;
type_g = 2;
type_l = 1;
Pd_g = 0;
Pd_l = P_total/26;
Qd_g = 0;
Qd_l = Pd_l*0.2;
Gs = 0;
Bs = 0;
area = 1;
Vm = 1;
Va = 0;
baseKV = 500;
zone = 1;
Vmax = 1.1;
Vmin = 0.9;

%	i	type	Pd      Qd      Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
    1	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    2	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    3	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    4	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    5	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    6	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    7	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    8	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    9	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    10	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    11	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    12	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    13	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    14	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    15	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    16	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    17	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    18	type_g	Pd_g	Qd_g	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    19	type_r	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    20	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    21	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    22	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    23	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    24	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    25	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    26	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    27	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    28	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    29	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    30	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    31	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    32	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    33	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    34	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    35	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    36	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    37	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    38	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    39	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    40	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    41	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    42	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    43	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
    44	type_l	Pd_l	Qd_l	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
];


%% Power generation percentage per generator
Ppercent = [0.0511555622399358;0.0855767784629268;0.0223291723066125;0.0833609064019652;...
            0.0755502080513360;0.0182483581490951;0.0115907153957989;0.0781571163583496;...
            0.0842933774502432;0.0566601493958991;0.0245550709379857;0.0421216222990926;...
            0.0408281947159974;0.0923747932019853;0.0564395648468441;0.0145485536672181;...
            0.1403719857622700;0.0218378703564446];

% NOTE: The percentage of power supply per generator from the total power
% distribution in the Brazilian power grid was estimated considering only
% the hydroelectrical power generation data available at the site of the
% "Operador Nacional do Sistema Elétrico" (ONS, translated to "National
% Operator of Electrical System) of Brazil:
% http://ons.org.br/sites/multimidia/Documentos%20Compartilhados/dados/Dados_2015/html/4-1.html
% http://ons.org.br/paginas/sobre-o-sin/mapas
% Last accessed on April 26th, 2019.

%% Generator data

Pg = P_total*Ppercent;
Qg = Pg*0.2;
Qmax = 0;
Qmin = 0;
Vg = 1;
mBase = 100;
status = 1;
Pmax = 20e3;
Pmin = 0;
Pc1 = 0;
Pc2 = 0;
Qc1min = 0;
Qc1max = 0;
Qc2min = 0;
Qc2max = 0;
ramp_agc = 0;
ramp_10 = 0;
ramp_30 = 0;
ramp_q = 0;
apf = 0;

%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max  ramp_agc    ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
    1	Pg(1)	Qg(1)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    2	Pg(2)	Qg(2)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    3	Pg(3)	Qg(3)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    4	Pg(4)	Qg(4)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    5	Pg(5)	Qg(5)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    6	Pg(6)	Qg(6)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    7	Pg(7)	Qg(7)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    8	Pg(8)	Qg(8)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    9	Pg(9)	Qg(9)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    10	Pg(10)	Qg(10)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    11	Pg(11)	Qg(11)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    12	Pg(12)	Qg(12)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    13	Pg(13)	Qg(13)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    14	Pg(14)	Qg(14)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    15	Pg(15)	Qg(15)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    16	Pg(16)	Qg(16)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    17	Pg(17)	Qg(17)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
    18	Pg(18)	Qg(18)	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1     Pc2     Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf      
];


%% Branch (transmission line) data
r = 0.00;
x = 0.0075;
b = 0.02;
rateA = 0;
rateB = 0;
rateC = 0;
ratio = 0;
angle = 0;
status = 1;
angmin = -360;
angmax = 360;

%	f	t   r	x	b   rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch = [
    2	1	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    19	1	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    20	1	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    3	2	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    4	2	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    19	2	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    20	2	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    21	2	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    22	2	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    30	2	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    31	2	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    32	2	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    4	3	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    22	3	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    23	3	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    30	3	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    31	3	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    32	3	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    22	4	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    24	4	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    27	4	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    28	4	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    29	4	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    30	4	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    31	4	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    32	4	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    7	5	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    33	5	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    34	6	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    34	7	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    9	8	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    32	8	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    35	8	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    36	8	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    10	9	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    12	9	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    32	9	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    36	9	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    38	9	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    39	9	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    39	10	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    12	11	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    39	12	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    38	13	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    15	14	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    40	14	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    43	14	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    44	14	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    16	15	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    18	15	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    41	15	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    42	15	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    18	16	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    42	16	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    43	17	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    42	18	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    20	19	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    30	22	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    31	22	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    32	22	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    24	23	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    25	24	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    27	25	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    27	26	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    28	27	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    29	28	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    30	29	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    31	30	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    32	30	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    32	31	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    35	32	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    35	34	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    37	36	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    38	36	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    38	37	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    39	38	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    40	39	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    43	39	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    41	40	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
    43	40	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax 
];

end
