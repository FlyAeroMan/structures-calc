% StructuresCalc - a program that calculates deflection, stress, and other
% useful values for a beam whose cross section defined by a spreadsheet
% which also contains its length

% Kale Macormic, et. al.
% Copyright Kale Macormic 2021
% AE525 Final Project
% November 6, 2021 11:06:35 AM CDT

% NOTICE: This source code is Kale Macormic proprietary information and is
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