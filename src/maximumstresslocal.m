function [stressmaxlocal] = maximumstresslocal(alldata,mneutral,bneutral)
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
%FORMAT: [stressmaxlocal] = maximumstresslocal(alldata,mneutral,bneutral)

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

% Obtain the required values from alldata in auxillary axis
LETopY = alldata{4}(1,2); % LE Top Skin y Location (in)
LETopZ = alldata{4}(1,3); % LE Top Skin z Location (in)
LEBotY = alldata{4}(1,4); % LE Bottom Skin y Location (in)
LEBotZ = alldata{4}(1,5); % LE Bottom Skin z Location (in)
TETopY = alldata{4}(2,2); % TE Top Skin y Location (in)
TETopZ = alldata{4}(2,3); % TE Top Skin z Location (in)
TEBotY = alldata{4}(2,4); % TE Bottom Skin y Location (in)
TEBotZ = alldata{4}(2,5); % TE Bottom Skin z Location (in)

% Convert the edge values from the auxillary axis to the centroidal axis 
% system.
ybar = abs(alldata{3}(1)); % absolute value of ybar (in)
zbar = abs(alldata{3}(2)); % absolute value of zbar (in)
LETopY = LETopY + ybar;
LETopZ = LETopZ + zbar;
LEBotY = LEBotY + ybar;
LEBotZ = LEBotZ + zbar;
TETopY = TETopY + ybar;
TETopZ = TETopZ + zbar;
TEBotY = TEBotY + ybar;
TEBotZ = TEBotZ + zbar;

% Construct the Top and Bottom surfaces (assuming they are linear lines)
% in the centroidal axis system
% We will assume that the surface between each point is linear, therefore
% the slope of the top surface will be mtop, the slope of the bottom will
% be mbot, the slope of the Leading Edge (LE) will be mLE, and the slope of
% the Trailing Edge (TE) will be mTE.
mtop = (LETopZ-TETopZ)/(LETopY-TETopY);
mbot = (LEBotZ-TEBotZ)/(LEBotY-TEBotY);
mLE = (LETopZ-LEBotZ)/(LETopY-LEBotY);
mTE = (TETopZ-TEBotZ)/(TETopY-TEBotY);

% Declaring variables which indicate if a surface's slope is infinite later
mtopinf = false;
mbotinf = false;
mLEinf = false;
mTEinf = false;
mneutralinf = false;

% We must check to see if any surfaces are vertical (slope is infinity)
if mtop == Inf
    mtopinf = true;
end
if mbot == Inf
    mbotinf = true;
end
if mLE == Inf
    mLEinf = true;
end
if mTE == Inf
    mTEinf = true;
end
if mneutral == Inf
    mneutralinf = true;
end

% in order to calculate the z-intercept (b), we must solve for it using the
% following equation: b = z - m*y, where m is the slope and y and z are the
% coordinates of a point:
if mtopinf == true
    % if the slope is infinity, we can skip this step and directly
    % calculate the intersection:
    TopIntersectY = LETopY;
    TopIntersectZ = mneutral * TopIntersectY + bneutral;
    TopIntersectZCheck = TopIntersectZ;
else
    btop = LETopZ - mtop * LETopY;
    
    % We must find the intersection between the neutral axis and the top
    % surface lines and work backwards to find the location of maximum stress.
        TopIntersectY = (bneutral - btop)/(mtop - mneutral);
        TopIntersectZ = mtop * TopIntersectY + btop;
        TopIntersectZCheck = mneutral * TopIntersectY + bneutral;
end
if mbotinf == true
    % if the slope is infinity, we can skip this step and directly
    % calculate the intersection:
    BotIntersectY = LEBotY;
    BotIntersectZ = mneutral * BotIntersectY + bneutral;
    TopIntersectZCheck = BotIntersectZ;
else
    bbot = LEBotZ - mbot * LEBotY;
    
    % We must find the intersection between the neutral axis and the top
    % surface lines and work backwards to find the location of maximum stress.
        BotIntersectY = (bneutral - bbot)/(mbot - mneutral);
        BotIntersectZ = mbot * BotIntersectY + bbot;
        BotIntersectZCheck = mneutral * BotIntersectY + bneutral;
end
% The LE and TE Shouldn't be infinity in this coord system, therefore:
if mLEinf == false && mTEinf == false
bLE = LETopZ - mLE * LETopY;
bTE = TETopZ - mTE * TETopY;
else
    % Alert user if it is infinity
    fprintf('ERROR: TE or LE Infinifty Slope Error. Check Inputs and try again\nWARNING: Unstable solution generated for location of maximum stress on the top surface,\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n')
end

%% Top Surface

