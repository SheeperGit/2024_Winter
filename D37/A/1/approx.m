function [c,flag] = approx(f,a,b,n,m)
    % f: function to be approximated
    % a, b: interval on which f is to be approximated
    % n: degree of the approximating polynomial
    % m: m+1 is the number of interpolation conditions
    % c: a vector containing the n+1 coefficients of the approximating poly
    % flag: indicates whether the approximating poly is uniq.
    %       flag=0 => the poly is unique
    %       flag=1 => the poly is not unique, and c is not computed

    tj = zeros(1, m+1);
    for j = 0:m
        tj(j+1) = a + (b - a) * j/m;
    end

    V = zeros(m+1,n+1);
    for j = 1:m+1
        V(j, :) = tj(j).^((0:n));
    end

    if rank(V) < (n+1)      % Rank Deficient. Exit early!
        c = [];
        flag = 1;
        return;
    end

    flag = 0;

    g = f(tj)';

    [Q,R] = qr(V,0);
    c = R \ (Q' * g);
end