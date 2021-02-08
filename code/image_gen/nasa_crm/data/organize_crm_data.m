%% Preprocessing
load('AVL_HT_0.mat')
load('SU2_HT_0.mat')
load('WT_HT_0.mat')

AVL_M7                  = [zero_M7(:,5) AVL_M7];
AVL_M75                 = [zero_M75(:,5) AVL_M75];
AVL_M8                  = [zero_M8(:,5) AVL_M8];
AVL_M83                 = [zero_M83(:,5) AVL_M83];
AVL_M85                 = [zero_M85(:,5) AVL_M85];
AVL_M86                 = [zero_M86(:,5) AVL_M86];
AVL_M87                 = [zero_M87(:,5) AVL_M87];

AVL_M7                  = sortrows(AVL_M7,1);
AVL_M75                 = sortrows(AVL_M75,1);
AVL_M8                  = sortrows(AVL_M8,1);
AVL_M83                 = sortrows(AVL_M83,1);
AVL_M85                 = sortrows(AVL_M85,1);
AVL_M86                 = sortrows(AVL_M86,1);
AVL_M87                 = sortrows(AVL_M87,1);
SU2_M7                  = sortrows(SU2_M7,1);
SU2_M85                 = sortrows(SU2_M85,1);
SU2_M85_full            = sortrows(SU2_M85_full,1);
zero_M7                 = sortrows(zero_M7,5);
zero_M75                = sortrows(zero_M75,5);
zero_M8                 = sortrows(zero_M8,5);
zero_M83                = sortrows(zero_M83,5);
zero_M85                = sortrows(zero_M85,5);
zero_M86                = sortrows(zero_M86,5);
zero_M87                = sortrows(zero_M87,5);


%% Setting SU2 Data
SU2_Mach7.alpha         = SU2_M7(:,1);
SU2_Mach7.CL            = SU2_M7(:,2);
SU2_Mach7.CD            = SU2_M7(:,3);
SU2_Mach7.Cl            = SU2_M7(:,5);
SU2_Mach7.Cm            = SU2_M7(:,6);
SU2_Mach7.Cn            = SU2_M7(:,7);

SU2_Mach85.alpha        = SU2_M85(:,1);
SU2_Mach85.CL           = SU2_M85(:,2);
SU2_Mach85.CD           = SU2_M85(:,3);
SU2_Mach85.Cl           = SU2_M85(:,5);
SU2_Mach85.Cm           = SU2_M85(:,6);
SU2_Mach85.Cn           = SU2_M85(:,7);

SU2_Mach85_full.alpha   = SU2_M85_full(:,1);
SU2_Mach85_full.CL      = SU2_M85_full(:,2);
SU2_Mach85_full.CD      = SU2_M85_full(:,3);
SU2_Mach85_full.Cl      = SU2_M85_full(:,5);
SU2_Mach85_full.Cm      = SU2_M85_full(:,6);
SU2_Mach85_full.Cn      = SU2_M85_full(:,7);
SU2_Mach85_full.CL_sig  = abs(SU2_Mach85_full.alpha)./100;
SU2_Mach85_full.CL_sig(2)  = SU2_Mach85_full.CL_sig(2) * 2.5;
SU2_Mach85_full.CD_sig  = ones(length(SU2_Mach85_full.alpha),1)*0.01;
SU2_Mach85_full.Cl_sig  = ones(length(SU2_Mach85_full.alpha),1)*0.01;
SU2_Mach85_full.Cm_sig  = ones(length(SU2_Mach85_full.alpha),1)*0.1;
SU2_Mach85_full.Cn_sig  = ones(length(SU2_Mach85_full.alpha),1)*0.002;

