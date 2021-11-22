function riblocal = bucklingcalc(alldata,pmax)
% bucklingcalc - a function to calculate the rib spacing to prevent
% buckling of the structure until the predicted failure load pmax
%FORMAT: riblocal = bucklingcalc(alldata,pmax)

% Alert User of Progress
fprintf('Determining Rib spacing...\n')

% Obtain values from alldata
thickskin = alldata{6}(1,3); %                         (in)
stringerwidth = alldata{6}(2,3); %                 (in)
sparwidth = alldata{6}(3,3); %                     (in)
topstringercount = alldata{6}(4,3);
botstringercount = alldata{6}(5,3);
Xo = alldata{5}(2,10); %                           (in)
Etop = alldata{1}(1,1)*1000; %                     (psi)
Ebot = alldata{1}(2,1)*1000; %                     (psi)
ER = alldata{2}(7)*1000; %                         (psi)
Itilda_star = alldata{2}(6); %                     (in^8)
Iyy_star = alldata{2}(3); %                        (in^4)
Iyz_star = alldata{2}(5); %                        (in^4)
ybar = alldata{3}(1); %                            (in)
zbar = alldata{3}(2); %                            (in)
lengthtop = alldata{4}(1,3)-alldata{4}(2,3)-0.25; %(in)
lengthbot = sqrt(1+lengthtop^2);%                  (in)

% Define starting and stopping points of the length of the top skin (less
% the spars)
zLETop = abs(zbar)-sparwidth;
yLETop = abs(ybar)+(thickskin/2);
zTETop = abs(zbar)-sparwidth-lengthtop;
yTETop = abs(ybar)+(thickskin/2);

% Define starting and stopping points of the lengthof the bottom skin (less
% the spars)
zLEBot = abs(zbar)-sparwidth;
yLEBot = abs(ybar)-1.4990086973; %BUGBUG-- retrieve from alldata?
zTEBot = abs(zbar)-sparwidth-lengthtop;
yTEBot = abs(ybar)-0.565675364; %BUGBUG-- retrieve from alldata?

% initialize loop vars
xprime = Xo;
itr = 1;
imaginary = false;

% Calculate the rib spacing needed for the top surface
while xprime > 1 && imaginary == false
% Calculate the bending stress at the LE and TE of the top skin
sigmaxxLE = (Etop/(ER*Itilda_star))*(-pmax+5)*(-xprime)*(zLETop*Iyz_star-yLETop*Iyy_star);
sigmaxxTE = (Etop/(ER*Itilda_star))*(-pmax+5)*(-xprime)*(zTETop*Iyz_star-yTETop*Iyy_star);

% Calculate force in Top Skin:
Ftopskin = thickskin*lengthtop*((sigmaxxLE + sigmaxxTE)/2);

% Hardcoding the centroid location of the stringers
%yTopStringercentroid1 = abs(ybar)+0.25; %BUGBUG-- retrieve stringer centroid from alldata
%zTopStringercentroid1 = abs(zbar)-0.0625; %BUGBUG-- retrieve stringer centroid from alldata
% ADD MORE STRINGERS AS REQUIRED

% Calculating stress at the centroid
%sigmaxxTopStringer1 = (Etop/(ER*Itilda_star))*(-pmax+5)*(-xprime)*(zTopStringercentroid1*Iyz_star-yTopStringercentroid1*Iyy_star);
% ADD MORE STRINGERS AS REQUIRED

% Calculate force in stringer:
%Ftopstringer1 = sigmaxxTopStringer1*0.125^2;
%Ftopstringer = Ftopstringer1; % + Ftopstringer2;
Ftopstringer = 0;

% Calculate Nx
Nx = (1/lengthtop)*(Ftopskin+Ftopstringer);

% Calculate a, the spacing between the ribs in inches
s = lengthtop/(topstringercount +1);
x = (((12*Nx*lengthtop^4)*(s-stringerwidth+stringerwidth*(thickskin/(thickskin+stringerwidth))^3))/(pi^2*Etop*s*thickskin^3))-2*lengthtop^2;
v = lengthtop^4;
aone = sqrt((-x+sqrt(x^2-4*v))/(2));
atwo = sqrt((-x-sqrt(x^2-4*v))/(2));

