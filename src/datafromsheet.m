function alldata = datafromsheet
% datafromsheet - a function which grabs all the relavent data from section
% properties.xlsx. This function creates alldata a cell array of matricies 
% containing all values required for computations of the form:
%
% All material properties for each area "i" are in alldata{1}
% alldata{1}(:,1) => Modulus (ksi)
% alldata{1}(:,2) => Ultimate TENSILE Strength (ksi)
% alldata{1}(:,3) => Ultimate COMPRESSIVE Strength (ksi)
% alldata{1}(:,4) => Poisson's Ratio (unitless)
% alldata{1}(:,5) => Shear Modulus (ksi)
% alldata{1}(:,6) => Specific Weight (lbf/ft^3)
% alldata{1}(:,7) => Volume (in^3)
% % All Modulus Weighted Cross Sectional Properties are in alldata{2}
% alldata{2}(1) => ybar* (in)
% alldata{2}(2) => zbar* (in)
% alldata{2}(3) => Iyy* (in^4)
% alldata{2}(4) => Izz* (in^4)
% alldata{2}(5) => Iyz* (in^4)
% alldata{2}(6) => I~* (in^4)
% alldata{2}(7) => ER (ksi)
% alldata{2}(8) => A* (in^2)
% % All Cross Sectional Properties are in alldata{3}
% alldata{3}(1) => ybar (in)
% alldata{3}(2) => zbar (in)
% alldata{3}(3) => Iyy (in^4)
% alldata{3}(4) => Izz (in^4)
% alldata{3}(5) => Iyz (in^4)
% alldata{3}(6) => I~ (in^4)
% alldata{3}(7) => A (in^2)
% % All Rib Locations and skin boundaries are in alldata{4}
% alldata{4}(:,1) => Rib location if avaliable, no limit (in)
% alldata{4}(1,2) => LE Top Skin y Location (in)
% alldata{4}(1,3) => LE Top Skin z Location (in)
% alldata{4}(1,4) => LE Bottom Skin y Location (in)
% alldata{4}(1,5) => LE Bottom Skin z Location (in)
% alldata{4}(2,2) => TE Top Skin y Location (in)
% alldata{4}(2,3) => TE Top Skin z Location (in)
% alldata{4}(2,4) => TE Bottom Skin y Location (in)
% alldata{4}(2,5) => TE Bottom Skin z Location (in)
% All End Loads and Locations, as well as beam length are in alldata{5}
% alldata{5}(:,1) => End Loads in the X Direction (lbf)
% alldata{5}(:,2) => Y Position along the Y-Axis (in)
% alldata{5}(:,3) => Z Position along the Z-Axis (in)
% alldata{5}(:,4) => End Loads in the Y Direction (lbf)
% alldata{5}(:,5) => Y Position along the Y-Axis (in)
% alldata{5}(:,6) => Z Position along the Z-Axis (in)
% alldata{5}(:,7) => End Loads in the Z Direction (lbf)
% alldata{5}(:,8) => Y Position along the Y-Axis (in)
% alldata{5}(:,9) => Z Position along the Z-Axis (in)
% alldata{5}(1,10) => Length of the beam in X (in)
% alldata{5}(2,10) => X position of End Loads (in)
% All Dimensions of components of the cross section and their centroidal
% locations are in alldata{6}
% alldata{6}(:,1) => y'i of each component of the cross section (in)
% alldata{6}(:,2) => z'i of each component of the cross section (in)
% alldata{6}(1,3) => Skin Thickness
% alldata{6}(2,3) => Stringer Width (assumed square)
% alldata{6}(3,3) => Spar Width (along top/bottom surfaces)
% alldata{6}(4,3) => Top Skin Stringer Count
% alldata{6}(5,3) => Bottom Skin Stringer Count
%
% Note: ALL CHANGES to the spreadsheet require updates to this function.
%
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

% November 21, 2021 09:56:35 PM CST

% NOTICE: This source code is Copyright (C) 2021  Kale Macormic and is
% intended for AE525 Instructor/Grader use only. If you obtain this
% document in error destroy it immediately.

% Alert User of progress
fprintf('Gathering Data from spreadsheet...\n')

% use xlsread to bring the cross section data into MATLAB after asking for
% its location using uigetfile
[file,path] = uigetfile('*.xlsx');
data = xlsread(sprintf('%s%s',path,file));
fprintf('%s\n',file)