SU2_Mach85_uq.alpha   = SU2_M85_uq(:,1);
SU2_Mach85_uq.CL      = SU2_M85_uq(:,2);
SU2_Mach85_uq.CD      = SU2_M85_uq(:,4);
SU2_Mach85_uq.Cl      = SU2_M85_uq(:,6);
SU2_Mach85_uq.Cm      = SU2_M85_uq(:,8);
SU2_Mach85_uq.Cn      = SU2_M85_uq(:,10);
SU2_Mach85_uq.CL_sig  = SU2_M85_uq(:,3);
SU2_Mach85_uq.CD_sig  = SU2_M85_uq(:,5);
SU2_Mach85_uq.Cl_sig  = SU2_M85_uq(:,7);
SU2_Mach85_uq.Cm_sig  = SU2_M85_uq(:,9);
SU2_Mach85_uq.Cn_sig  = SU2_M85_uq(:,11);

%% Setting Wind Tunnel Data
WT_Mach7.alpha          = zero_M7(:,5);
WT_Mach7.CL             = zero_M7(:,24);
WT_Mach7.CD             = zero_M7(:,25);
WT_Mach7.Cl             = zero_M7(:,21);
WT_Mach7.Cm             = zero_M7(:,22);
WT_Mach7.Cn             = zero_M7(:,23);
WT_Mach7.CL_sig         = ones(length(WT_Mach7.alpha),1)*0.015;
WT_Mach7.CD_sig         = ones(length(WT_Mach7.alpha),1)*0.005;
WT_Mach7.Cl_sig         = ones(length(WT_Mach7.alpha),1)*0.005;
WT_Mach7.Cm_sig         = ones(length(WT_Mach7.alpha),1)*0.01;
WT_Mach7.Cn_sig         = ones(length(WT_Mach7.alpha),1)*0.0005;

WT_Mach75.alpha         = zero_M75(:,5);
WT_Mach75.CL            = zero_M75(:,24);
WT_Mach75.CD            = zero_M75(:,25);
WT_Mach75.Cl            = zero_M75(:,21);
WT_Mach75.Cm            = zero_M75(:,22);
WT_Mach75.Cn            = zero_M75(:,23);
WT_Mach75.CL_sig        = ones(length(WT_Mach75.alpha),1)*0.015;
WT_Mach75.CD_sig        = ones(length(WT_Mach75.alpha),1)*0.005;
WT_Mach75.Cl_sig        = ones(length(WT_Mach75.alpha),1)*0.005;
WT_Mach75.Cm_sig        = ones(length(WT_Mach75.alpha),1)*0.01;
WT_Mach75.Cn_sig        = ones(length(WT_Mach75.alpha),1)*0.0005;

WT_Mach8.alpha         = zero_M8(:,5);
WT_Mach8.CL            = zero_M8(:,24);
WT_Mach8.CD            = zero_M8(:,25);
WT_Mach8.Cl            = zero_M8(:,21);
WT_Mach8.Cm            = zero_M8(:,22);
WT_Mach8.Cn            = zero_M8(:,23);
WT_Mach8.CL_sig        = ones(length(WT_Mach8.alpha),1)*0.015;
WT_Mach8.CD_sig        = ones(length(WT_Mach8.alpha),1)*0.005;
WT_Mach8.Cl_sig        = ones(length(WT_Mach8.alpha),1)*0.005;
WT_Mach8.Cm_sig        = ones(length(WT_Mach8.alpha),1)*0.01;
WT_Mach8.Cn_sig        = ones(length(WT_Mach8.alpha),1)*0.0005;

WT_Mach83.alpha         = zero_M83(:,5);
WT_Mach83.CL            = zero_M83(:,24);
WT_Mach83.CD            = zero_M83(:,25);
WT_Mach83.Cl            = zero_M83(:,21);
WT_Mach83.Cm            = zero_M83(:,22);
WT_Mach83.Cn            = zero_M83(:,23);
WT_Mach83.CL_sig        = ones(length(WT_Mach83.alpha),1)*0.015;
WT_Mach83.CD_sig        = ones(length(WT_Mach83.alpha),1)*0.005;
WT_Mach83.Cl_sig        = ones(length(WT_Mach83.alpha),1)*0.005;
WT_Mach83.Cm_sig        = ones(length(WT_Mach83.alpha),1)*0.01;
WT_Mach83.Cn_sig        = ones(length(WT_Mach83.alpha),1)*0.0005;

