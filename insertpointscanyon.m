function vertnew = insertpointscanyon(vert, d)
% Generates a more detaled vertices matrix for a canyon.
%
% insertpointscanyon() takes a matrix of vertices with values for all three
% axes. Randomly determined points, perturbed along all three axes, are
% then placed in the gaps to produce a more detailed surface. This
% particular function will create the vertices matrix for a canyon. Only
% matrices where the number of vertices is a perfect square can be used.
% Rectangular x-y planes are required.
%
% vert is the original vertices matrix
% d alters the magnitude of perturbation along the z-axis
%
% vertnew is the new vertices matrix with added random points
%
% Nicholas Clippingdale
% 13 August 2016
[ n , ~ ] = size(vert);
n = sqrt(n);
assert(floor(n) == n, 'Ensure the number of vertices is a perfect square');
m = 2*n-1;
%%%%%%%%%%%%%% Break down Vertices Matrix into Axes Matrices %%%%%%%%%%%%%
x = reshape(vert(:,1),n,n);
y = reshape(vert(:,2),n,n);
z = reshape(vert(:,3),n,n);
%%%%%%%%%%%%%%%%%%% Put Old Elements into New Matrices %%%%%%%%%%%%%%%%%%%
newx(1:2:m,1:2:m) = x;
newy(1:2:m,1:2:m) = y;
newz(1:2:m,1:2:m) = z;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rows %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
newx(2:2:m-1,1:2:m) = 0.1*abs(x(1:n-1,:)-x(2:n,:)) .* rand(n-1,n) ...
    + (min(x(1:n-1,:),x(2:n,:))+0.45*abs(x(1:n-1,:)-x(2:n,:)));
newy(2:2:m-1,1:2:m) = (abs(newx(2:2:m-1,1:2:m)-newx(1:2:m-2,1:2:m)) ./ ...
    abs(x(2:n,:)-x(1:n-1,:))) .* (y(2:n,:)-y(1:n-1,:)) + y(1:n-1,:);
newy(2:2:m-1,1) = (y(2:n,1)-y(1:n-1,1)) .* rand(n-1,1) + y(1:n-1,1);
newy(2:2:m-1,m) = (y(2:n,n)-y(1:n-1,n)) .* rand(n-1,1) + y(1:n-1,n);
ly = sqrt((x(2:n,:)-x(1:n-1,:)).^2 + (y(2:n,:)-y(1:n-1,:)).^2 ...
    + (z(2:n,:)-z(1:n-1,:)).^2);
dy = (-1)*d*ly.*rand(n-1,n);
newz(2:2:m-1,1:2:m) = 0.5 * (z(1:n-1,:)+z(2:n,:)) + dy;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Columns %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
newx(1:2:m,2:2:m-1) = 0.1*(x(:,2:n)-x(:,1:n-1)) .* rand(n,n-1) ...
    + 0.55*x(:,1:n-1) + 0.45*x(:,2:n);
newy(1:2:m,2:2:m-1) = (abs((newx(1:2:m,2:2:m-1)-newx(1:2:m,1:2:m-2))) ...
    ./ (x(:,2:n)-x(:,1:n-1))) .* abs(y(:,2:n)-y(:,1:n-1)) ...
    + min(y(:,2:n),y(:,1:n-1));
lx = sqrt((x(:,2:n)-x(:,1:n-1)).^2 + (y(:,2:n)-y(:,1:n-1)).^2 ...
    + (z(:,2:n)-z(:,1:n-1)).^2);
dx = (-1)*d*lx.*rand(n,n-1);
newz(1:2:m,2:2:m-1) = 0.5 * (z(:,2:n)+z(:,1:n-1)) + dx;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Mid-Points %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
newx(2:2:m-1,2:2:m-1) = 0.1* ...
    abs(max(x(1:n-1,1:n-1),x(2:n,1:n-1))-min(x(1:n-1,2:n),x(2:n,2:n))) ...
    .* rand(n-1,n-1) + ...
    min(max(x(1:n-1,1:n-1),x(2:n,1:n-1)),min(x(1:n-1,2:n),x(2:n,2:n))) ...
    + 0.45* ...
    abs(max(x(1:n-1,1:n-1),x(2:n,1:n-1))-min(x(1:n-1,2:n),x(2:n,2:n)));
newy(2:2:m-1,2:2:m-1) = 0.1* ...
    abs(min(y(2:n,1:n-1),y(2:n,2:n))-max(y(1:n-1,1:n-1),y(1:n-1,2:n))) ...
    .* rand(n-1,n-1) + ...
    min(max(y(1:n-1,1:n-1),y(1:n-1,2:n)),min(y(2:n,1:n-1),y(2:n,2:n))) ...
    + 0.45* ...
    abs(min(y(2:n,1:n-1),y(2:n,2:n))-max(y(1:n-1,1:n-1),y(1:n-1,2:n)));
diag1 = sqrt((x(1:n-1,2:n)-x(1:n-1,1:n-1)).^2 + ...
    (y(1:n-1,2:n)-y(1:n-1,1:n-1)).^2 + (z(1:n-1,1:n-1)-z(2:n,2:n)).^2);
diag2 = sqrt((x(1:n-1,2:n)-x(1:n-1,1:n-1)).^2 + ...
    (y(1:n-1,1:n-1)-y(2:n,1:n-1)).^2 + (z(1:n-1,2:n)-z(2:n,1:n-1)).^2);
diag = (diag1 + diag2)./2;
da = (-1)*d*diag.*rand(n-1,n-1);
newz(2:2:2*n-1,2:2:2*n-1) = 0.25 * (z(1:n-1,1:n-1) + z(2:n,1:n-1) ...
    + z(1:n-1,2:n) + z(2:n,2:n)) + da;
%%%%%%%%%%%%%%% Resolve Axes Matrices into Vertices Matrix %%%%%%%%%%%%%%%
vertnew(:,1) = newx(1:m^2);
vertnew(:,2) = newy(1:m^2);
vertnew(:,3) = newz(1:m^2);
end