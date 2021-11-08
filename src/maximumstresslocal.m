function [stressmaxlocal] = maximumstresslocal(alldata,m,b)
% maximumstresslocal - a function which calculates the location of the
% maximum stress in an arbitrary cross section at location x. This function
% assumes that the neutral axis DOES NOT CHANGE in x, which may not be true
% under some loading conditions.
% It is known that the location of maximum stress occurs the farthest away
% from the neutral axis since the neutral axis is the "line" where there is
% no stress in the cross section during bending. This line is where the
% internal stresses in the beam change from tension to compression or vise
% versa. 
% For example:
%    ________z|_________
%   |         |         |
%   |         |         |
%   |         |         |
%   |         |---------|-----
%   |                   |    y
%   |                   |
%   |___________________|
%
% In the above cross section, the neutral axis is the Y-Axis, if the end
% load is in the positive Z direction because in the center of the 
% rectangular beam there is under neither tensile nor compressive forces.
% In this example, the locations of maximum stress would be located along
% the entire top and bottom surfaces. In the present code, the 
% cross-section will not be as simple and the neutral axis depends on the 
% loading case making it necessary to develop a method to find the location
% farthest away from the neutral axis.
%FORMAT: [stressmaxlocal] = maximumstresslocal(alldata,m,b)

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
fprintf('Determining the locations of Maximum Stress in an arbitrary cross section somewhere along the beam...\n')

% Obtain the required values from alldata


% Construct the Top and Bottom surfaces (assuming they are linear lines)
% in the centroidal axis system


% Find the point on the Top surface that is the farthest away from the
% neutral axis
% [some mathy code bits here]

% For the top surface:
stressmaxlocal(1) = 0; % y value of maximum stress in centroidal axes      -->Temp note: mathy code bits above will determine the value now written as 0
stressmaxlocal(2) = 0; % z value of maximum stress in centroidal axes      -->Temp note: mathy code bits above will determine the value now written as 0

% Find the point on the Bottom surface that is the farthest away from the
% neutral axis
% [some mathy code bits here]

% For the bottom surface:
stressmaxlocal(3) = 0; % y value of maximum stress in centroidal axes      -->Temp note: mathy code bits above will determine the value now written as 0
stressmaxlocal(4) = 0; % z value of maximum stress in centroidal axes      -->Temp note: mathy code bits above will determine the value now written as 0

% Generate a Plot showing the Top, Bottom, Front, and Back surfaces and
% the points of maximum stress for visual review


% Alert User of progress
fprintf('The locations of Maximum Stress in an arbitrary cross section somewhere along the beam Found.\n')
end











