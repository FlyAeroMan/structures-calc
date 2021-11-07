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

% November 6, 2021 05:58:07 PM CDT

% NOTICE: This source code is Copyright (C) 2021  Kale Macormic and is
% intended for AE525 Instructor/Grader use only. If you obtain this
% document in error destroy it immediately.

% initialize environment
clear all
close all
clc

%% should be a callable function
% use xlsread to bring the cross section data into MATLAB after asking for
% its location using uigetfile
[file,path] = uigetfile('*.xlsx');
data = xlsread(sprintf('%s%s',path,file));

% obtain the required information from data and store it in variables to
% ease calculations later and enhance code readabilty
area = data(15,2);
ybar = data(2,16);
zbar = data(2,17);
Iyy = data(2,18);
Izz = data(2,19);
Iyz = data(2,20);
Itilda = data(2,21);
% yeild = data(,);
% ultimate = data(,);
% modulus = data(,);
% poisson = data(,);
% shearmodulus = data(,);
% and other material properties in the spreadsheet

%% 
% Calculate Deflection
% [u,v,w] = deflection(area,ybar,...,Itilda)

% Calculate torsion
% [phi,x] = torsion(area,ybar,...,Itilda)

% Calculate neutral axis
% [x,y,z] = neutral(area,ybar,...,Itilda)

% etc

% Generate beutiful Plots
% plots(phi,u,v,w,x,y,z,etc)