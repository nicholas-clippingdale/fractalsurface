close all
% Generates a random surface and performs a fractal zoom.
%
% Running more than about ten iterations of insertpoints3d(), depending on
% your system, can bring MATLAB to its knees
%
% The function insertpoints3d() is called to generate the vertices
% The function drawfaces() is called to connect the vertices into faces
% The function subsetvert() is called to perform the fractal zoom
%
% Nicholas Clippingdale
% 12 August 2016
vert = [ 0 0 0 ; 0 1 0 ; 1 0 0 ; 1 1 0 ];  % Set original vertices
for i = 1:8  % Iterate insertpoints3d() to produce a new vertices matrix
    vert = insertpoints3d(vert, 0.01);
end
face = drawfaces(vert);  % Produce a corresponding face matrix
CD = vert(:,3);
for j = 1:4 % Iterate subsetvert() and insertpoints3d() to zoom in
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
        vert = insertpoints3d(vert, 0.01); % Maintain level of detail
    end
    hold off
end