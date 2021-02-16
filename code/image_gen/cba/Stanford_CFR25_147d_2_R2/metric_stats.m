function [] = metric_stats(metrics)
metric_names = {'pitch','roll2','yaw2'};
table_string = '';
for i =1:length(metric_names)
    mn = metric_names{i};
    [f,x] = ecdf(metrics.(mn));
    mu = mean(metrics.(mn));
    variance = var(metrics.(mn));
    [~,ind_fail] = min(abs(x));
    fail_rate = f(ind_fail);
    table_string = [table_string, '& ', num2str(mu,'%.2f') , ' & ', num2str(variance,'%.2e') , ' & ', num2str(fail_rate*100,'%.1f') , '\% '];
end

disp([table_string, '\\ \hline']);

end