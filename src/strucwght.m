function weight = strucwght(alldata)
% strucwght - estimates structure weight before glue using values from the
% spreadsheet
%FORMAT: weight = strucwght(alldata)

% Copyright (C) 2021  Josh McClure
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

% November 8, 2021 07:26:14 PM CST

% NOTICE: This source code is Copyright (C) 2021  Josh McClure and is
% intended for AE525 Instructor/Grader use only. If you obtain this
% document in error destroy it immediately.

% Pulls the needed data matrix out of the alldata matrix
a = alldata{1,1};

% Stores all of the specwght values from the a matrix
specwght = a(:,6);

% Stores the values of volume for each element
vol = a(:,7);

% Initialize weight
weight(1,1) = 0;

% Calculates the total weight and the weight of each component
for i = 1:length(specwght)
    if ~isnan(vol(i,1)) && ~isnan(specwght(i,1))
        % Calculates total weight
        weight(1,1) = weight(1,1) + (vol(i,1)/1728)*specwght(i,1);
        
        % Calculates weight of individual pieces
        weight(i,1) = (vol(i,1)/1728)*specwght(i,1);
    end
end
end