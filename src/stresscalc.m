function stressmax = stresscalc(alldata,stressmaxlocal,pmax)
% stresscalc - a function which calculates the stress at a point on the
% fixed end of a single celled advanced aerospace beam at two locations in
% the cross section defined in stressmaxlocal. The equation is as follows:
%                [E*(P+P^T) ] [y*E*{(Mz-Mz^T)(Iyy*) + (My+My^T)(Iyz*)}
%sigmaxx(x,y,z)= [----------]-[----{---------------------------------}
%                [E_R*A_star] [E_R { I~*                             }
%
%                [z*E*{(My+My^T)(Izz*) + (Mz-Mz^T)(Iyz*)}
%               +[----{---------------------------------}-E*a*deltaT
%                [E_R { I~*                             }
% where deltaT = 0,Mz^T = My^T = P^T = 0, because we are assuming no change
% in temperature.
% P is the internal load along the X-Axis in the x direction         (lbf)
% My is the internal moment about the Y-Axis                      (lbf*in)
% Mz is the internal moment about the Z-Axis                      (lbf*in)
% A_star is the modulus weighted area of the cross section          (in^2)
% Iyy* is the Modulus weighted Moment of Inertia about the Y-Axis   (in^4)
% Izz* is the Modulus weighted Moment of Inertia about the Z-Axis   (in^4)
% Iyz* is the Modulus weighted Product of Inertia                   (in^4)
% I~* is (Iyy*)(Izz*)-(Iyz*)^2                                      (in^8)
% y is a value along the Y-Axis (centroidal coord system)             (in)
% z is a value along the Z-Axis (centroidal coord system)             (in)
% deltaT is a change in temperature                                   (°F)
% My^T is the internal moment caused by deltaT                    (lbf*in)
% Mz^T is the internal moment caused by deltaT                    (lbf*in)
% P^T is the internal load caused by deltaT                          (lbf)
% sigmaxx is the stress at a location(Centroidal coord system)  (lbf/in^2)
%FORMAT: stressmax = stresscalc(alldata,stressmaxlocal,pmax)

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

% November 20, 2021 12:33:21 PM CST

% NOTICE: This source code is Copyright (C) 2021  Kale Macormic and is
% intended for AE525 Instructor/Grader use only. If you obtain this
% document in error destroy it immediately.

% Alert User of progress
fprintf('Determining Magnitude of Stresses on Top and Bottom Surfaces...\n')

% Obtain required values from alldata
P = pmax; %(lbf) (not p from above this is technically Vy (pmax)
% My = 0; %BUGBUG-- need way to integrate
% Mz = 0; %BUGBUG-- HARDCODED BELOW IN EQN (-P+5)*(x-45.625), where x is zero
% A_star = alldata{2}(8);
Iyy_star = alldata{2}(3);
% Izz_star = alldata{2}(4);
Iyz_star = alldata{2}(5);
Itilda_star = alldata{2}(6);
Etop = alldata{1}(1,1);
Ebot = alldata{1}(2,1);
ER = alldata{2}(7);

% Obtain locations from stressmaxlocal
ytop = stressmaxlocal(1);
ztop = stressmaxlocal(2);
ybot = stressmaxlocal(3);
zbot = stressmaxlocal(4);

% Calculate the maximum bending stress at the top
sigmaxxtop = (Etop/(ER*Itilda_star))*(-P+5)*(-45.625)*(ztop*Iyz_star-ytop*Iyy_star);


% Calculate the maximum bending stress at the bottom
sigmaxxbot = (Ebot/(ER*Itilda_star))*(-P+5)*(-45.625)*(zbot*Iyz_star-ybot*Iyy_star);

% determine the highest sigmaxx
if sigmaxxtop > sigmaxxbot
    stressmax = sigmaxxtop;
else
    stressmax = sigmaxxbot;
end

% Obtain hardcoded values of stringers from alldata for below
ytopstring = alldata{6}(7,1) + abs(alldata{2}(1)); % Top most stringer closest to LE
ztopstring = alldata{6}(7,2) + abs(alldata{2}(2)); % Top most stringer closest to LE
ybotstring = alldata{6}(19,1) + abs(alldata{2}(1)); % Bottom most stringer closest to LE
zbotstring = alldata{6}(19,2) + abs(alldata{2}(2)); % Bottom most stringer closest to LE
Estring = alldata{1}(7,1); % (ksi) (it cancels with ER which is also in ksi)
sigmamaxtop = alldata{1}(:,3)*1000; % Maximum Compressive Strength of stringer (psi)
sigmamaxbot = alldata{1}(:,2)*1000; % Maximum Tensile Strength of stringer     (psi)

% Hardcode a sanity check for now to verify if the stress in the stringers
% is lessthan the material properties
sigmaxxstringtop = (Estring/(ER*Itilda_star))*(-P+5)*(-45.625)*(ztopstring*Iyz_star-ytopstring*Iyy_star);
sigmaxxstringbot = (Estring/(ER*Itilda_star))*(-P+5)*(-45.625)*(zbotstring*Iyz_star-ybotstring*Iyy_star);

% Check to see if the stresses are greaterthan the material properties, 
% Scream Bloody Murder into the command window if it is not.
if sigmaxxstringtop >= sigmamaxtop
    fprintf('WARNING: TOP STRINGERS FAIL BEFORE SKIN, PREDICTED PMAX TOO HIGH')
elseif sigmaxxstringbot >= sigmamaxbot
    fprintf('WARNING: BOTTOM STRINGERS FAIL BEFORE SKIN, PREDICTED PMAX TOO HIGH')
end

% Alert user of progress
fprintf('Magnitude of Stresses Found.\n\n')
end