% Check to see if the above numbers are imaginary, if so exit this loop as
% the distance between ribs cannot be negative, the user should add more
% stringers to support their design.
if ~(isreal(aone))
    imaginary = true;
    fprintf('WARNING: ADD STRINGERS TO THE TOP SURFACE!\n')
elseif ~(isreal(atwo))
    imaginary = true;
    fprintf('WARNING: ADD STRINGERS TO THE TOP SURFACE!\n')
end

% Determine the smaller value of a and call it ribspacing
if aone < atwo
    temp = aone*4;
    temp = round(temp)/4;
    topriblocal(itr) = temp;
    xprime = xprime - temp;
else
    temp = atwo*4;
    temp = round(temp)/4;
    topriblocal(itr) = temp;
    xprime = xprime - temp;
end
itr = itr + 1;
end

% Reset vars---------------------------------------------------------------
xprime = Xo;
itr = 1;
imaginary = false;

% Calculate the rib spacing needed for the bottom surface
while xprime > 1 && imaginary == false
% Calculate the bending stress at the LE and TE of the top skin
sigmaxxLE = (Ebot/(ER*Itilda_star))*(-pmax+5)*(-xprime)*(zLEBot*Iyz_star-yLEBot*Iyy_star);
sigmaxxTE = (Ebot/(ER*Itilda_star))*(-pmax+5)*(-xprime)*(zTEBot*Iyz_star-yTEBot*Iyy_star);

% Calculate force in Bottom Skin:
Fbotskin = thickskin*lengthtop*((sigmaxxLE + sigmaxxTE)/2);

% Hardcoding the centroid location of the stringers
yBotStringercentroid1 = alldata{6}(22,1);
zBotStringercentroid1 = alldata{6}(22,2);
% ADD MORE STRINGERS AS REQUIRED

% Calculating stress at the centroid
sigmaxxBotStringer1 = (Etop/(ER*Itilda_star))*(-pmax+5)*(-xprime)*(zBotStringercentroid1*Iyz_star-yBotStringercentroid1*Iyy_star);
% ADD MORE STRINGERS AS REQUIRED

% Calculate force in stringer:
Fbotstringer1 = sigmaxxBotStringer1*0.125*0.375;
Fbotstringer = Fbotstringer1; % + Fbotstringer2;
% Fbotstringer = 0;

% Calculate Nx
Nx = (1/lengthbot)*(Fbotskin+Fbotstringer);

% Calculate a, the spacing between the ribs in inches
s = lengthbot/(botstringercount +1);
x = (((12*Nx*lengthbot^4)*(s-stringerwidth+stringerwidth*(thickskin/(thickskin+stringerwidth))^3))/(pi^2*Ebot*s*thickskin^3))-2*lengthbot^2;
v = lengthbot^4;
aone = sqrt((-x+sqrt(x^2-4*v))/(2));
atwo = sqrt((-x-sqrt(x^2-4*v))/(2));

% Check to see if the above numbers are imaginary, if so exit this loop as
% the distance between ribs cannot be negative, the user should add more
% stringers to support their design.
if ~(isreal(aone))
    imaginary = true;
    fprintf('WARNING: ADD STRINGERS TO THE BOTTOM SURFACE!\n')
elseif ~(isreal(atwo))
    imaginary = true;
    fprintf('WARNING: ADD STRINGERS TO THE BOTTOM SURFACE!\n')
end

% Determine the smaller value of a and call it ribspacing
if aone < atwo
    temp = aone*4;
    temp = round(temp)/4;
    botriblocal(itr) = temp;
    xprime = xprime - temp;
else
    temp = atwo*4;
    temp = round(temp)/4;
    botriblocal(itr) = temp;
    xprime = xprime - temp;
end
itr = itr + 1;
end

% Determine which surface requires more ribs and output that
% Inform the user of that decision
if length(botriblocal) > length(topriblocal)
    riblocal = botriblocal;
    fprintf('The Number of Ribs is based on the BOTTOM SKIN\n')
else
    riblocal = topriblocal;
    fprintf('The Number of Ribs is based on the TOP SKIN\n')
end

%Alert User of Progress
fprintf('Rib Spacing determined.\n\n')
end