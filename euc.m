function [g,s,t] = euc(a, b)
% Extended Euclidean Algorithm for finding greatest common divisor (gcd)
    sign_a = sign(a);                   % Sign of a
    sign_b = sign(b);                   % Sign of b
    a = abs(a);                         % |a|
    b = abs(b);                         % |b|
    s = [0 1];                          % Current and previous value of s
    t = [1 0];                          % Current and previous value of t
    %
    % Loop until we get a remainder of zero                                    
    %
    while ~(0==b)
        q = fix(a/b);                   % Compute quotient
        r = mod(a,b);                   % Compute remainder
        a = b;                          % Old b becomes new a
        b = r;                          % Remainder becomes new b
        s = [s(2)-q*s(1), s(1)];        % Update s, save current s
        t = [t(2)-q*t(1), t(1)];        % Update t, save current t
    end
    g = a;
    s = sign_a*s(2);                    % If a is negative, invert sign of s
    t = sign_b*t(2);                    % If b is negative, invert sign of t
end


% Local Variables:
% comment-column: 40
% End:
