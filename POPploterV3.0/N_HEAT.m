% legendias={'K','KT','KF','KFT','PHC'};
% lstyle={'-','--','-','--','-','-'};
lstyle={'-','-','-','-','-','-'};
% lcolor={'k','k',[0.850,  0.325,  0.098],[0.850,  0.325,  0.098],[0.000,  0.447,  0.741],[0.466,  0.674,  0.188],...
%     'b','b',};
lcolor=  [ 0.000,  0.447,  0.741
  0.850,  0.325,  0.098
  0.929,  0.694,  0.125
  0.494,  0.184,  0.556
  0.466,  0.674,  0.188
  0.301,  0.745,  0.933
  0.635,  0.078,  0.184];
lwidth=[1 1 1 1 1 1]*1.5;

run header.m
% casename={'K','KF','K_p','KF_p','KFnT','KFnTnb'};
% disp("casename={'K','KF','K_p','KF_p'}")
% casealias={'K','KF','K-p','KF-p','KF-nT','KF-nT-p'};
for nn=1:4
    switch nn
        case 1
            timestr='_avg_346_350';
        case 2
            timestr='_avg_296_300';
            
        case 3
            timestr='_avg_251-300';
        case 4
            timestr='_avg_251-300';
        case 5
            timestr='_avg_251-300';
        case 6
            timestr='_avg_296_300';
            
    end
    
    
    fn=['N_HEAT\',casename{nn},'_N_HEAT',timestr,'.nc'];
    tmp_nheat=ncread(fn,'N_HEAT');
    n_heat(:,nn,1)=squeeze(nanmean(tmp_nheat(:,1,1,end-4:end),4));
    n_heat(:,nn,2)=squeeze(nanmean(tmp_nheat(:,2,2,end-4:end),4));
end
%%
im=2;jn=1;

figure('position',[100 60 600*jn 360*im])
ha = tight_subplot(im,jn,[.03 .03],[.065 .02],[.1 .04]);
hi=0;
for ii=1:im
    hi=hi+1;
    axes(ha(hi))
    
    for nk=1:4
        hold on
        hp(nk)=plot(lat_aux_grid,n_heat(:,nk,hi),'color',lcolor(nk,:),...
            'linestyle',lstyle{nk},'linewidth',lwidth(nk));
%         alpha(hp(nk),0.5)
    end
    
    hold on
    line([-90 90],[0 0],'color',[0.5 0.5 0.5],'linewidth',1)
    set(gca,'box','on','tickdir','out','linewidth',1.25)
    xlim([-90 90])
    set(gca,'xtick',-90:30:90,'xticklabel',{'90°S','60°S','30°S','0°','30°N','60°N','90°N'})
    set(gca,'ytick',-1:0.5:2.5,'yticklabel',sprintf('%2.1f\n',(-1:0.5:2.5)))
    
    
    ylabel('PW')
    
    
    if hi==1
        dxMINORXY(3,2)
        ylim([-1 2])
        text(-87,1.8,'(a) Global','fontsize',10)
        set(gca,'xtick',[])
%,'orientation','horizontal'
    elseif hi==2
        dxMINORXY(3,5)
        ylim([-0.1 1.1])
        text(-87,1.,'(b) Atlantic','fontsize',10)
        ld=legend(casealias{1:4});
        set(ld,'orientation','vertical','box','off','interpreter','none','location','best')
    end
    
    
end