function K = simple_covSEard(hyp, x, z)


[n,D] = size(x);
ell = exp(hyp(1:D));                               % characteristic length scale
sf2 = exp(2*hyp(D+1));

K = my_sq_dist(diag(1./ell)*x',diag(1./ell)*z');

K = sf2*exp(-K/2);

    function d = my_sq_dist(x,y)
        [nx,mx] = size(x);
        [ny,my] = size(y);
        % nx == ny
        % d = mx x my
        if 0
            d   = zeros(mx,my);
            for ii = 1:mx
                for jj = 1:my
                    diff_vec = x(:,ii) - y(:,jj);
                    d(ii,jj) = diff_vec'*diff_vec;
                end % jj
            end % ii
        else
             d = bsxfun(@plus,sum(x.*x,1)',bsxfun(@minus,sum(y.*y,1),2*x'*y));
            
        end
        d = max(d,0);
        
    end
end