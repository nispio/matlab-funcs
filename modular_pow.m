function result = modular_pow(base, exponent, modulus)
% modular_pow Modular Exponentiation using right-to-left binary method
%
%   result = modular_pow(x,y,n) computes base x^y mod n using right-to-left
%   binary method as explained by Bruce Schneier in "Applied Cryptography."
%   All operations take place modulo n, guaranteeing that any intermediate
%   values have magnitude less than n*n.
%

    %
    % If exponent is negative, take its absolute value and replace base with its
    %   multiplicative inverse
    %
    if ( exponent < 0 )
        exponent = abs(exponent);
        [~,base,~] = euc(base,modulus);
    end
    result = 1;
    %
    % Iterate roughly log2(exponent) times, squaring base each time
    %
    while (abs(exponent) > 0)
        %
        % Only multiply the result by the current base if exponent is odd
        %
        if mod(exponent,2)
           result = mod(result*base,modulus);
        end
        exponent = fix(exponent/2);
        base = mod(base*base,modulus);
    end
end
