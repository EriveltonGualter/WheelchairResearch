%% modelo com a posição da roda
        clear, clc, warning off
		dados
        load wheelie
        Q = 1e3*diag([1 1 1 1]);
		R = 1;
		G = lqr(A,B,Q,R);
		[ eig(A) eig(A-B*G) ];
        Phi_i = pi/6;   
%       diagrama3, sim('diagrama3.slx',opt.ti(end)*3 ) 
        diagrama4, sim('diagrama4.slx',opt.ti(end)*3 )          
        custo = J(end)
        
%% plots        
        figure(1)
        subplot(5,1,1)
            plot(opt.ti,opt.phi,t,x(:,1),'linewidt',2), grid, legend('Phi')   
        subplot(5,1,2)
            plot(opt.ti,opt.phid,t,x(:,2),'linewidt',2), grid, legend('PhiDot')              
        subplot(5,1,3)
            plot(opt.ti,opt.theta,t,x(:,3),'linewidt',2), grid, legend('Theta')   
        subplot(5,1,4)
            plot(opt.ti,opt.thetad,t,x(:,4),'linewidt',2), grid, legend('ThetaDot')                
        subplot(5,1,5)
            plot(opt.tc,opt.tau,t,u,'linewidt',2), grid, legend('Tau')                    