% Find the point on the Top surface that is the farthest away from the
% neutral axis
if TopIntersectZ == TopIntersectZCheck
    % We know the location of the LE and TE of the beam's top surface so we
    % must figure out where the intersection occurs: Upstream (1), 
    % Downstream (2), or within the beam/on the surface (3).
    if TopIntersectZ > LETopZ
        TopIntersectLocal = 1;
    elseif TopIntersectZ < TETopZ
        TopIntersectLocal = 2;
    else
        TopIntersectLocal = 3;
    end
    
    % Now we can find the farthest point from the neutral axis on the top
    % surface:
    if TopIntersectLocal == 1
        % in this case we know that regardless of the slopes of the lines,
        % they intersect upstream of the structure, so we should start at
        % the TE, calculate the distance, then move a small increment
        % towards the LE to confirm it is smaller (as a sanity check
        % because it always should be) then proclaim the location is at the
        % TE.
        if mtopinf == false
            ytop = (TETopZ - btop) / mtop;
            ytopsmallstep = ((TETopZ + 0.001) - btop) / mtop;
        else
            ytop = TETopY;
            ytopsmallstep = ytop;
        end
        yneutral = (TETopZ - bneutral) / mneutral;
        yneutralsmallstep = ((TETopZ + 0.001) - bneutral) / mneutral;
        delta = ytop - yneutral;
        deltasmallstep = ytopsmallstep - yneutralsmallstep;
        if abs(delta) > abs(deltasmallstep)
            stressmaxlocal(1) = TETopY;
            stressmaxlocal(2) = TETopZ;
        else
            fprintf('ERROR: Neutral Axis Distance Error, Unable to Verify Farthest Distance From Neutral Axis (Top, Upstream)\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n')
            stressmaxlocal(1) = 0; % written as 0 for stability
            stressmaxlocal(2) = 0; % written as 0 for stability
        end
    elseif TopIntersectLocal == 2
        % in this case we know that regardless of the slopes of the lines,
        % they intersect downstream of the structure, so we should start at
        % the LE, calculate the distance, then move a small increment
        % towards the TE to confirm it is smaller (as a sanity check
        % because it always should be) then proclaim the location is at the
        % LE.
        if mtopinf == false
            ytop = (LETopZ - btop) / mtop;
            ytopsmallstep = ((LETopZ - 0.001) - btop) / mtop;
        else
            ytop = LETopY;
            ytopsmallstep = ytop;
        end
        yneutral = (LETopZ - bneutral) / mneutral;
        yneutralsmallstep = ((LETopZ - 0.001) - bneutral) / mneutral;
        delta = ytop - yneutral;
        deltasmallstep = ytopsmallstep - yneutralsmallstep;
        if abs(delta) > abs(deltasmallstep)
            stressmaxlocal(1) = LETopY;
            stressmaxlocal(2) = LETopZ;
        else
            fprintf('ERROR: Neutral Axis Distance Error, Unable to Verify Farthest Distance From Neutral Axis (Top, Downstream)\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n')
            stressmaxlocal(1) = 0; % written as 0 for stability
            stressmaxlocal(2) = 0; % written as 0 for stability
        end
    else
        % In this case we know that the lines intersect somewhere between
        % the LE and TE. We know when linear lines intersect, the further
        % away we go from the point of intersection the farther they are
        % from each other by observation, therefore if the LE is farther
        % than the point of maximum stress on the top surface is at the
        % LE and vice versa.
        deltaLE = LETopZ-TopIntersectZ;
        deltaTE = TETopZ-TopIntersectZ;
        if abs(deltaLE) > abs(deltaTE)
            stressmaxlocal(1) = LETopY;
            stressmaxlocal(2) = LETopZ;
        else
            stressmaxlocal(1) = TETopY;
            stressmaxlocal(2) = TETopZ;
        end
    end
else
    % Alert User an error has occured:
    fprintf('ERROR: Unable to calculate intersection of neutral axis and Top Surface. Check Inputs and try again\nWARNING: Unstable solution generated for location of maximum stress on the top surface,\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n')
    fprintf('Warning: The Top surface and Neutral Axis May be Parallel!\n')
    
    % For the top surface:
    stressmaxlocal(1) = 0; % written as 0 for stability
    stressmaxlocal(2) = 0; % written as 0 for stability
end
%% Bottom Surface

