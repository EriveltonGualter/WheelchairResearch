%% Determinação do Momento de Inércia %%
close all

%% Seleção das da massa e seu centro de massa %%
s = input('Experimento com massa única(1) ou as duas massas(2):    ');
switch s
    case 1
        m = 0.930;  % Kg
        R = 0.292;  % m
    case 2
        m = 0.930 + 0.922; % m1 + m2 = 1.852 Kg
        R = 0.319;  % m
    otherwise disp('Massa Inválida')
end
g = 9.81; % m/s^2

%% Moving Average %%
hold on
T=length(t);
y_rpm = y_rpm - y_rpm(T);

windowSize = 30;

b = (1/windowSize)*ones(1,windowSize);
a = 1;
y = filter(b,a,y_rpm);

fig1 = figure;
hold on
plot(t,y_rpm,'b')
plot(t,y,'r')
title('Dados Extraidos do Experimento')
legend('Sinal Original','Sinal filtrado')
xlabel('Tempo em segundos (s)') 
ylabel('Rotação em RPM')
hgexport(fig1, 'figure1.jpg', hgexport('factorystyle'), 'Format', 'jpeg');

%% Determinação dos picos %%
amp_max = ones(1,100);
n_max = 1;
flag_max = 1;
count_max = 0;
value_max = 0;
pos_max = zeros(1,30);
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
    if count_max == 720;%700;%1000;
        n_max = n_max + 1;
        count_max = 0;
        flag_max = 0;
        value_max = 0;
    end
end

%% Rebatimento %%
% p = 1;
% while (pos_max(1,p) ~= 0)
%     p = p +1;
% end
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
plot(t,harm)
title('Dados Extraidos do Experimento')
legend('Oscilaçao Harmônica do Experimento')
xlabel('Tempo em segundos (s)') 
ylabel('Rotação em RPM')
hgexport(fig2, 'figure2.jpg', hgexport('factorystyle'), 'Format', 'jpeg');

%% Momento de Inercia %%
for n=1:n_max-3
    T(n) = t(pos_max(n+2))-t(pos_max(n));
    J(n) = m*R*(g*T(n)^2/(4*pi^2)-R);
    delta(n) = log(amp_max(n)/amp_max(n+2));
    f_amort(n) = delta(n)/sqrt((2*pi)^2+(delta(n))^2);
    n = n+1;
end
f_amort_med = median(f_amort);
Jmed = median(J);