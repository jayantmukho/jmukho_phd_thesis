function [K_post] = fix_K_eigval(K_post)

min_eig     = 1e-8;
[V,D] = eig(K_post);
dD = diag(D);
min_val = min(real(dD));
if min_val < min_eig
    dD(dD <= min_eig) = min_eig;
    Dn = diag(dD);
    K_post = real(V*Dn*V');
end

end % if