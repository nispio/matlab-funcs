function s = stirling2(n,k)
% stirling2 Compute Stirling number of the second kind
    j = 0:k;
    binomk = [1 cumprod((k-(1:k)+1)./(1:k))];
    s = sum((-1).^(k-j) .* binomk .* j.^n)/factorial(k);
end
