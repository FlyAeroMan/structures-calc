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

% November 6, 2021 09:07:59 PM CDT

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

% Calculate Deflection
% [u,v,w] = deflection(alldata)

% Calculate angle of twist
% [phi,x] = torsion(alldata)

% Calculate neutral axis
% [x,y,z] = neutral(alldata)

% etc

% Generate beutiful Plots
% plots(phi,u,v,w,x,y,z,etc)