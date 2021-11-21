function riblocal = bucklingcalc(alldata,pmax)
% bucklingcalc - a function to calculate the rib spacing to prevent
% buckling of the structure until the predicted failure load pmax
%FORMAT: riblocal = bucklingcalc(alldata,pmax)

% Alert User of Progress
fprintf('Determining Rib spacing...\n')

% Obtain values from alldata
tskin = 0.0625; %BUGBUG-- should retrieve from alldata
Xo = alldata{5}(2,10);
Etop = alldata{1}(1,1)*1000; %(psi)
Ebot = alldata{1}(2,1)*1000; %(psi)
ER = alldata{2}(7)*1000; %    (psi)
Itilda_star = alldata{2}(6);
Iyy_star = alldata{2}(3);
Iyz_star = alldata{2}(5);
ybar = alldata{3}(1);
% ybar_star = alldata{2}(1);
zbar = alldata{3}(2);
% zbar_star = alldata{2}(2);
lengthtop = alldata{4}(1,3)-alldata{4}(2,3)-0.25;
zLE = abs(zbar)-0.125;
yLE = abs(ybar)+(tskin/2);
zTE = abs(zbar)-0.125-3.5;
yTE = abs(ybar)+(tskin/2);

% initialize xprime for later
xprime = Xo;
itr = 1;

while xprime > 1
% Calculate the bending stress at the LE and TE of the top skin
sigmaxxLE = (Etop/(ER*Itilda_star))*(-pmax+5)*(-xprime)*(zLE*Iyz_star-yLE*Iyy_star);
sigmaxxTE = (Etop/(ER*Itilda_star))*(-pmax+5)*(-xprime)*(zTE*Iyz_star-yTE*Iyy_star);

% Calculate force in Top Skin:
Ftopskin = tskin*lengthtop*((sigmaxxLE + sigmaxxTE)/2);
%Ftopskin1 = ((tskin*((pmax-5)*xprime)*Etop)/(ER*Itilda_star))*(Iyz_star*((lengthtop^2/2)-(3.5-zbar_star)*lengthtop)-ybar_star*Iyy_star*lengthtop);
%Ftopskin2 = ((tskin*((pmax-5)*xprime)*Etop)/(ER*Itilda_star))*(Iyz_star*((lengthtop^2/2)-(3.5-zbar)*lengthtop)-ybar*Iyy_star*lengthtop);

% Hardcoding the centroid location of the stringers
%yTopStringercentroid = abs(ybar)+0.25;
%zTopStringercentroid = abs(zbar)-0.0625;

% Calculating stress at the centroid
%sigmaxxTopStringer = (Etop/(ER*Itilda_star))*(-pmax+5)*(-xprime)*(zTopStringercentroid*Iyz_star-yTopStringercentroid*Iyy_star);

% Calculate force in stringer:
%Ftopstringer = sigmaxxTopStringer*0.125*0.375;
Ftopstringer = 0;

% Calculate Nx
Nx = (1/lengthtop)*(Ftopskin+Ftopstringer);

% Calculate a, the spacing between the ribs in inches
stringercount = 0; %BUGBUG-- Hardcoded Values
stringerwidth = 0.125; %BUGBUG-- Hardcoded Values
s = lengthtop/(stringercount +1);
x = (((12*Nx*lengthtop^4)*(s-stringerwidth+stringerwidth*(tskin/(tskin+stringerwidth))^3))/(pi^2*Etop*s*tskin^3))-2*lengthtop^2;
v = lengthtop^4;
aone = sqrt((-x+sqrt(x^2-4*v))/(2));
atwo = sqrt((-x-sqrt(x^2-4*v))/(2));

% Determine the smaller value of a and call it ribspacing
if aone < atwo
    temp = aone*4;
    temp = round(temp)/4;
    riblocal(itr) = temp;
    xprime = xprime - temp;
else
    temp = atwo*4;
    temp = round(temp)/4;
    riblocal(itr) = temp;
    xprime = xprime - temp;
end
itr = itr + 1;
end

%Alert User of Progress
fprintf('Rib Spacing based off of top surface determined.\n')

end