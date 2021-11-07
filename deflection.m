function [v0,w0] = deflection(Mz,My,Iyy,Izz,Iyz,Er,x0)

I_tilde = Iyy * Izz - Iyz^2;

%deflection in the y direction
syms x dv(x) v(x)
v0_dp = (1/(Er * I_tilde)) * (Mz * Iyy + My * Iyz);

dv(x) = int(v0_dp);
c1 = -1 * dv(0);
dv(x) = dv(x) + c1;

v(x) = int(dv);
c2 = -1 * v(0);
v(x) = v(x) + c2;

v0 = v(x0);

%deflection in the z direction
syms x dw(x) w(x)
w0_dp = (-1/(Er * I_tilde)) * (Mz * Iyz + My * Izz);

dw(x) = int(w0_dp);
c1 = -1 * dw(0);
dw(x) = dw(x) + c1;

w(x) = int(dw);
c2 = -1 * w(0);
w(x) = w(x) + c2;

w0 = w(x0);