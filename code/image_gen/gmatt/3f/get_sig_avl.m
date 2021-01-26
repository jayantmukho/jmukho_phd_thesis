function sig = get_sig_avl(X,Y)
min_sig = 5e-4;
r=.003;
norm_val = zeros(size(X,1),1);

for i=1:size(X,2)
    norm_val = norm_val + X(:,i).^2;
if size(X,2) == 2
    ind_0 = X(:,1) == 0 & X(:,2) == 0;
elseif size(X,2) == 1
     ind_0 = X(:,1) == 0;
else
    ind_0 = X(:,1) == 0 & X(:,2) == 0 & X(:,3) == 0;
end
baseline_sn = 0.1 * abs(mean(Y(ind_0)));
min_sig = max(baseline_sn,min_sig);
sig = (max(Y)-min(Y)) * r * norm_val.^.5;
sig = max(sig,min_sig);

end