clear all
close all

N = 40;                         % Number of interaction 
h_step = linspace(1.6, 1.9, N); % Height of the user
m_step = 25.*h_step.^2;         % Using BMI 25

% Wheelchair parameters
w = sys_wheelchair;

% Center of Gravity of wheelchair
CG_wc = [0.193; -0.173];        % Em relação ao hip

% deslocamento
d_step = linspace(-0.05, 0.15, N);

% Center of Gravity for the users (1.6 - 1.9 m)
CG_step     = zeros(2,N);
torque_step = zeros(2,N);

[X,Y] = meshgrid(d_step, h_step);

CGx = zeros(length(h_step), length(d_step));
CGy = zeros(length(h_step), length(d_step));
for i=1:N
    cgi = solveCG(h_step(i), m_step(i));
    CG_step(1,i) = cgi(1,1);
    CG_step(2,i) = cgi(2,1);
        
    for ii=1:length(d_step)
        CGx(i,ii) = (CG_step(1,i)*m_step(i) + CG_wc(1,1)*w.Mcr)/(m_step(i) + w.Mcr) + d_step(ii);
        CGy(i,ii) = (CG_step(2,i)*m_step(i) + CG_wc(2,1)*w.Mcr)/(m_step(i) + w.Mcr); 
        
        torque_step(i,ii) = w.R*(((w.Mcr+m_step(i)) + 2*(w.JR/w.R^2 + ...
            w.Jr/w.r^2))*CGx(i,ii)*w.g/(CGy(i,ii) + 0.5356) + w.FR + w.Fr);
    end
end

contourf(X.*100, Y, torque_step, 'ShowText', 'on')
    title('Lift off torque [N.m]')
    xlabel('Longitudinal distance of rear axle and hip [cm]'); 
    ylabel('User’s stature[m]');

% Add mass
hold on
box off
a2 = axes('YAxisLocation', 'Right');
set(a2, 'color', 'none'); 
set(a2, 'XTick', []);
set(a2, 'YLim', [m_step(1) m_step(end)]);
a2.YLabel.String = 'Mass of the user [kg]';

