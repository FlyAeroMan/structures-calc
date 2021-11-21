function riblocal = bucklingcalc(alldata,pmax)


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

% Calculate the bending stress at the LE and TE of the top skin
sigmaxxLE = (Etop/(ER*Itilda_star))*(-pmax+5)*(-xprime)*(zLE*Iyz_star-yLE*Iyy_star);
sigmaxxTE = (Etop/(ER*Itilda_star))*(-pmax+5)*(-xprime)*(zTE*Iyz_star-yTE*Iyy_star);

% Calculate force in Top Skin:
Ftopskin = tskin*lengthtop*((sigmaxxLE + sigmaxxTE)/2);
%Ftopskin1 = ((tskin*((pmax-5)*xprime)*Etop)/(ER*Itilda_star))*(Iyz_star*((lengthtop^2/2)-(3.5-zbar_star)*lengthtop)-ybar_star*Iyy_star*lengthtop);
%Ftopskin2 = ((tskin*((pmax-5)*xprime)*Etop)/(ER*Itilda_star))*(Iyz_star*((lengthtop^2/2)-(3.5-zbar)*lengthtop)-ybar*Iyy_star*lengthtop);

% Hardcoding the centroid location of the stringers
yTopStringercentroid = abs(ybar)+0.25;
zTopStringercentroid = abs(zbar)-0.0625;

% Calculating stress at the centroid
sigmaxxTopStringer = (Etop/(ER*Itilda_star))*(-pmax+5)*(-xprime)*(zTopStringercentroid*Iyz_star-yTopStringercentroid*Iyy_star);

% Calculate force in stringer:
Ftopstringer = sigmaxxTopStringer*0.125*0.375;

% calculate Nx and Ncr
Nx = (1/lengthtop)*(Ftopskin+Ftopstringer);
%Ncr = 
end