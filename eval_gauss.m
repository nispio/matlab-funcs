function f = eval_gauss(x,mu,LAMBDA)
    [D, N] = size(x);
    K = size(mu,2);
    
    X = reshape(num2cell(x,1),N,1);
    U = reshape(num2cell(mu,1),1,K);
    V = reshape(num2cell(LAMBDA,[1 2]),1,K);
    
    y = csxfun(@minus, X, U);
    THETA = csxfun(@(A,x) x.'*A*x, V, y, 'UniformOutput',true);
    C = sqrt(cellfun(@det, V)./(2*pi)^D);
    f = C*exp(-0.5*THETA).';
    
end

