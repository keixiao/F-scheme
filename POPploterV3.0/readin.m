casename={'KFTadd','KFadd'};
variname={'VVC','VDCT','VDCS','TEMP','SALT','RHO','PD','HBLT','SSH','KVMIX','MOC',...
    'UVEL','VVEL','WVEL'};
% jloc=[12 13 14];
for icase=[1 2] %case
    for jn=[11] %vari
%             jvar=jloc(jn);
%             j=jn;
        disp((icase)*100+jn);
         if icase == 1 || icase == 2 || icase == 6
             timestr='_avg_251-300';
         else
             timestr='_avg_251-300';
         end
%                 timestr='_avg_491_500';

pn1=['D:\POPArchive\',casename{icase},'\'];
fn1=[casename{icase},'_',variname{jn},timestr,'.nc'];

switch variname{jn}
    case 'VDCS'
        v_name='VDC_S';
    case 'VDCT'
        v_name='VDC_T';
    otherwise
        v_name=variname{jn};
end
tstr2='_avg_296_300';
vn1=[casename{icase},'_',variname{jn},tstr2];
tmp=ncread(fullfile(pn1,fn1),v_name);
switch v_name
    case 'MOC'
        eval([vn1,'=nanmean(tmp(:,:,:,:,41:50),5);'])
    otherwise
        eval([vn1,'=nanmean(tmp(:,:,:,46:50),4);'])
end

        
    end
end