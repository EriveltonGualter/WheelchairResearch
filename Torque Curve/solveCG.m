function [ CG ] = solveCG(H,M)
    syms a1 a2 a3 a4 a5;

    % Body Segment lenghts ____________________________________________________
    l1 = (2/3)*0.152*H;         % Foot
    l2 = 0.039*H ;              % 
    l3 = 0.285*H - (l2);        % Leg - Medial malleollus - Femoral condyles 
    l4 = 0.530*H - (l2+l3);     % Thigh
    l5 = 0.818*H - (l2+l3+l4);  % HAT

    % Mass of each segment ____________________________________________________
    m(1) = 0.0145*M;  % Mass of foot
    m(2) = 0;         % 
    m(3) = 0.0465*M;  % Mass of leg
    m(4) = 0.1000*M;  % Mass of thigh
    m(5) = 0.6780*M;  % Mass of HAT - Head, arms and trunk

    % Center of mass of each segment __________________________________________
    com1 = sqrt((0.0351*H/1.8)^2+(0.0768*H/1.8)^2); % Center of Mass - foot
    com2 = 0;           %
    com3 = 0.433*l3;    % Center of Mass - leg
    com4 = 0.433*l4;    % Center of Mass - thigh
    com5 = 0.626*l5;    % Center of Mass - HAT

    % Direct kinematics of 
    b1 = a1;
    b2 = b1 + a2;
    b3 = b2 + a3;
    b4 = b3 + a4;
    b5 = b4 + a5;

    x1 = l1*cos(b1);
    y1 = l1*sin(b1);
    x2 = l1*cos(b1) + l2*cos(b2);
    y2 = l1*sin(b1) + l2*sin(b2);
    x3 = l1*cos(b1) + l2*cos(b2) + l3*cos(b3);
    y3 = l1*sin(b1) + l2*sin(b2) + l3*sin(b3);
    x4 = l1*cos(b1) + l2*cos(b2) + l3*cos(b3) + l4*cos(b4);
    y4 = l1*sin(b1) + l2*sin(b2) + l3*sin(b3) + l4*sin(b4);
    x5 = l1*cos(b1) + l2*cos(b2) + l3*cos(b3) + l4*cos(b4) + l5*cos(b5);
    y5 = l1*sin(b1) + l2*sin(b2) + l3*sin(b3) + l4*sin(b4) + l5*sin(b5);

    a1 = pi;
    a2 = -pi/2;
    a3 = 0;
    a4 = pi/2;
    a5 = -pi/2;

    % Coordinates of joints____________________________________________________
    X(1) = 0;
    Y(1) = 0;
    X(2) = eval(x1);
    Y(2) = eval(y1);
    X(3) = eval(x2);
    Y(3) = eval(y2);
    X(4) = eval(x3);
    Y(4) = eval(y3);
    X(5) = eval(x4);
    Y(5) = eval(y4);
    X(6) = eval(x5);
    Y(6) = eval(y5);

    % Coordinates of center of mass for each segment___________________________
    cx1 = 0.5*l1*cos(b1);
    cy1 = 0.5*l1*sin(b1);
    cx2 = l1*cos(b1) + 0.5*l2*cos(b2);
    cy2 = l1*sin(b1) + 0.5*l2*sin(b2);
    cx3 = l1*cos(b1) + l2*cos(b2) + (l3-com3)*cos(b3);
    cy3 = l1*sin(b1) + l2*sin(b2) + (l3-com3)*sin(b3);
    cx4 = l1*cos(b1) + l2*cos(b2) + l3*cos(b3) + (l4-com4)*cos(b4);
    cy4 = l1*sin(b1) + l2*sin(b2) + l3*sin(b3) + (l4-com4)*sin(b4);
    cx5 = l1*cos(b1) + l2*cos(b2) + l3*cos(b3) + l4*cos(b4) + com5*cos(b5);
    cy5 = l1*sin(b1) + l2*sin(b2) + l3*sin(b3) + l4*sin(b4) + com5*sin(b5);

    Cx(1) = eval(cx1);
    Cy(1) = eval(cy1);
    Cx(2) = eval(cx2);
    Cy(2) = eval(cy2);
    Cx(3) = eval(cx3);
    Cy(3) = eval(cy3);
    Cx(4) = eval(cx4);
    Cy(4) = eval(cy4);
    Cx(5) = eval(cx5);
    Cy(5) = eval(cy5);

    % Center of Mass __________________________________________________________
    COMx = 0;
    COMy = 0; 
    Mt = 0;
    for i=1:5
        if i<5
            COMx = COMx + 2*Cx(i)*m(i);
            COMy = COMy + 2*Cy(i)*m(i);
            Mt = Mt + 2*m(i);
        else
            COMx = COMx + Cx(i)*m(i);
            COMy = COMy + Cy(i)*m(i);
            Mt = Mt + m(i);
        end
    end
    
    CG = zeros(2,1);
    COMx = COMx/Mt;
    COMy = COMy/Mt;
    
    CG(1,1) = COMx +(l1+l4);
    CG(2,1) = COMy -(l2+l3);
end

