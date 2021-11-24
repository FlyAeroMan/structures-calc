% StructuresCalc - a program that calculates deflection, stress, and other
% useful values for a beam whose atributes are defined by a spreadsheet
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

% November 20, 2021 02:22:55 PM CST

% NOTICE: This source code is Copyright (C) 2021  Kale Macormic and is
% intended for AE525 Instructor/Grader use only. If you obtain this
% document in error destroy it immediately.

% initialize environment
clear all
close all
clc

% Use datafromsheet to collect all the data from the sheet and store it in
% alldata
alldata = datafromsheet;

% Calculate pmax
[pmax,stressmaxlocal] = findpmax(alldata);

% Calculate the stress at pmax
stressmax = stresscalc(alldata,stressmaxlocal,pmax);

% Calculate Rib Spacing
riblocal = bucklingcalc(alldata,pmax);

% Calculate Deflection
[u,v,w] = deflection(pmax,alldata)

% Calculate angle of twist
theta = torsion(pmax,alldata)


% Calculate the Weight of the Structure
weight = strucwght(alldata);

% Generate beutiful Plots
% plots(phi,u,v,w,x,y,z,etc)
