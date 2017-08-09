close all
% Generates and plots various random surfaces with possible fractal zoom.
%
% The type of surface and choice to zoom is input by the user. Fractal
% zoom repeatedly zooms in on sections of the surface while maintaining
% the same level of detail. This can theoretically be performed
% indefinitely.
%
% Running more than about ten iterations, depending on your system, of the
% different insertpoints() functions can bring MATLAB to its knees. The
% more that are run however, the cooler it looks.
%
% The function insertpoints3d() is called to generate a surface
% The function insertpointsmountain() is called to generate a mountain
% The function insertpointscanyon() is called to generate a canyon
% The function drawfaces() is called to connect the vertices into faces
% The function subsetvert() is called to perform the fractal zoom
%
% Nicholas Clippingdale
% 13 August 2016
fprintf('What kind of geographical feature would you like?\n');
prompt = '1 - Random Surface\n2 - Mountain\n3 - Canyon\n';
feat = input(prompt);
fprintf('Would you like to zoom?\n');
prompt = '0 - No\n1 - Yes\n';
zoom = input(prompt);
prompt = 'How many iterations would you like to run?\n';
iter = input(prompt);
assert(feat == 1 | feat == 2 | feat == 3, 'Invalid input into feature');
assert(zoom == 0 | zoom == 1, 'Invalid input into zoom');
assert(iter > 0 && floor(iter) == iter, 'Iterations must be integer >1');
vert = [ 0 0 0 ; 0 1 0 ; 1 0 0 ; 1 1 0 ];  % Set original vertices
if feat == 1 % Generates random surface
    for i = 1:iter  % Iterate insertpoints3d() to produce the surface
        vert = insertpoints3d(vert, 0.1);
    end
elseif feat == 2 % Generates mountain
    for i = 1:iter % Iterate insertpointsmountain() to produce the mountain
        vert = insertpointsmountain(vert, 0.1);
    end
elseif feat == 3 % Generates canyon
    for i = 1:iter % Iterate insertpointscanyon() to produce the canyon
        vert = insertpointscanyon(vert, 0.1);
    end
end
face = drawfaces(vert);  % Produce a corresponding face matrix
if zoom == 1 % Performs zoom
    CD = vert(:,3); % Uniform colour data
    for j = 1:4
        subplot(2,2,j)
        hold on
        patch('Vertices',vert, 'Faces',face, 'FaceVertexCData',CD, ...
            'EdgeColor','none', 'FaceColor','interp', ...
            'CDataMapping','scaled');
        axis([-inf inf -inf inf -inf inf])
        light('Position',[1,1,1],'Style','local')
    if j ~= 4
        [ vert, x, y, z ] = subsetvert(vert); % Zoom in on a subset
        for k = 1:j
            subplot(2,2,k)
            hold on
            plot3(x,y,z, 'r-', 'LineWidth',4)
        end
        vert = insertpointssurface(vert, 0.1); % Maintain level of detail
    end
    hold off
    end
else % No zoom
    patch('Vertices',vert, 'Faces',face, 'FaceVertexCData',vert(:,3), ...
        'EdgeColor','none', 'FaceColor','interp', 'CDataMapping','scaled')
    axis([-inf inf -inf inf -inf inf])
    light('Position',[1,1,1],'Style','local')
end