WT_Mach85.alpha         = zero_M85(:,5);
WT_Mach85.CL            = zero_M85(:,24);
WT_Mach85.CD            = zero_M85(:,25);
WT_Mach85.Cl            = zero_M85(:,21);
WT_Mach85.Cm            = zero_M85(:,22);
WT_Mach85.Cn            = zero_M85(:,23);
WT_Mach85.CL_sig        = ones(length(WT_Mach85.alpha),1)*0.005;
WT_Mach85.CD_sig        = ones(length(WT_Mach85.alpha),1)*0.0005;
WT_Mach85.Cl_sig        = ones(length(WT_Mach85.alpha),1)*0.005;
WT_Mach85.Cm_sig        = ones(length(WT_Mach85.alpha),1)*0.0075;
WT_Mach85.Cn_sig        = ones(length(WT_Mach85.alpha),1)*0.0005;

WT_Mach86.alpha         = zero_M86(:,5);
WT_Mach86.CL            = zero_M86(:,24);
WT_Mach86.CD            = zero_M86(:,25);
WT_Mach86.Cl            = zero_M86(:,21);
WT_Mach86.Cm            = zero_M86(:,22);
WT_Mach86.Cn            = zero_M86(:,23);
WT_Mach86.CL_sig        = ones(length(WT_Mach86.alpha),1)*0.015;
WT_Mach86.CD_sig        = ones(length(WT_Mach86.alpha),1)*0.005;
WT_Mach86.Cl_sig        = ones(length(WT_Mach86.alpha),1)*0.005;
WT_Mach86.Cm_sig        = ones(length(WT_Mach86.alpha),1)*0.01;
WT_Mach86.Cn_sig        = ones(length(WT_Mach86.alpha),1)*0.0005;

WT_Mach87.alpha         = zero_M87(:,5);
WT_Mach87.CL            = zero_M87(:,24);
WT_Mach87.CD            = zero_M87(:,25);
WT_Mach87.Cl            = zero_M87(:,21);
WT_Mach87.Cm            = zero_M87(:,22);
WT_Mach87.Cn            = zero_M87(:,23);
WT_Mach87.CL_sig        = ones(length(WT_Mach87.alpha),1)*0.015;
WT_Mach87.CD_sig        = ones(length(WT_Mach87.alpha),1)*0.005;
WT_Mach87.Cl_sig        = ones(length(WT_Mach87.alpha),1)*0.005;
WT_Mach87.Cm_sig        = ones(length(WT_Mach87.alpha),1)*0.01;
WT_Mach87.Cn_sig        = ones(length(WT_Mach87.alpha),1)*0.0005;

%% Setting AVL Data
AVL_Mach7.alpha        = AVL_M7(:,1);
AVL_Mach7.CL           = AVL_M7(:,2);
AVL_Mach7.CD           = AVL_M7(:,3);
AVL_Mach7.Cl           = AVL_M7(:,5);
AVL_Mach7.Cm           = AVL_M7(:,6);
AVL_Mach7.Cn           = AVL_M7(:,7);
AVL_Mach7.CL_sig       = abs(AVL_Mach7.CL-WT_Mach7.CL)./1.7;
AVL_Mach7.CL_sig(AVL_Mach7.CL_sig<0.015) = 0.03;
AVL_Mach7.CD_sig       = abs(AVL_Mach7.CD-WT_Mach7.CD)./1.7;
AVL_Mach7.CD_sig(AVL_Mach7.CD_sig<0.005) = 0.0075;
AVL_Mach7.Cl_sig       = abs(AVL_Mach7.Cl-WT_Mach7.Cl)./1.7;
AVL_Mach7.Cm_sig       = abs(AVL_Mach7.Cm-WT_Mach7.Cm)./1.7;
AVL_Mach7.Cn_sig       = abs(AVL_Mach7.Cn-WT_Mach7.Cn)./1.7;


