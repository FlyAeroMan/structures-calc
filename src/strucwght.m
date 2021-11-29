function weight = strucwght(alldata,numribs)
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

% Stores all of the specific weight values from alldata
specwght = alldata{1}(:,6);

% Stores the volume values for each element
vol = alldata{1}(:,7);

% We know intermediate ribs weight exactly 0.0035lbf each and the two end
% ribs weight 0.0125lbf. 
ribweight = numribs * 0.0035; % Intermediate ribs
ribweight = ribweight + 2*0.0125; % Add end ribs

% Initialize weight
weight(1,1) = 0;

% Calculates the total weight and the weight of each component
for i = 1:length(specwght)
    if ~isnan(vol(i,1)) && ~isnan(specwght(i,1))
        % Calculates total weight
        weight(1,1) = weight(1,1) + (vol(i,1)/1728)*specwght(i,1);
        
        % Calculates weight of individual pieces
        weight(i+1,1) = (vol(i,1)/1728)*specwght(i,1);
    end
end

% add the rib weight as the last row in weight and add it to the total
weight(1,1) = weight(1,1) + ribweight;
weight(length(weight)+1,1) = ribweight;

%TODO: Clean zeros from weight
end