% obtain the required information from data and store it in alldata to
% ease calculations later and enhance code readabilty
% All material properties for each area "i" are in alldata{1}
alldata{1}(:,1) = data(1:28,15); % Modulus (ksi)
alldata{1}(:,2) = data(1:28,25); % Ultimate TENSILE Strength (ksi)
alldata{1}(:,3) = data(1:28,26); % Ultimate COMPRESSIVE Strength (ksi)
alldata{1}(:,4) = data(1:28,27); % Poisson's Ratio (unitless)
alldata{1}(:,5) = data(1:28,28); % Shear Modulus (ksi)
alldata{1}(:,6) = data(1:28,29); % Specific Weight (lbf/ft^3)
alldata{1}(:,7) = data(1:28,30); % Volume (in^3)
% All Modulus Weighted Cross Sectional Properties are in alldata{2}
alldata{2}(1) = data(4,33); % ybar* (in)
alldata{2}(2) = data(4,34); % zbar* (in)
alldata{2}(3) = data(4,35); % Iyy* (in^4)
alldata{2}(4) = data(4,36); % Izz* (in^4)
alldata{2}(5) = data(4,37); % Iyz* (in^4)
alldata{2}(6) = data(4,38); % I~* (in^4)
alldata{2}(7) = data(6,33); % ER (ksi)
alldata{2}(8) = data(29,17); % A* (in^2)
% All Cross Sectional Properties are in alldata{3}
alldata{3}(1) = data(2,33); % ybar (in)
alldata{3}(2) = data(2,34); % zbar (in)
alldata{3}(3) = data(2,35); % Iyy (in^4)
alldata{3}(4) = data(2,36); % Izz (in^4)
alldata{3}(5) = data(2,37); % Iyz (in^4)
alldata{3}(6) = data(2,38); % I~ (in^4)
alldata{3}(7) = data(29,2); % A (in^2)
% All Rib Locations and skin boundaries are in alldata{4}
alldata{4}(:,1) = data(:,31); % Rib location if avaliable, no limit (in)
alldata{4}(1,2) = data(9,33); % LE Top Skin y Location (in)
alldata{4}(1,3) = data(9,34); % LE Top Skin z Location (in)
alldata{4}(1,4) = data(9,35); % LE Bottom Skin y Location (in)
alldata{4}(1,5) = data(9,36); % LE Bottom Skin z Location (in)
alldata{4}(2,2) = data(11,33); % TE Top Skin y Location (in)
alldata{4}(2,3) = data(11,34); % TE Top Skin z Location (in)
alldata{4}(2,4) = data(11,35); % TE Bottom Skin y Location (in)
alldata{4}(2,5) = data(11,36); % TE Bottom Skin z Location (in)
% All End Loads and Locations, as well as beam length are in alldata{5}
alldata{5}(:,1) = data(1:28,40); % End Loads in the X Direction (lbf)
alldata{5}(:,2) = data(1:28,41); % Y Position along the Y-Axis (in)
alldata{5}(:,3) = data(1:28,42); % Z Position along the Z-Axis (in)
alldata{5}(:,4) = data(1:28,43); % End Loads in the Y Direction (lbf)
alldata{5}(:,5) = data(1:28,44); % Y Position along the Y-Axis (in)
alldata{5}(:,6) = data(1:28,45); % Z Position along the Z-Axis (in)
alldata{5}(:,7) = data(1:28,46); % End Loads in the Z Direction (lbf)
alldata{5}(:,8) = data(1:28,47); % Y Position along the Y-Axis (in)
alldata{5}(:,9) = data(1:28,48); % Z Position along the Z-Axis (in)
alldata{5}(1,10) = data(1,49); % Length of the beam in X (in)
alldata{5}(2,10) = data(3,49); % X position of End Loads (in)
% All Dimensions of components of the cross section and their centroidal
% locations are in alldata{6}
alldata{6}(:,1) = data(1:28,3); % y'i of each component of the cross section (in)
alldata{6}(:,2) = data(1:28,4); % z'i of each component of the cross section (in)
alldata{6}(1,3) = data(14,33); % Skin Thickness
alldata{6}(2,3) = data(14,34); % Stringer Width (assumed square)
alldata{6}(3,3) = data(14,35); % Spar Width (along top/bottom surfaces)
alldata{6}(4,3) = data(14,36); % Top Skin Stringer Count
alldata{6}(5,3) = data(14,37); % Bottom Skin Stringer Count

% Alert user of progress
fprintf('Data Gathered.\n\n')
end