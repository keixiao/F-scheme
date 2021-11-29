
% 
% F_VDC=squeeze(VDC_KF_T(i,j,:))/10000;
% F_VDC(F_VDC<1e-6)=1e-6;
% F_VVC=squeeze(abs(real(VVC_KF_T(i,j,:))));
% F_VVC(F_VVC<1e-5)=1e-5;
% T_VDC=squeeze(KVMIX_interp(i,j,:))/10000;
 BCK=(zeros(size(z_t))+0.172)/10000;
% 
% F_VDC(z_t<HBLT_interp(i,j))=nan;
% F_VVC(z_t<HBLT_interp(i,j))=nan;
% figure('position',[681   483   358   496])
% 
% semilogx(F_VDC,z_t,'-k');
% hold on
% % semilogx(T_VDC-BCK,z_t);
% semilogx(F_VVC,z_t,'--k');
% semilogx(BCK,z_t,'-.k');
% semilogx(BCK*10,z_t,':k');
% 
% set(gca,'ydir','reverse')
% set(gca,'tickdir','out','linewidth',2)
% xlim([8e-7 3e-4])
% ylim([0 5500])
% xlabel('Mixing Coefficient/m^2s^-^1')
% ylabel('depth/m')
% 
% plot([8e-7 3e-4],[66.8 66.8],'-k')
% 
% legend('K_v (F)','A_v (F)','K_v (BCK)','A_v (BCK)','edgecolor','w')

VDC=real(VDC_KF_T);VDC(VDC==0)=nan;
VVC=real(VVC_KF_T);VVC(VVC==0)=nan;
figure('position',[681   483   358   496])
listyle={'-','--',':','-.'};
clr={'k','r'};
i=330;
j=119;
for hi=1:3
    
    mask_t_3d=seamask_TS(:,:,:,hi);
            mask_t_3d(abs(interpLAT_3d)>60)=nan;
            mask_t_3d(abs(interpLAT_3d)<10)=nan;
    tVDC=VDC.*mask_t_3d;
    tVVC=VVC.*mask_t_3d;
    
    for k=1:60
    tVDC1d(k)=nanmean(reshape(tVDC(:,:,k),[],1));
    tVVC1d(k)=nanmean(reshape(tVVC(:,:,k),[],1));
    if k==33
        max(reshape(tVDC(:,:,k),[],1))
    end
    end
    tVDC1d(tVDC1d<0)=nan;
    tVVC1d(tVVC1d<0)=nan;
    
%     tVDC1d(20)
    tVDC1d(33)
    
    tVDC1d(z_t<HBLT_interp(i,j))=nan;
    tVVC1d(z_t<HBLT_interp(i,j))=nan;

hld(hi)=semilogx(tVDC1d,z_t,listyle{hi},'color',clr{1});
hold on
semilogx(tVVC1d,z_t,listyle{hi},'color',clr{2});

end

    hld(4)=semilogx(BCK,z_t,listyle{hi},'color',clr{1});
    semilogx(BCK*10,z_t,listyle{hi},'color',clr{2});
    
plot([6e-7 3e-4],[HBLT_interp(i,j) HBLT_interp(i,j)],'-k')

set(gca,'ydir','reverse')
set(gca,'tickdir','out','linewidth',1.5)
xlim([6e-7 3e-4])
ylim([0 5500])
xlabel('Mixing Coefficient/m^2s^-^1')
ylabel('depth/m')

legend(hld,seaname_TS{1:3},'BCK','edgecolor','w')


