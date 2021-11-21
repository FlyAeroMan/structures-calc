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
ybar = abs(alldata{3}(1));
zbar = abs(alldata{3}(2));
lengthtop = alldata{4}(1,3)-alldata{4}(2,3)-0.25;

% initialize xprime for later
xprime = Xo;

% Calculate force in Top Skin:
Ftopskin = ((tskin*((pmax-5)*xprime)*Etop)/(ER*Itilda_star))*(Iyz_star*((lengthtop^2/2)-(3.5-zbar)*lengthtop)-ybar*Iyy_star*lengthtop);
end