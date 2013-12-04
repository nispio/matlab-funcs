function f = gauss_pdf(X,mu,V)
% gauss_pdf Evaluate a multi-variate guassian pdf at given points
%
%   f = gauss_pdf(X,mu,V) evaluates the multi-variate gaussian pdf at the
%   points specified by the columns of X, given mean and variance (mu, V^-1).
%   Notice that V represents the precision matrix, which is the inverse
%   covariance matrix.    

    C = sqrt(det(V)/(2*pi)^size(X,1));
    y = bsxfun(@minus,X,mu(:));
    f = C*exp(-0.5*sum(y.*(V*y)));
    
end

