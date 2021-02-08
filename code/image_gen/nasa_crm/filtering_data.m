function filt_data = filtering_data(data,varargin)
filt_data = data;
if nargin == 1 
    eps = 0.2;
elseif nargin == 2
    eps = varargin{1};
end

i = 1;
ind_to_remove = [];
while i <= length(data.alpha)-1
    last_ind = i+1;
    for j = i+1:length(data.alpha) - 1
        val = data.alpha(j) - data.alpha(i);
        if val < eps
            ind_to_remove = [ind_to_remove; j];
            last_ind = j+1;
        end
    end
    i = last_ind;
end
filt_data.alpha(ind_to_remove)= [];
filt_data.CL(ind_to_remove) = [];
filt_data.CD(ind_to_remove) = [];
filt_data.Cl(ind_to_remove) = [];
filt_data.Cm(ind_to_remove) = [];
filt_data.Cn(ind_to_remove) = [];
filt_data.CL_sig(ind_to_remove) = [];
filt_data.CD_sig(ind_to_remove) = [];
filt_data.Cl_sig(ind_to_remove) = [];
filt_data.Cm_sig(ind_to_remove) = [];
filt_data.Cn_sig(ind_to_remove) = [];

end
