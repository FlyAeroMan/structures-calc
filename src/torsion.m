function theta = torsion(Pmax,alldata)
% torsion - A function which calculates the angle of twist for
% single-celled advanced aerospace beams assuming the beam is in a free
% state. Since most advanced aerospace beams have a fixed end, the OUTPUTS
% are, at best, APPROXIMATE IN NATURE FOR SUCH CASES.
%FORMAT: theta = torsion(Pmax,alldata)

% Copyright (C) 2021  Cameron Cropper
%
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program. If not, see <https://www.gnu.org/licenses/>.

% November 24, 2021 09:44:40 PM CDT

% NOTICE: This source code is Copyright (C) 2021  Cameron Cropper and is
% intended for AE525 Instructor/Grader use only. If you obtain this
% document in error destroy it immediately.

% Retrieve required values from alldata
z_bar = alldata{2}(2);
A_hat = 4.1171875;
x0 = alldata{5}(1,10);
G = 36000;

%Case 1: P == 0------------------------------------------------------------
Mx1 = 5 * z_bar;
q1 = Mx1/(2 * A_hat);
Q1 = q1/G;

syms x dphi1 phi1

dphi1(x) = (1/(2 * A_hat)) * (vpaintegral(8*Q1,0,1.5) + vpaintegral(16*Q1,1.5,5.381) +...
    vpaintegral(8*Q1,5.381,5.881) + vpaintegral(16*Q1,5.881,9.631));
phi1(x) = int(dphi1);

%Case 2: P == 15-----------------------------------------------------------
Mx2 = 5 * z_bar + 15 * (1.875 - z_bar);
q2 = Mx2/(2 * A_hat);
Q2 = q2/G;

syms x dphi2 phi2

dphi2(x) = (1/(2 * A_hat)) * (vpaintegral(8*Q2,0,1.5) + vpaintegral(16*Q2,1.5,5.381) +...
    vpaintegral(8*Q2,5.381,5.881) + vpaintegral(16*Q2,5.881,9.631));
phi2(x) = int(dphi2);

%Case 3: P == Pmax---------------------------------------------------------
Mx3 = 5 * z_bar + Pmax * (1.875 - z_bar);
q3 = Mx3/(2 * A_hat);
Q3 = q3/G;

syms x dphi3 phi3

dphi3(x) = (1/(2 * A_hat)) * (vpaintegral(8*Q3,0,1.5) + vpaintegral(16*Q3,1.5,5.381) +...
    vpaintegral(8*Q3,5.381,5.881) + vpaintegral(16*Q3,5.881,9.631));
phi3(x) = int(dphi3);

%Theta matrix--------------------------------------------------------------
theta = [phi1(x0) * (180/pi);
    phi2(x0) * (180/pi);
    phi3(x0) * (180/pi)];
end

