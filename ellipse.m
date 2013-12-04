function Z = ellipse(u,D)
% ellipse Computes points around an ellipse for plotting purposes
%
%   Z = ellipse(u,D) computes points around a 2D ellipse described by the
%   equation (x-u)'*D*(x-u) = 1, with center (u(1),u(2)) and positive-definite
%   matrix D whose eigenvectors define the principal axes, and whose
%   eigenvalues are the reciprocals of the squares of the semi-axes. The
%   real/imaginary part of X represent the first/second dimension.

N = 64;
[V,S] = eig(D);
t = linspace(0,2*pi,N);
X = inv(sqrt(S))*[cos(t); sin(t)];
Z = [1 1j]*V*X + [1 1j]*u(:);

end
