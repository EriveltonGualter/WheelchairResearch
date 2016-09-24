clear all
close all

H  = 1.75;       % [m]
Px = 0;
Py = -0.231;

% If you desire to enter with the mass value, just uncomment here. In
% contrast, the mass according to BMI (Font: Brasil-2003) will be used.
%
M  = 75;   
[q, J] = parameters(H, Px, Py, M);

%[q, J] = parameters(H, Px, Py);

phi0 = atan2(q(2,1),q(1,1));

w = sys_wheelchair;
L = sqrt(q(1,1)*q(1,1) + q(2,1)*q(2,1));

tau_lim = (w.Mcr + 75 + w.JR/(w.R^2))*w.R*L*cos(phi0)*w.g/(L*sin(phi0)+w.R)
L*cos(phi0)*w.g/(L*sin(phi0)+w.R)

