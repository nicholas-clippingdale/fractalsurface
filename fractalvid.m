close all
% Creates a .mp4 video of random surface.
%
% fractalsurfacebasic is called to generate and plot the surface
% CaptureFigVid is called to capture the video
%
% Nicholas Clippingdale
% 9 August 2017
fractalsurfacebasic
set(gcf, 'Position', [100, 100, 1200, 800]);
set(gcf, 'color', 'w');

OptionZ.FrameRate = 20; % Speed of the rotation
OptionZ.Duration = 30; % Length of the video in seconds
OptionZ.Periodic = true;
CaptureFigVid([ -20,10 ; -110,30 ; -190,10 ; -290,40 ; -380,10 ], ...
    'fractalvid', OptionZ);