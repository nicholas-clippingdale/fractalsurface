close all
% Generates and plots a random fractal surface.
%
% Running more than about ten iterations of insertpoints3d(), depending on
% your system, can bring MATLAB to its knees
%
% The function insertpoints3d() is called to generate the vertices
% The function drawfaces() is called to connect the vertices into faces
%
% Nicholas Clippingdale
% 20 July 2016
vert = [ 0 0 0 ; 0 1 0 ; 1 0 0 ; 1 1 0 ];  % Set original vertices
for i = 1:10  % Iterate insertpoints3d() to produce a new vertices matrix
    vert = insertpoints3d(vert, 0.01);
end
face = drawfaces(vert);  % Produce a corresponding face matrix
patch('Vertices',vert, 'Faces',face, 'FaceVertexCData',vert(:,3), ...
    'EdgeColor','none', 'FaceColor','interp', ...
    'CDataMapping','scaled')
axis([-inf inf -inf inf -inf inf])
light('Position',[1,1,1],'Style','local')