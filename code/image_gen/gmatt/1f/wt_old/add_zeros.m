function GMATT = add_zeros(GMATT)

ctrl = GMATT.CTRL;
ctrl_coeffs = fieldnames(ctrl);

for i=1:length(ctrl_coeffs)
    coeff = ctrl.(ctrl_coeffs{i});
    if ~isfield(coeff,'betaRange')
        if i >6 && i<=9 %elevator
            idx = length(coeff.deflRange)/2;
            GMATT.CTRL.(ctrl_coeffs{i}).deflRange = ...
                              [coeff.deflRange(1:idx); ...
                               0; coeff.deflRange(idx+1:end)];
            zero_vec = zeros(length(coeff.alphaRange),1);
            GMATT.CTRL.(ctrl_coeffs{i}).data = ...
                         [coeff.data(:,1:idx), ...
                          zero_vec, coeff.data(:,idx+1:end)];
        end
    else
        zero_mat = zeros(length(coeff.alphaRange),length(coeff.betaRange));
        if i <=3 %aileron
            idx = length(coeff.deflRange)/2;
            GMATT.CTRL.(ctrl_coeffs{i}).deflRange =...
                              [coeff.deflRange(1:idx); ...
                               0; coeff.deflRange(idx+1:end)];
            
            GMATT.CTRL.(ctrl_coeffs{i}).data =...
                           cat(3,coeff.data(:,:,1:idx), ...
                               zero_mat,coeff.data(:,:,idx+1:end));
                          
        elseif i>3 && i<= 18 %rudder
            
            GMATT.CTRL.(ctrl_coeffs{i}).deflRange = [0; coeff.deflRange]; 
            GMATT.CTRL.(ctrl_coeffs{i}).data =...
                           cat(3,zero_mat,coeff.data);

        end
    end
    
end
end