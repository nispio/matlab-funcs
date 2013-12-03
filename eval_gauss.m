function f = eval_gauss(x,u,v)
    [D, N] = size(x);
    K = size(u,2);
    
    U = reshape(repmat(num2cell(u,1),[1 N]),[1 N K]);
    V = repmat(num2cell(V,[1 2]);
    
    C = sqrt(cellfun(@det, V))./(2*pi)^(0.5*D);

    y = cellfun(@minus, repmat(num2cell(x,1),[1 1 K]), repmat(U,[1 N 1]));
    E = exp(-0.5*y.'*V{1}*y);
    
    Y = cellfun(@mtimes, repmat(V,[1 size(x,2)]), repmat(num2cell(x,1),[1 1 K]), 'UniformOutput',false);
    Z = cellfun(@mtimes, repmat(num2cell(x.',2).',[1 1 5]), Y);
end

