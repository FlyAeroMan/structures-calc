function [u,v,w] = deflection(Pmax,alldata)
%function to calculate the end deflection for an advanced aerospace beam
%with one fixed end
%Cameron Cropper
Iyy = alldata{2}(3);
Izz = alldata{2}(4);
Iyz = alldata{2}(5);
Er = alldata{2}(7);
A_star = alldata{2}(8);
P = alldata{5}(:,1);
x0 = alldata{5}(1,10);


I_tilde = Iyy * Izz - Iyz^2;
My = 0;

%%Case 1: P == 0---------------------------------------------------------
%deflection in the y direction
syms x v0_dp1 dv1 v1
Mz_0(x) = 5 * (x - 45.625);
v0_dp1 = (1/(Er * I_tilde)) * (Mz_0 * Iyy + My * Iyz);

dv1(x) = int(v0_dp1);
c1 = -1 * dv1(0);
dv1(x) = dv1(x) + c1;

v1(x) = int(dv1);
c2 = -1 * v1(0);
v1(x) = v1(x) + c2;

%deflection in the z direction
syms x wo_dp1 dw1 w1
w0_dp1 = (-1/(Er * I_tilde)) * (Mz_0 * Iyz + My * Izz);

dw1(x) = int(w0_dp1);
c1 = -1 * dw1(0);
dw1(x) = dw1(x) + c1;

w1(x) = int(dw1);
c2 = -1 * w1(0);
w1(x) = w1(x) + c2;

%deflection in the x direction
syms x du1 u1
du1(x) = P/(Er * A_star);

u1(x) = int(du1);
c1 = -1 * u1(0);
u1(x) = u1(x) + c1;

%%Case 2: P == 15---------------------------------------------------------
%deflection in the y direction
syms x v0_dp2 dv2 v2
Mz_15(x) = -10 * (x - 45.625);
v0_dp2 = (1/(Er * I_tilde)) * (Mz_15 * Iyy + My * Iyz);

dv2(x) = int(v0_dp2);
c1 = -1 * dv2(0);
dv2(x) = dv2(x) + c1;

v2(x) = int(dv2);
c2 = -1 * v2(0);
v2(x) = v2(x) + c2;

%deflection in the z direction
syms x wo_dp2 dw2 w2
w0_dp2 = (-1/(Er * I_tilde)) * (Mz_15 * Iyz + My * Izz);

dw2(x) = int(w0_dp2);
c1 = -1 * dw2(0);
dw2(x) = dw2(x) + c1;

w2(x) = int(dw2);
c2 = -1 * w2(0);
w2(x) = w2(x) + c2;

%deflection in the x direction
syms x du2 u2
du2(x) = P/(Er * A_star);

u2(x) = int(du2);
c1 = -1 * u2(0);
u2(x) = u2(x) + c1;

%%Case 1: P == Pmax---------------------------------------------------------
%deflection in the y direction
syms x v0_dp3 dv3 v3
Mz_max(x) = (-Pmax + 5) * (x - 45.625);
v0_dp3 = (1/(Er * I_tilde)) * (Mz_max * Iyy + My * Iyz);

dv3(x) = int(v0_dp3);
c1 = -1 * dv3(0);
dv3(x) = dv3(x) + c1;

v3(x) = int(dv3);
c2 = -1 * v3(0);
v3(x) = v3(x) + c2;

%deflection in the z direction
syms x wo_dp3 dw3 w3
w0_dp3 = (-1/(Er * I_tilde)) * (Mz_max * Iyz + My * Izz);

dw3(x) = int(w0_dp3);
c1 = -1 * dw3(0);
dw3(x) = dw3(x) + c1;

w3(x) = int(dw3);
c2 = -1 * w3(0);
w3(x) = w3(x) + c2;

%deflection in the x direction
syms x du3 u3
du3(x) = P/(Er * A_star);

u3(x) = int(du3);
c1 = -1 * u3(0);
u3(x) = u3(x) + c1;
%------------------------------------------------------------------------
%%Deflection matrices
u = [vpa(u1(x0));vpa(u2(x0));vpa(u3(x0))];
v = [vpa(v1(x0));vpa(v2(x0));vpa(v3(x0))];
w = [vpa(w1(x0));vpa(w2(x0));vpa(w3(x0))];

end
