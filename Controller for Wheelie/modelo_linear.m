function [sys,x0,str,ts,simStateCompliance]=modelo_linear(t,x,u,flag,xi)
switch flag
    case 0         
        [sys,x0,str,ts,simStateCompliance] = mdlInitializeSizes(xi);
    case 1
        sys = mdlDerivatives(t,x,u);
    case {2,9}
        sys = [];
    case 3
        sys = mdlOutputs(t,x); 
    otherwise
        DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end

function [sys,x0,str,ts,simStateCompliance] = mdlInitializeSizes(xi)
sizes = simsizes;
sizes.NumContStates  = 4;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 4;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);
str = [];
x0  = xi;
ts  = [0 0];   % sample time: [period, offset]
simStateCompliance = 'DefaultSimState';

function sys = mdlDerivatives(t,x,u)
R = 11*25.4/1000;   % Raio da roda traseira(m)- diametro 22"
l = 0.4;            % Distancia até o centro de gravidade (m)
Mc = 82.208;        % Massa (kg)
Mr = 2.546*2;       % Massa de uma roda (kg)
Jc = 9.45;          % Momento de Inércia da cadeira 
JR = 0.14*2;        % Momento de Inercia da roda traseira 
g = 9.81;           % Aceleração gravitacional m/s^2 
w = 1;

Mb = [  JR+(Mc+Mr)*R^2   Mc*l*R
           Mc*l*R      Jc+Mc*l^2 ];
       
Kb = [      0
        -Mc*g*l ];

a1 = inv(Mb)*(-Kb);
b1 = inv(Mb)*[1 -1]';

A = [   0    1   0   0
      a1(2)  0   0   0
        0    0   0   1
      a1(1)  0   0   0  ];
  
B = [  0  b1(2) 0  b1(1) ]';
B_disturbio = [0 1 0 0]'; 

sys = A*x + B*u(1) + B_disturbio*u(2);


%         M =[ w.JR+(w.Mr+w.Mc)*(w.R^2)   w.Mc*w.R*w.l*cos(x(1))
%              w.Mc*w.R*w.l*cos(x(1))     w.Jc+w.Mc*w.l^2        ];
% 
%         K = [ -w.Mc*w.R*w.l*(x(2))^2*sin(x(1)) 
%               -w.Mc*w.g*w.l*sin(x(1))          ];
% 
%         A = inv(M)*( [u(1)  -u(2)]' - K );
% 
%         sys(1) = x(2);   
%         sys(2) = A(2,1);
%         sys(3) = x(4);
%         sys(4) = A(1,1);

function sys = mdlOutputs(t,x)
    sys = x;

