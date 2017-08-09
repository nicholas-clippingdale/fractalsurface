function [ vertnew, xbound, ybound, zbound ]  = subsetvert(vert)
% Extracts a subset of a vertices matrix for fractal zoom.
%
% subsetvert() extracts and returns a subset of a rectangular surface.
%
% vert is the original vertices matrix
%
% vertnew is the new, smaller vertices matrix with uniform boundaries
% xbound is the x-values of the boundary
% ybound is the y-values of the boundary
% zbound is the z-values of the boundary
%
% Nicholas Clippingdale
% 11 August 2016
[ n , ~ ] = size(vert);
n = sqrt(n);
assert(floor(n) == n, 'Ensure the number of vertices is a perfect square');
m = 0.5*(n-1);
p = n-m;
%%%%%%%%%%%%%% Break down Vertices Matrix into Axes Matrices %%%%%%%%%%%%%
x = reshape(vert(:,1),n,n);
y = reshape(vert(:,2),n,n);
z = reshape(vert(:,3),n,n);
%%%%%%%%%%%%%%%%%% Select a Subset of the Old Matrices %%%%%%%%%%%%%%%%%%%
randvert = floor((n-p) * rand(2,1) + 1);
rvx = randvert(1);
rvy = randvert(2);
newx = x(rvx:rvx+p-1,rvy:rvy+p-1);
newy = y(rvx:rvx+p-1,rvy:rvy+p-1);
newz = z(rvx:rvx+p-1,rvy:rvy+p-1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Export Boundary %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xbound = [ newx(:,1)' newx(p,2:p-1) fliplr(newx(:,p)') newx(1,p-1:-1:1) ];
ybound = [ newy(:,1)' newy(p,2:p-1) fliplr(newy(:,p)') newy(1,p-1:-1:1) ];
zbound = [ newz(:,1)' newz(p,2:p-1) fliplr(newz(:,p)') newz(1,p-1:-1:1) ];
%%%%%%%%%%%%%%% Resolve Axes Matrices into Vertices Matrix %%%%%%%%%%%%%%%
vertnew(:,1) = newx(1:p^2);
vertnew(:,2) = newy(1:p^2);
vertnew(:,3) = newz(1:p^2);
end