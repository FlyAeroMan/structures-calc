function [m,b] = neutralaxis(alldata)
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
%FORMAT: alldata = datafromsheet

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

% November 7, 2021 04:55:30 PM CST

% NOTICE: This source code is Copyright (C) 2021  Kale Macormic and is
% intended for AE525 Instructor/Grader use only. If you obtain this
% document in error destroy it immediately.

% Obtain the required values from alldata
P = 0; % BUGBUG----(P isnt defined in the spreadsheet, so I am hardcoding
My = 0; % BUGBUG----(My isnt defined in the spreadsheet, so I am hardcoding
Mz = 1; % BUGBUG----(Mz isnt defined in the spreadsheet, so I am hardcoding
A_star = alldata{}(,);
Iyy_star = alldata{}(,);
Izz_star = alldata{}(,);
Iyz_star = alldata{}(,);
Itilda_star = alldata{}(,);

% calculate the slope "m" and the z intercept "b"
m = (Mz*(Iyy_star) + My*(Iyz_star))/(My*(Izz_star) + Mz*(Iyz_star));
b = (P*Itilda_star)/(Ai*(My(Izz_star) + Mz(Iyz_star))); % Due to Bug, this will always be 0
end