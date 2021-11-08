function theta = torsion(Pmax,z_bar,x0)

A_hat = 4.1171875;
G = 36000;

%%Case 1: P == 0---------------------------------------------------------
Mx1 = 5 * z_bar;
q1 = Mx1/(2 * A_hat);
Q1 = q1/G;

syms x dphi1 phi1

dphi1(x) = (1/(2 * A_hat)) * (vpaintegral(8*Q1,0,1.5) + vpaintegral(16*Q1,1.5,5.381) +...
    vpaintegral(8*Q1,5.381,5.881) + vpaintegral(16*Q1,5.881,9.631));
phi1(x) = int(dphi1);

%%Case 2: P == 15--------------------------------------------------------
Mx2 = 5 * z_bar + 15 * (1.875 - z_bar);
q2 = Mx2/(2 * A_hat);
Q2 = q2/G;

syms x dphi2 phi2

dphi2(x) = (1/(2 * A_hat)) * (vpaintegral(8*Q2,0,1.5) + vpaintegral(16*Q2,1.5,5.381) +...
    vpaintegral(8*Q2,5.381,5.881) + vpaintegral(16*Q2,5.881,9.631));
phi2(x) = int(dphi2);

%%Case 3: P == Pmax------------------------------------------------------
Mx3 = 5 * z_bar + Pmax * (1.875 - z_bar);
q3 = Mx3/(2 * A_hat);
Q3 = q3/G;

syms x dphi3 phi3

dphi3(x) = (1/(2 * A_hat)) * (vpaintegral(8*Q3,0,1.5) + vpaintegral(16*Q3,1.5,5.381) +...
    vpaintegral(8*Q3,5.381,5.881) + vpaintegral(16*Q3,5.881,9.631));
phi3(x) = int(dphi3);

%%Theta matrix-----------------------------------------------------------
theta = [phi1(x0) * (180/pi);
    phi2(x0) * (180/pi);
    phi3(x0) * (180/pi)];
end

