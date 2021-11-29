%%
%NPIWscript -> NPIWplot
NPIW=cell(3,5);
for icase=1:4
eval(['TEMP=',casename{icase},'_',variname{4},'_avg_296_300_interp;'])
eval(['SALT=',casename{icase},'_',variname{5},'_avg_296_300_interp;'])
eval(['PD=',casename{icase},'_',variname{7},'_avg_296_300_interp*1000;'])
z   =z_t;
sigma = 1026.8;

[temp_NPIW,salt_NPIW,depth_NPIW,kloc2d]=NPIWcalmod(TEMP,SALT,PD,z,sigma);
NPIW{1,icase}=salt_NPIW;
NPIW{2,icase}=temp_NPIW;
NPIW{3,icase}=depth_NPIW;
% pop_nt_kloc2d_avg_96_100=kloc2d;

end

TEMP=ptmpphc_interp;
SALT=saltphc_interp;
PD  =pdphc_interp;  
z   =z_t;
sigma = 1026.8;

[temp_NPIW,salt_NPIW,depth_NPIW,kloc2d]=NPIWcalmod(TEMP,SALT,PD,z,sigma);

% phc_temp_NPIW=temp_NPIW;
% phc_salt_NPIW=salt_NPIW;
% phc_depth_NPIW=depth_NPIW;
NPIW{1,5}=salt_NPIW;
NPIW{2,5}=temp_NPIW;
NPIW{3,5}=depth_NPIW;