AVL_Mach75.alpha        = AVL_M75(:,1);
AVL_Mach75.CL           = AVL_M75(:,2);
AVL_Mach75.CD           = AVL_M75(:,3);
AVL_Mach75.Cl           = AVL_M75(:,5);
AVL_Mach75.Cm           = AVL_M75(:,6);
AVL_Mach75.Cn           = AVL_M75(:,7);
AVL_Mach75.CL_sig       = abs(AVL_Mach75.CL-WT_Mach75.CL)./1.7;
AVL_Mach75.CL_sig(AVL_Mach75.CL_sig<0.015) = 0.03;
AVL_Mach75.CD_sig       = abs(AVL_Mach75.CD-WT_Mach75.CD)./1.7;
AVL_Mach75.CD_sig(AVL_Mach75.CD_sig<0.005) = 0.0075;
AVL_Mach75.Cl_sig       = abs(AVL_Mach75.Cl-WT_Mach75.Cl)./1.7;
AVL_Mach75.Cm_sig       = abs(AVL_Mach75.Cm-WT_Mach75.Cm)./1.7;
AVL_Mach75.Cn_sig       = abs(AVL_Mach75.Cn-WT_Mach75.Cn)./1.7;

AVL_Mach8.alpha        = AVL_M8(:,1);
AVL_Mach8.CL           = AVL_M8(:,2);
AVL_Mach8.CD           = AVL_M8(:,3);
AVL_Mach8.Cl           = AVL_M8(:,5);
AVL_Mach8.Cm           = AVL_M8(:,6);
AVL_Mach8.Cn           = AVL_M8(:,7);
AVL_Mach8.CL_sig       = abs(AVL_Mach8.CL-WT_Mach8.CL)./1.7;
AVL_Mach8.CL_sig(AVL_Mach8.CL_sig<0.015) = 0.03;
AVL_Mach8.CD_sig       = abs(AVL_Mach8.CD-WT_Mach8.CD)./1.7;
AVL_Mach8.CD_sig(AVL_Mach8.CD_sig<0.005) = 0.0075;
AVL_Mach8.Cl_sig       = abs(AVL_Mach8.Cl-WT_Mach8.Cl)./1.7;
AVL_Mach8.Cm_sig       = abs(AVL_Mach8.Cm-WT_Mach8.Cm)./1.7;
AVL_Mach8.Cn_sig       = abs(AVL_Mach8.Cn-WT_Mach8.Cn)./1.7;

AVL_Mach83.alpha        = AVL_M83(:,1);
AVL_Mach83.CL           = AVL_M83(:,2);
AVL_Mach83.CD           = AVL_M83(:,3);
AVL_Mach83.Cl           = AVL_M83(:,5);
AVL_Mach83.Cm           = AVL_M83(:,6);
AVL_Mach83.Cn           = AVL_M83(:,7);
AVL_Mach83.CL_sig       = abs(AVL_Mach83.CL-WT_Mach83.CL)./1.7;
AVL_Mach83.CL_sig(AVL_Mach83.CL_sig<0.015) = 0.03;
AVL_Mach83.CD_sig       = abs(AVL_Mach83.CD-WT_Mach83.CD)./1.7;
AVL_Mach83.CD_sig(AVL_Mach83.CD_sig<0.005) = 0.0075;
AVL_Mach83.Cl_sig       = abs(AVL_Mach83.Cl-WT_Mach83.Cl)./1.7;
AVL_Mach83.Cm_sig       = abs(AVL_Mach83.Cm-WT_Mach83.Cm)./1.7;
AVL_Mach83.Cn_sig       = abs(AVL_Mach83.Cn-WT_Mach83.Cn)./1.7;

AVL_Mach85.alpha        = AVL_M85(:,1);
AVL_Mach85.CL           = AVL_M85(:,2);
AVL_Mach85.CD           = AVL_M85(:,3);
AVL_Mach85.Cl           = AVL_M85(:,5);
AVL_Mach85.Cm           = AVL_M85(:,6);
AVL_Mach85.Cn           = AVL_M85(:,7);
AVL_Mach85.CL_sig       = abs(AVL_Mach85.CL-WT_Mach85.CL)./1.7;
AVL_Mach85.CL_sig(AVL_Mach85.CL_sig<0.015) = 0.03;
AVL_Mach85.CL_sig(AVL_Mach85.CL_sig>.15) = .15;
AVL_Mach85.CL_sig(AVL_Mach85.alpha>5) = .15;

