function [y,ty,xy,med] = foufilter3(x,t,Ti,Tf,ov,Fa,Fci,Fcs)
    % x   = vetor da dados
    % t   = vetor dos tempos
    % Ti  = inicio da Janela temporal
    % Tf  = final da Janela temporal    
    % ov  = oversampling (se não, ov = 1) 
    % fa  = frequência de amostragem original [Hz]
    % fci = frequência de corte inferior do filtro [Hz] 
    % fcs = frequência de corte superior do filtro [Hz]      
    % y   = dados filtrados
    % ty  = vetor dos tempos resultante
    % xy  = vetor de entrada considerado    
    % med = media do sinal entrada considerado
    
    % Justificar porque ganho e valor DC da resposta
    % Testar colocar dois ciclos antes do inicio espelhados
    
    ni = find( (t<=Ti) ); 
    ni = ni(end);
    nf = find( (t<=Tf) ); 
    nf = nf(end);
    x  = x(ni:nf);   
    x  = interp(x, fix(abs(ov)) );

    ty  = linspace(t(ni),t(nf),length(x));
    xy  = x;
    med = mean(x);
    
    N  = length(x);   
    Fr = linspace(0,Fa/2,N);
    Ni = find( (Fr<=Fci) ); 
    Ni = Ni(end);
    Nf = find( (Fr<=Fcs) ); 
    Nf = Nf(end);    
    
    x1 = x(:); 
    x2 = flipud(x1);
    x3 = [x1 ; x2];
    ft = fft(x3)/1;   
    
    if Fci == 0
        window =[ ones(1,Nf)  zeros(1,(2*N-Nf)) ];
        ftcort = window.*ft';    
        y = real( ifft(ftcort) );
        y = 2*y(1:N) - 1*med;
    else
        window = [ zeros(1,Ni) ones(1,Nf-Ni)  zeros(1,(2*N-Nf)) ];
        ftcort = window.*ft';    
        y = real( ifft(ftcort) );
        y = 2*y(1:N) - 0*med;;        
    end
    
    % teste_foufilter3.m   
end