% Find the point on the Bottom surface that is the farthest away from the
% neutral axis
%if BotIntersectZ == BotIntersectZCheck
    % We know the location of the LE and TE of the beam's bottom surface so we
    % must figure out where the intersection occurs: Upstream (1), 
    % Downstream (2), or within the beam/on the surface (3).
    if BotIntersectZ > LEBotZ
        BotIntersectLocal = 1;
    elseif BotIntersectZ < TEBotZ
        BotIntersectLocal = 2;
    else
        BotIntersectLocal = 3;
    end
    
    % Now we can find the farthest point from the neutral axis on the Bot
    % surface:
    if BotIntersectLocal == 1
        % in this case we know that regardless of the slopes of the lines,
        % they intersect upstream of the structure, so we should start at
        % the TE, calculate the distance, then move a small increment
        % towards the LE to confirm it is smaller (as a sanity check
        % because it always should be) then proclaim the location is at the
        % TE.
        if mbotinf == false
            ybot = (TEBotZ - bbot) / mbot;
            ybotsmallstep = ((TEBotZ + 0.001) - bbot) / mbot;
        else
            ybot = TEBotY;
            ybotsmallstep = ybot;
        end
        yneutral = (TEBotZ - bneutral) / mneutral;
        yneutralsmallstep = ((TEBotZ + 0.001) - bneutral) / mneutral;
        delta = ybot - yneutral;
        deltasmallstep = ybotsmallstep - yneutralsmallstep;
        if abs(delta) > abs(deltasmallstep)
            stressmaxlocal(1) = TEBotY;
            stressmaxlocal(2) = TEBotZ;
        else
            fprintf('ERROR: Neutral Axis Distance Error, Unable to Verify Farthest Distance From Neutral Axis (Bot, Upstream)\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n')
            stressmaxlocal(1) = 0; % written as 0 for stability
            stressmaxlocal(2) = 0; % written as 0 for stability
        end
    elseif BotIntersectLocal == 2
        % in this case we know that regardless of the slopes of the lines,
        % they intersect downstream of the structure, so we should start at
        % the LE, calculate the distance, then move a small increment
        % towards the TE to confirm it is smaller (as a sanity check
        % because it always should be) then proclaim the location is at the
        % LE.
        if mbotinf == false
            ybot = (LEBotZ - bbot) / mbot;
            ybotsmallstep = ((LEBotZ - 0.001) - bbot) / mbot;
        else
            ybot = LEBotY;
            ybotsmallstep = ybot;
        end
        yneutral = (LEBotZ - bneutral) / mneutral;
        yneutralsmallstep = ((LEBotZ - 0.001) - bneutral) / mneutral;
        delta = ybot - yneutral;
        deltasmallstep = ybotsmallstep - yneutralsmallstep;
        if abs(delta) > abs(deltasmallstep)
            stressmaxlocal(3) = LEBotY;
            stressmaxlocal(4) = LEBotZ;
        else
            fprintf('ERROR: Neutral Axis Distance Error, Unable to Verify Farthest Distance From Neutral Axis (Bottom, Downstream)\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n')
            stressmaxlocal(3) = 0; % written as 0 for stability
            stressmaxlocal(4) = 0; % written as 0 for stability
        end
    else
        % In this case we know that the lines intersect somewhere between
        % the LE and TE. We know when linear lines intersect, the further
        % away we go from the point of intersection the farther they are
        % from each other by observation, therefore if the LE is farther
        % than the point of maximum stress on the bottom surface is at the
        % LE and vice versa.
        deltaLE = LEBotZ-BotIntersectZ;
        deltaTE = TEBotZ-BotIntersectZ;
        if abs(deltaLE) > abs(deltaTE)
            stressmaxlocal(3) = LEBotY;
            stressmaxlocal(4) = LEBotZ;
        else
            stressmaxlocal(3) = TEBotY;
            stressmaxlocal(4) = TEBotZ;
        end
    end
% %else
%     % Alert User an error has occured:
%     fprintf('ERROR: Unable to calculate intersection of neutral axis and Bottom Surface. Check Inputs and try again\nWARNING: Unstable solution generated for location of maximum stress on the bot surface,\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n>>>>>>>>>>DO NOT USE THE CURRENT RESULTS<<<<<<<<<<\n')
%     fprintf('Warning: The Bot surface and Neutral Axis May be Parallel!\n')
%     
%     % For the bot surface:
%     stressmaxlocal(3) = 0; % written as 0 for stability
%     stressmaxlocal(4) = 0; % written as 0 for stability
%end
%% Plot


% Generate a Plot showing the Top, Bottom, Front, and Back surfaces and
% the points of maximum stress for visual review
Y = linspace(-3,3,1000);
Zneutral = mneutral * Y + bneutral;
%Ztop = mtop * Y + btop; %BUGBUG---- Should check for inf slope and use
%xline/yline if appropriate for more general cases
Zbot = mbot * Y + bbot;
ZLE = mLE * Y + bLE;
ZTE = mTE * Y + bTE;
%plot(Y,Zneutral,'',Y,Ztop,'',Y,Zbot,'',Y,ZLE,'',Y,ZTE,'') % More general,
%needs data
plot(Y,Zneutral,'-',Y,Zbot,'-',Y,ZLE,'-',Y,ZTE,'-',stressmaxlocal(1),stressmaxlocal(2),'d',stressmaxlocal(3),stressmaxlocal(4),'d')
xline(LETopY);
legend('Neutral Axis','Bottom Surface','Leading Edge','Trailing Edge','Top Maximum Bending Stress','Bottom Maximum Bending Stress','Top Surface')
xlim([-3 3])
ylim([-3 3])

% Alert User of progress
fprintf('The locations of Maximum Stress in an arbitrary cross section somewhere along the beam Found.\n')
end











