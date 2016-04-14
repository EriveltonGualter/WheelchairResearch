function drawWheelchair(time, pos, phio, phi, extents)
% drawWheelchair(time,pos,phi, extents)
%
% INPUTS:
%   time = [scalar] = current time in the simulation
%   pos = [scalar] = position of the rear axle
%   extents = [xLow, xUpp, yLow, yUpp] = boundary of the draw window
%
% OUTPUTS:
%   --> Draw of the wheelchair, "at least, part of the wheel" 

% Make plot objects global
global pushrimHandle r_wheelHandle r_axleHandle ...
        f_wheelHandle f_axleHandle chairHandle;

wheelColor = [0.96, 0.96, 0.96];   % [R, G, B]

r_wheel_size = 24*0.0254;
f_wheel_size = 8*0.0254;
pushrim_size = 20*0.0254;
diff_wp = (r_wheel_size - pushrim_size)/2;

vec_wheelx = 0.650;                                   % Vector between rear and front wheel
vec_wheely = (f_wheel_size-r_wheel_size)/2;           % Vector between rear and front wheel
vec_wheelx = vec_wheelx*cos(phio-phi) - vec_wheely*sin(phio-phi); % rotational of the vector
vec_wheely = vec_wheelx*sin(phio-phi) + vec_wheely*cos(phio-phi); % rotational of the vector

f_wheel_posx =  vec_wheelx + pos;
f_wheel_posy =  vec_wheely + r_wheel_size/2;

vec_chairx = 0;
vec_chairy = 0.59;
vec_chairx = vec_chairx*cos(phio-phi) - vec_chairy*sin(phio-phi); % rotational of the vector
vec_chairy = vec_chairx*sin(phio-phi) + vec_chairy*cos(phio-phi); % rotational of the vector

px = vec_chairx + pos;
py = vec_chairy + r_wheel_size/2;

% Title and simulation time:
title(sprintf('Whelling simulation ... t = %2.2f%',time));

% Draw the pole:
if isempty(chairHandle)
    chairHandle = plot([pos, px], [r_wheel_size/2, py],...
        'LineWidth',4,...
        'Color',[1,0,0]);
else
    set(chairHandle,...
        'xData',[pos, px],...
        'yData',[r_wheel_size/2, py]);
end

% Draw the wheel:
if isempty(r_wheelHandle)
    r_wheelHandle = rectangle(...
        'Position',[pos-r_wheel_size/2 0 r_wheel_size r_wheel_size],...
        'Curvature',[1,1],...   % <-- Draws a circle...
        'LineWidth',4,...
        'FaceColor',wheelColor,...
        'EdgeColor',0.1*wheelColor);
else
    set(r_wheelHandle,...
        'Position',[pos-r_wheel_size/2 0 r_wheel_size r_wheel_size]);
end

% Draw the pushrim:
if isempty(pushrimHandle)
    pushrimHandle = rectangle(...
        'Position',[pos-pushrim_size/2 diff_wp pushrim_size pushrim_size],...
        'Curvature',[1,1],...  
        'LineWidth',2,...
        'FaceColor',wheelColor,...
        'EdgeColor',0.1*wheelColor);
else
    set(pushrimHandle,...
        'Position',[pos-pushrim_size/2 diff_wp pushrim_size pushrim_size]);
end

% Draw the front wheel:
if isempty(f_wheelHandle)
    f_wheelHandle = rectangle(...
        'Position',[f_wheel_posx-f_wheel_size/2 f_wheel_posy-f_wheel_size/2 f_wheel_size f_wheel_size],...
        'Curvature',[1,1],...   
        'LineWidth',4,...
        'FaceColor',wheelColor,...
        'EdgeColor',0.1*wheelColor);
else
    set(f_wheelHandle,...
        'Position',[f_wheel_posx-f_wheel_size/2 f_wheel_posy-f_wheel_size/2 f_wheel_size f_wheel_size]);
end

% Draw the rear axle:
if isempty(r_axleHandle)
    r_axleHandle = rectangle(...
        'Position',[pos-0.01 r_wheel_size/2-0.01 0.02 0.02],...
        'Curvature',[1,1],...
        'LineWidth',2,...
        'FaceColor',[1,1,1],...
        'EdgeColor',[0,0,0]);
else
    set(r_axleHandle,...
        'Position',[pos-0.01 r_wheel_size/2-0.01 0.02 0.02]);
end

% Draw the rear axle:
if isempty(f_axleHandle)
    f_axleHandle = rectangle(...
        'Position',[f_wheel_posx-0.01 f_wheel_posy-0.01 0.02 0.02],...
        'Curvature',[1,1],... 
        'LineWidth',2,...
        'FaceColor',[1,1,1],...
        'EdgeColor',[0,0,0]);
else
    set(f_axleHandle,...
        'Position',[f_wheel_posx-0.01 f_wheel_posy-0.01 0.02 0.02]);
end

% Format the axis so things look right:
axis equal; axis(extents); axis off; 

% Push the draw commands through the plot buffer
drawnow;

end