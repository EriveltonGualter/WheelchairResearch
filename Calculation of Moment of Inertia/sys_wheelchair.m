function [ wheelchair ] = sys_wheelchair_params()

% Variables of the system %

% Dimensions 
wheelchair.Rl = 11*25.4/1000;  % Raio push rings (m) - diametro 24"
wheelchair.R = 12*25.4/1000;   % Raio da roda traseira(m)- diametro 22"
wheelchair.r = 2*25.4/1000;    % Raio da roda dianteira (m)- diametro 8"
wheelchair.l = 0.256;          % Distance between rear axle and CoM (m)

% Mass and Inertial Moments
wheelchair.Mc = 12.71;          % Massa da cadeira sem as rodas (kg)
wheelchair.Mr = 2.546;          % Massa de uma roda (kg)
wheelchair.Mcr = wheelchair.Mc + 2*wheelchair.Mr; % Massa da cadeira com as rodas (kg)
wheelchair.Jc = 1.67;           % Momento de Inércia da cadeira 
wheelchair.JR = 0.140;          % Momento de Inercia da roda traseira 
wheelchair.Jr = 0;              % Momento de Inercia da roda dianteira

wheelchair.FR = 0;%15*2;      % Forca resistente ao rolamento da roda traseira (N)
wheelchair.Fr = 0;%7*2;       % Forca resistente ao rolamento da roda traseira (N)

wheelchair.g = 9.81;       % Aceleração gravitacional m/s^2 

end
