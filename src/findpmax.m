function [pmax,stressmaxlocal] = findpmax(alldata)
% findpmax - a function which calculates the maximum magnitude of the P
% endload before failure using the following equation:
%       {Yield                     }
%pmax = {--------------------------} + 5
%       {E(Xo)                     }
%       {-------[z(Iyz*) - y(Iyy*)]}
%       {ER(I~*)                   }
% Many Assumptions used! CAUTION: Use at your Own Risk!
%FORMAT: [pmax,stressmaxlocal] = findpmax(alldata)

% Copyright (C) 2021  Kale Macormic
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

% November 20, 2021 02:05:38 PM CST

% NOTICE: This source code is Copyright (C) 2021  Kale Macormic and is
% intended for AE525 Instructor/Grader use only. If you obtain this
% document in error destroy it immediately.

% Find the location of maximum stress in the cross section
[stressmaxlocal,m,b] = neutralaxis(alldata);

% Alert User of progress
fprintf('Determining magnitude of pmax...\n')

% obtain values from alldata
Etop = alldata{1}(1,1)*1000; %(psi)
Ebot = alldata{1}(2,1)*1000; %(psi)
ER = alldata{2}(7)*1000; %    (psi)
yieldtop = alldata{1}(1,3)*1000; %Compressive  (psi)
yieldbot = alldata{1}(2,2)*1000; %Tensile      (psi)
Iyy_star = alldata{2}(3);
Iyz_star = alldata{2}(5);
Itilda_star = alldata{2}(6);
Xo = alldata{5}(2,10);

% Obtain values from stressmaxlocal
ytop = stressmaxlocal(1);
ztop = stressmaxlocal(2);
ybot = stressmaxlocal(3);
zbot = stressmaxlocal(4);

% Calculate pmax for the top surface
pmaxtop = (yieldtop/(((Etop*Xo)/(ER*Itilda_star))*(ztop*Iyz_star - ytop*Iyy_star)))+5;

% Calculate pmax for the bottom surface
pmaxbot = (yieldbot/(((Ebot*Xo)/(ER*Itilda_star))*(zbot*Iyz_star - ybot*Iyy_star)))+5;

% determine the lower pmax (that is when it will break)
if abs(pmaxtop) < abs(pmaxbot)
    pmax = pmaxtop;
    fprintf('The maximum value of P is limited by the TOP SURFACE\n')
else
    pmax = pmaxbot;
    fprintf('The maximum value of P is limited by the BOTTOM SURFACE\n')
end

% Alert user of progress
fprintf('Magnitude of pmax Found.\n\n')
end