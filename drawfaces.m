function face = drawfaces(vert)
% Connects vertices to produce a corresponding face matrix.
%
% drawfaces() takes a vertices matrix and generates a corresponding face
% matrix. The two can be plotted with patch() to produce an undulating,
% randomly determined surface. Only a square surface where the number of
% vertices is a perfect square can be used.
%
% vert is the vertices matrix
%
% face is the resulting face matrix
%
% Nicholas Clippingdale
% 24 August 2015
[ n , ~ ] = size(vert);
n = sqrt(n);
f = flipud(reshape(1:n^2,n,n));
f = f(2:end,:);
f = f(end:-2:1,1:2:end-2);
f1(:,1) = f(1:end);
f1(:,2) = f1(:,1) + 1;
f1(:,3) = f1(:,2) + n;
f2 = f1;
f2(:,2) = f2(:,1) + n;
f3(:,1) = f1(:,1) + 2;
f3(:,2) = f3(:,1) - 1;
f3(:,3) = f3(:,2) + n;
f4 = f3;
f4(:,2) = f4(:,1) + n;
f5(:,1) = f1(:,1) + 2*n;
f5(:,2) = f5(:,1) - n;
f5(:,3) = f5(:,2) + 1;
f6 = f5;
f6(:,2) = f6(:,1) + 1;
f7(:,1) = f1(:,1) + 2 + 2*n;
f7(:,2) = f7(:,1) - n;
f7(:,3) = f7(:,2) - 1;
f8 = f7;
f8(:,2) = f8(:,1) - 1;
face = [ f1;f2;f3;f4;f5;f6;f7;f8 ];
end