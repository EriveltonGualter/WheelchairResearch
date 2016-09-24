function [] = simulation(opt)
% simulation(ti, phi, phid, theta, thetad)
%
% INPUTS:
%   opt = [matrix] = structure of optimal control
%
% OUTPUTS:
%   --> Simulation of the wheelchair and plots of the states

    %% Plot Phi, Phid, Theta, and Thetad
    subplot(4,2,5)          % Subplot Angle of wheelchair
    plot(opt.ti, opt.phi);
        title('Angle of Wheelchair $\phi$','interpreter','latex');
        xlabel('t [s]','interpreter','latex'); ylabel('$\phi$ [rad]','interpreter','latex');

    hold on;                % Sublot Angle of wheel
    subplot(4,2,6)     
    plot(opt.ti, opt.phid);
        title('Angular Velocity of Wheel $\dot{\phi}$ [rad/s2]','interpreter','latex');
        xlabel('t [s]','interpreter','latex'); ylabel('$\dot{\phi}$ [rad/s]','interpreter','latex');

    hold on;
    subplot(4,2,7)          % Subplot Angle of wheelchair
    plot(opt.ti, opt.theta);
        title('Angle of Wheelchair $\theta$','interpreter','latex');
        xlabel('t [s]','interpreter','latex'); ylabel('\phi [rad]');

    hold on;                % Sublot Angle of wheel
    subplot(4,2,8)     
    plot(opt.ti, opt.thetad)
        title('Angular Velocity of Wheelchair $\dot{\theta}$ [rad/s2]','interpreter','latex');
        xlabel('t [s]','interpreter','latex');  ylabel('$\dot{\theta}$ [rad/s]','interpreter','latex');

    %% Animation of the wheelchair 
    extents = [-1 opt.theta(end)*0.3048+1 0 1];
    time = 0;
    tic;
    while time < 5
        subplot(4,2,[1 2 3 4]);
        % Compute the position of the system at the current real world time
        posDraw = interp1(opt.ti',(opt.theta.*0.3048)',time')';
        phiDraw = interp1(opt.ti',(opt.phi)',time')';

        % Redraw the image
        drawWheelchair(time, posDraw, opt.phi(1), phiDraw, extents);

        % Update current time
        time = toc;
    end
    
    disp(sprintf('      Simulation Time    : %2.2f s \n      Travelled distance : %2.2f meters ',time, opt.theta(end)*0.3048))
    
    % t = %2.2f%',time));
end

