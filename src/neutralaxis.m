function [stressmaxlocal,m,b] = neutralaxis(alldata)
% neutralaxis - a function which calculates the slope "m" and the z
% intercept "b" of the equation "z=my+b" which is the neutral axis of a
% particular cross section. The full equation is as follows:
%     [Mz(Iyy*) + My(Iyz*)]    [P(I~*)                 ]
% Z = [-------------------]y - [-----------------------], where:
%     [My(Izz*) + Mz(Iyz*)]    [A*(My(Izz*) + Mz(Iyz*))]
%
% P is the external end load along the X-Axis in the x direction     (lbf)
% My is the internal moment about the Y-Axis                      (lbf*in)
% Mz is the internal moment about the Z-Axis                      (lbf*in)
% A* is the modulus weighted area of the cross section              (in^2)
% Iyy* is the Modulus weighted Moment of Inertia about the Y-Axis   (in^4)
% Izz* is the Modulus weighted Moment of Inertia about the Z-Axis   (in^4)
% Iyz* is the Modulus weighted Product of Inertia                   (in^4)
% I~* is Iyy*(Izz*)-(Iyz)^2                                         (in^8)
% y is a value along the Y-Axis (centroidal coord system)             (in)
% z is a value along the Z-Axis (centroidal coord system)             (in)
%FORMAT: [stressmaxlocal,m,b] = neutralaxis(alldata)

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

% November 7, 2021 08:14:28 PM CST

% NOTICE: This source code is Copyright (C) 2021  Kale Macormic and is
% intended for AE525 Instructor/Grader use only. If you obtain this
% document in error destroy it immediately.

% Alert User of progress
fprintf('Determining location of Neutral Axes...\n')

% Obtain the required values from alldata
P = alldata{5}(1,1)+alldata{5}(2,1)+alldata{5}(3,1)+alldata{5}(4,1)...
    +alldata{5}(5,1)+alldata{5}(6,1)+alldata{5}(7,1)+alldata{5}(8,1)...
    +alldata{5}(9,1)+alldata{5}(10,1)+alldata{5}(11,1)+alldata{5}(12,1)...
    +alldata{5}(13,1)+alldata{5}(14,1);
My = 0; % BUGBUG----(My isnt calculatable from the spreadsheet, so I am hardcoding
Mz = 1; % BUGBUG----(Mz isnt calculatable from the spreadsheet, so I am hardcoding
A_star = alldata{2}(8); % in^2
Iyy_star = alldata{2}(3); % in^4
Izz_star = alldata{2}(4); % in^4
Iyz_star = alldata{2}(5); % in^4
Itilda_star = alldata{2}(6); % in^8

% calculate the slope "m" and the z intercept "b"
m = (Mz*(Iyy_star) + My*(Iyz_star))/(My*(Izz_star) + Mz*(Iyz_star));
b = (P*Itilda_star)/(A_star*(My*(Izz_star) + Mz*(Iyz_star))); % Due to Bug, this will always be 0

% Alert user of progress
fprintf('Neutral Axis Found.\n')

% We now must call the function which finds the location of maximum stress
% in the cross-section
[stressmaxlocal] = maximumstresslocal(alldata,m,b);
end