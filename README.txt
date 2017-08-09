%%%%%%%%%%%%%%%%%%%%%%%%%%%% fractalsurface Read Me %%%%%%%%%%%%%%%%%%%%%%%%%%%%

fractalsurface is a program, written in Matlab, which generates and plots random surfaces. Each time the program is run, a new surafce is created from scratch in a fractal-like manner. The longer the program is run, the more detailed the surface becomes.
There are multiple scripts which call the same functions but perform different outcomes - see below.

With thanks to Dr. Lewis Mitchell from The School of Mathematical Sciences at The University of Adelaide for his help with this project and sourcing the CaptureFigVid() function.

Nicholas Clippingdale
9 August 2017

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Scripts for the User %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fractalsurface.m asks the user which geographcal feature they would like, how many iterations should be run - more than ten can stress some systems, and whether or not a zoom should be performed.
fractalsurfacebasic.m generates and plots only a random surface without zoom.
fractalsurfacezoom.m generates a random surface and then performs an iterative zoom on a section where the level of detail is maintained, plotting each step.
fractalvid.m generates and plots a random surface and then creates a rotating .mp4 video of the result.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Other Files %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
insertpoints3d() takes in a vertices and returns one with more detail. It is called iteratively in the associated scripts.
drawfaces() outputs the face matrix corresponding to the input vertices matrix.
subsetvert() takes a subset of the vertices matrix. This function is used to select a section to zoom in on.
CaptureFigVid() is called to capture a video of the plot. This one was not written by me.
insertpointsmountain() and insertpointscanyon() do the same as insertpoints3d() but they make the vertices matrices for a mountain and canyon, respectively. These don't look especially nice - they are more proof of concept functions.