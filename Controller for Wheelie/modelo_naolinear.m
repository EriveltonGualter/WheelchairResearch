function [sys,x0,str,ts,simStateCompliance]=modelo_naolinear(t,x,u,flag,xi)
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

        M =[ JR+(Mr+Mc)*(R^2)     Mc*R*l*cos(x(1))
             Mc*R*l*cos(x(1))     Jc+Mc*l^2       ];

        K = [ -Mc*R*l*(x(2))^2*sin(x(1)) 
              -Mc*g*l*sin(x(1))          ];

        A = inv(M)*( [1;-1]*u(1) - K );

        sys =  [ x(2)   
                 A(2)
                 x(4)
                 A(1) ]  + [0; 1; 0; 0]*u(2);             

function sys = mdlOutputs(t,x)
    sys = x;

