clear,clc

R = 11*25.4/1000;   % Raio da roda traseira(m)- diametro 22"
l = 0.4;            % Distancia até o centro de gravidade (m)
Mc = 82.208;        % Massa (kg)
Mr = 2.546*2;       % Massa de uma roda (kg)
Jc = 9.45;          % Momento de Inércia da cadeira 
JR = 0.14*2;        % Momento de Inercia da roda traseira 
g = 9.81;           % Aceleração gravitacional m/s^2 

Mb = [  JR+(Mc+Mr)*R^2   Mc*l*R
           Mc*l*R      Jc+Mc*l^2 ];
       
Kb = [      0
        -Mc*g*l ];


a1 = inv(Mb)*(-Kb);
b1 = inv(Mb)*[1 -1]';
b2 = inv(Mb)*[-1 0]';

A = [   0    1   0   0
      a1(2)  0   0   0
        0    0   0   1
      a1(1)  0   0   0  ];
  
B = [  0  b1(2) 0  b1(1) ]';
B1 = [  0  b2(2) 0  b2(1) ]';
C = eye(4,4);
D = zeros(4,1);

