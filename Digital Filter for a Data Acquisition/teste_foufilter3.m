% teste_foufilter3.m
    clear, clc, close all
    
% SINAL 
    load('.\Dados Experimentais Oscilacao\Oscilacao_Peq.mat')
    
    plot(t,y_rpm);
%     point = ginput();
%     
%     Ti = point(1,1);
%     Tf = point(2,1);
    Ti = input('Ti: ');
    Tf = input('Tf: ');

    Fi = 0;
    Ff = 6;

% PLOTS       
    famost = 1/(t(2)-t(1));
    over = 1;
    [y,ty,xy,med] = foufilter3(y_rpm,t,Ti,Tf,over,famost,Fi,Ff);
    figure(1)
    plot(t,y_rpm,'-c',ty,y,'-k')
    grid
    
% Determinação dos picos
amp_max = ones(1,100);      pos_max = zeros(1,30);
n_max = 1;                  flag_max = 1;
count_max = 0;              value_max = 0; 
T = length(ty);
for i=1:T-1
    if (y(i+1) > y(i)) && (y(i+1) > amp_max(n_max))
        amp_max(n_max) = y(i+1);
        value_max = y(i+1);
        flag_max = 1;
        pos_max(n_max) = i;
    end             

    if flag_max == 1 && value_max == amp_max(n_max)
        count_max = count_max + 1;
    end
    if count_max == 720;
        n_max = n_max + 1;
        count_max = 0;
        flag_max = 0;
        value_max = 0;
    end
end

% Rebatimento %
p = length(pos_max);
new_pos_max(1:p) = pos_max(1:p);
harm = zeros(T,1);
n_p=1;
for i=1:T
    if n_p < n_max-3
        t_dif = t(new_pos_max(n_p+2))-t(new_pos_max(n_p));
    else
        t_dif = t(new_pos_max(n_p+1))-t(new_pos_max(n_p-1));
    end
    modulo = mod(n_p,2);
    if(modulo==1)
        if t(i) < t(new_pos_max(n_p))+t_dif/4
            harm(i) = y(i);
        else
            harm(i) = -y(i);
            if t(i) > t(new_pos_max(n_p))+ 3*t_dif/4 && n_p < n_max-2
                n_p = n_p + 1;
            end
        end
    else
        harm(i) = y(i);        
        if t(i) > t(new_pos_max(n_p))+ 3*t_dif/4 && n_p < n_max-2
            n_p = n_p + 1;
        end
    end
end

fig2 = figure;
plot(ty,harm)
title('Dados Extraidos do Experimento')
legend('Oscilaçao Harmônica do Experimento')
xlabel('Tempo em segundos (s)') 
ylabel('Rotação em RPM')
hgexport(fig2, 'figure2.jpg', hgexport('factorystyle'), 'Format', 'jpeg');

% Momento de Inercia %
w = sys_wheelchair;
for n=1:n_max-3
    T(n) = t(pos_max(n+2))-t(pos_max(n));
    J(n) = moment_of_inertia(w.Mc,w.g,w.l,T(n));    
    %delta(n) = log(amp_max(n)/amp_max(n+2));
    %f_amort(n) = delta(n)/sqrt((2*pi)^2+(delta(n))^2);
    %n = n+1;
end
%f_amort_med = median(f_amort);
Jmed = median(J)