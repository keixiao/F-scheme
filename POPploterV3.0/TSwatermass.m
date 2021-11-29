% load seaname.mat
% load TSP.mat
run header.m
%  variname={'VVC','VDCT','VDCS','TEMP','SALT','RHO','PD','HBLT','SSH','KVMIX'};
%%
% SALT_pc={};

im=2;jn=2;
% depthloc=[0 10 44 54 59];
% depstr={'0~100m','100~1500m','1500~4000m','4000~bottom'};
depthloc=[0 10 40 44 54 59];
depstr={'0~100m','100~1000m','1000~1500m','1500~4000m','4000~bottom'};
for nn=1:2
deploc=[depthloc(nn)+1 depthloc(nn+1)]
hi=0
figure('position',[100 60 255*jn*1.4 255*im*1.4])
ha = tight_subplot(im,jn,[.05 .05],[.075 .028],[.075 .015]);
% ha = tight_subplot(im,jn,[.015 .014],[.025 .01],[.026 .01]);
% ha = tight_subplot(im,jn,[0.02 0.01]);
hi=0;

% depthloc=[1 20 33 40 44 60];

%%
for ii=1:im
    for jj=1:jn
        hi=hi+1
        %         nk=floor((hi-1)/4)+1;

        axes(ha(hi))
        
        mask_t_3d=seamask_TS(:,:,:,hi);
                if hi~=4
                    for n=1:60
                        tmask=mask_t_3d(:,:,n);
%                         tmask(interpLAT<-33.5)=nan;
%                         tmask(abs(interpLAT)>15)=nan;
                        tmask(abs(interpLAT)>60)=nan;
%                         tmask(abs(interpLAT)>10)=nan;
                        mask_t_3d(:,:,n)=tmask;
                    end
                end
        %%
        %PHC
        T0=ptmpphc_interp.*mask_t_3d;
        S0=saltphc_interp.*mask_t_3d;
        [T0_1d,S0_1d,~,~]=TSext(T0,S0,deploc);
        
        % K-p
        T1=K_p_TEMP_avg_296_300_interp.*mask_t_3d;
        S1=K_p_SALT_avg_296_300_interp.*mask_t_3d;
        [T1_1d,S1_1d,~,~]=TSext(T1,S1,deploc);
        % R1_1d=sw_dens0(S1_1d,T1_1d);
        % R1=K_nT_RHO_avg_491_500_interp.*mask_t_3d;
        % [R1_1d_pop_RHO,~    ]=TSext(R1,T1,deploc);
        
        % KF-p
        T2=KF_p_TEMP_avg_296_300_interp.*mask_t_3d;
        S2=KF_p_SALT_avg_296_300_interp.*mask_t_3d;
        
        [T2_1d,S2_1d,~,~]=TSext(T2,S2,deploc);
        

        
        %% pic
        %         figure
        
        hold on
        h1=plot(nan,nan,'.b','markersize',0.01);
        h2=plot(nan,nan,'.r','markersize',0.01);
        h3=plot(nan,nan,'.k','markersize',0.01);

        

        hold on
        [c,h]=contour(Salt_2d,Temp_2d,Pdens_2d-1000,20:0.4:30);
        clabel(c,h)
        set(h,'ShowText','on','TextList',20:0.6:30)
        set(h,'linecolor',[0.65 0.65 0.65],'linestyle','-','linewidth',0.1,'labelspacing',250)
        
%         set(gca,'layer','bottom')
        %  updateContours(h)
        hold on
        if nn==1
            nstep=2;
        else
            nstep=4;
        end
        x0=S0_1d(1:nstep:end);y0=T0_1d(1:nstep:end);
        scatter(x0,y0,0.01,'markerfacecolor','k','markeredgecolor','k'...
            ,'markerfacealpha',.12,'markeredgealpha',.12)
%         k0 = convhull(x0,y0);
%         plot(x0(k0),y0(k0),'k-')
        hold on
        x1=S1_1d(1:nstep:end);y1=T1_1d(1:nstep:end);
        scatter(x1,y1,0.01,'markerfacecolor','b','markeredgecolor','b'...
            ,'markerfacealpha',.12,'markeredgealpha',.12)
%         k1 = convhull(x1,y1);cl
%         plot(x1(k1),y1(k1),'b-')
%         scatter(S1_1d(1:2:end),T1_1d(1:2:end),0.01,'b','markerfacealpha',.6)
        
        hold on
        x2=S2_1d(1:nstep:end);y2=T2_1d(1:nstep:end);
        scatter(x2,y2,0.01,'markerfacecolor','r','markeredgecolor','r'...
            ,'markerfacealpha',.12,'markeredgealpha',.12)
%         k2 = convhull(x2,y2);
%         plot(x2(k2),y2(k2),'-')
%         scatter(S2_1d(1:2:end),T2_1d(1:2:end),0.01,'r','markerfacealpha',.6)
        
        s_min=min([S0_1d;S1_1d;S2_1d]);
        s_max=max([S0_1d;S1_1d;S2_1d]);
        t_min=min([T0_1d;T1_1d;T2_1d]);
        t_max=max([T0_1d;T1_1d;T2_1d]);
        
        xlim([max(round(s_min,1)-0.2,31) min(round(s_max,1)+0.2,38)])
        ylim([max(round(t_min,0)-2,-6) min(round(t_max,0)+2,30)])
        set(gca,'xtick',31:0.8:38,'xticklabel',sprintf('\n%3.1f',31:0.8:38),...
            'ytick',-6:4:30,'yticklabel',sprintf('\n%3.0f',-6:4:30))
        dxMINORXY(4,2)
%          switch hi
%             case 1
%                 xlim([34 36])
%                 ylim([-2 16])
%             case 2
%                 xlim([33 35])
%                 ylim([-2 16])
%             case 3
%                 xlim([34 36])
%                 ylim([-3 16])
%             case 4
%                 xlim([33 35])
%                 ylim([-3 16])
%          end
        
        set(gca,'tickdir','out')
        
        
        set(gca,'box','on')
        axis square
        X=get(gca,'xlim');
        Y=get(gca,'ylim');
        xtxt=X(1)+0.05*(X(2)-X(1));
        ytxt=Y(2)-0.1*(Y(2)-Y(1));
        text(xtxt,ytxt,seaname_TS{hi},'edgecolor','k','backgroundcolor','w','fontsize',11)
       
        %%
        
        %         m_text(60,50,char(96+hi),'fontsize',10,'fontweight','bold','backgroundcolor', [.99 .99 .99], 'edgecolor', 'k','margin',1.5)
        
        %         title(' ')
        % xytick
        
        if ii<im && jj==1
            ylabel('Temperature (℃)')          %set(gca,'xticklabels',[]);
        elseif ii==im && jj>1
%             set(gca,'yticklabels',[]);
            xlabel('Salinity (psu)')
        elseif ii==im && jj==1
            xlabel('Salinity (psu)');ylabel('Temperature (℃)')
        else
            %                     set(gca,'xticklabels',[],'yticklabels',[]);
%             set(gca,'yticklabels',[])
        end
        

        pause(0.5)
        if hi==1
            hl=legend([h1 h2 h3],'\color[rgb]{0 0 1} K-p','\color[rgb]{1 0 0} KF-p','\color[rgb]{0 0 0} PHC','location','southeast');
%             title([num2str(round(z_w_bot(deploc(1)),-1)),'~',num2str(round(z_w_bot(deploc(2)),-1)),'m'])
            title(depstr(nn))
        end
        
        %% colorbar
        
        %     pause
    end %jj
end %ii
% set(ha,'tickdir','out')
end