AVL_Mach85.CD_sig       = abs(AVL_Mach85.CD-WT_Mach85.CD)./5;
AVL_Mach85.CD_sig(AVL_Mach85.CD_sig<0.005) = 0.005;
AVL_Mach85.Cl_sig       = abs(AVL_Mach85.Cl-WT_Mach85.Cl)./1.7;
AVL_Mach85.Cm_sig       = abs(AVL_Mach85.Cm-WT_Mach85.Cm)./4;
AVL_Mach85.Cn_sig       = abs(AVL_Mach85.Cn-WT_Mach85.Cn)./1.7;

AVL_Mach86.alpha        = AVL_M86(:,1);
AVL_Mach86.CL           = AVL_M86(:,2);
AVL_Mach86.CD           = AVL_M86(:,3);
AVL_Mach86.Cl           = AVL_M86(:,5);
AVL_Mach86.Cm           = AVL_M86(:,6);
AVL_Mach86.Cn           = AVL_M86(:,7);
AVL_Mach86.CL_sig       = abs(AVL_Mach86.CL-WT_Mach86.CL)./1.7;
AVL_Mach86.CL_sig(AVL_Mach86.CL_sig<0.015) = 0.03;
AVL_Mach86.CD_sig       = abs(AVL_Mach86.CD-WT_Mach86.CD)./1.7;
AVL_Mach86.CD_sig(AVL_Mach86.CD_sig<0.005) = 0.0075;
AVL_Mach86.Cl_sig       = abs(AVL_Mach86.Cl-WT_Mach86.Cl)./1.7;
AVL_Mach86.Cm_sig       = abs(AVL_Mach86.Cm-WT_Mach86.Cm)./1.7;
AVL_Mach86.Cn_sig       = abs(AVL_Mach86.Cn-WT_Mach86.Cn)./1.7;

AVL_Mach87.alpha        = AVL_M87(:,1);
AVL_Mach87.CL           = AVL_M87(:,2);
AVL_Mach87.CD           = AVL_M87(:,3);
AVL_Mach87.Cl           = AVL_M87(:,5);
AVL_Mach87.Cm           = AVL_M87(:,6);
AVL_Mach87.Cn           = AVL_M87(:,7);
AVL_Mach87.CL_sig       = abs(AVL_Mach87.CL-WT_Mach87.CL)./1.7;
AVL_Mach87.CL_sig(AVL_Mach87.CL_sig<0.015) = 0.03;
AVL_Mach87.CD_sig       = abs(AVL_Mach87.CD-WT_Mach87.CD)./1.7;
AVL_Mach87.CD_sig(AVL_Mach87.CD_sig<0.005) = 0.0075;
AVL_Mach87.Cl_sig       = abs(AVL_Mach87.Cl-WT_Mach87.Cl)./1.7;
AVL_Mach87.Cm_sig       = abs(AVL_Mach87.Cm-WT_Mach87.Cm)./1.7;
AVL_Mach87.Cn_sig       = abs(AVL_Mach87.Cn-WT_Mach87.Cn)./1.7;

save('GP_3F_CRM_Data.mat','AVL_Mach7','AVL_Mach85','SU2_Mach7','SU2_Mach85','SU2_Mach85_full','SU2_Mach85_uq','WT_Mach7','WT_Mach85');
save('GP_2F_2D_CRM_Data.mat','AVL_Mach7','AVL_Mach75','AVL_Mach8','AVL_Mach83','AVL_Mach85','AVL_Mach86','AVL_Mach87','WT_Mach7','WT_Mach75','WT_Mach8','WT_Mach83','WT_Mach85','WT_Mach86','WT_Mach87');