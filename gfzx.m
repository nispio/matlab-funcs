classdef gfzx
    methods(Static)
        % Polynomial in GF(Z)[x] modulo (x^[p] - 1)
        function f = mod(x,p,Z)
            l = numel(x);
            if (l < p)
                f = mod(x, Z); 
            elseif ( p == 0 )
                f = mod(sum(x), Z);
            else
                m = ceil(l/p);
                X = reshape([zeros(1,m*p-l), x],p,m).';
                f = mod(sum(X,1), Z); 
            end
            
        end

        % Addition in GF(Z)[x]
        function f = add(x,y,p,Z)
            c = gfzx.mod(x,p,Z) - gfzx.mod(y,p,Z);
            f = gfzx.mod(c,p,Z);
        end

        % Subtraction in GF(Z)[x]
        function f = sub(x,y,p,Z)
            c = gfzx.mod(x,p,Z) + gfzx.mod(y,p,Z);
            f = gfzx.mod(c,p,Z);
        end

        % Multiplication in GF(Z)[x]
        function f = mult(x,y,p,Z)
            c = conv(gfzx.mod(x,p,Z), gfzx.mod(y,p,Z));
            f = gfzx.mod(c,p,Z);
        end

        % Division in GF(Z)[x]: d(x)/g(x) = q(x)+r(x)/g(x)
        function [q, r] = div(d,g,Z)
            n = length(d);
            p = length(g);
            k = p - find(g,1,'first');
            g = g(p-k+1:p);
            e1 = gfzx.mod(1,k,Z);
            % Shift the first k bits into the register
            r = d(1:k);
            for i=1:n-k
                % Shift out the leftmost bit of the register
                q(i) = r(1);
                % Shift the next bit from d into the right
                r = circshift(r,[0,-1]).*(1-e1) + d(k+i)*e1;
                % Apply LFSR to compute next remainder
                r = mod(r+g*q(i), Z);
            end
        end
    
        % Division (remainder only) in GF(Z)[x]: d(x)=g(x)q(x)+r(x)
        function r = rem(d,g,Z)
            n = length(d);
            p = length(g);
            k = p - find(g,1,'first');
            g = g(p-k+1:p);
            e1 = gfzx.mod(1,k,Z);
            % Shift the first k bits into the register
            r = d(1:k);
            for i=1:n-k
                % Shift out the leftmost bit of the register
                r0 = r(1);
                % Shift the next bit from d into the right
                r = circshift(r,[0,-1]).*(1-e1) + d(k+i)*e1;
                % Apply LFSR to compute next remainder
                r = mod(r+g*r0, Z);
            end
        end
    
        % Greater-Than Comparison (compares the order only)
        function result = gt(a,b)
            if ~nnz(a) || ~nnz(b)
                result = nnz(a) > nnz(b);
            else
                orda = find(fliplr(a),1,'last');
                ordb = find(fliplr(b),1,'last');
                result = orda > ordb;
            end
        end

        % Equality Comparison in GF(Z)[x]
        function f = eq(a,b,Z)
            p = max(length(a),length(b));
            f = gfzx.eq(a,b,p,Z);
        end

        % Equivalence Comparison in GF(Z)[x] modulo (x^[p] - 1)
        function f = eqv(a,b,p,Z)
            x = gfzx.mod(a,p,Z);
            y = gfzx.mod(b,p,Z);
            f = isequal(x,y);
        end

        % Euclid's Algorithm (GCD)
        function [g,s,t] = euc(a,b,Z)
            sold = 0; snew = 1;
            told = 1; tnew = 0;
            while nnz(b)
                [q, r] = gfzx.div(a,b,Z);
                a = b; b = r;
                s = snew; t = tnew;
                snew = gfzx.sub(sold,gfzx.mult(s,q,Z),Z);
                tnew = gfzx.sub(told,gfzx.mult(t,q,Z),Z);
                sold = s; told = t;
                display(a); display(b);
            end
        end
    end
end
