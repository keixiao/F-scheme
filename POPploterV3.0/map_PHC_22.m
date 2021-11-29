
run header.m
%%
%  dz=z_w_bot(2:end)-z_w_bot(1:end-1);
%  dz_3d=zeros(360,341,59);
%  for i=1:360
%      for j=1:341
%          dz_3d(i,j,:)=dz;
%      end
%  end

%%
% SALT_pc={};
tpdeplev=[0 50 100 150 200 300 400 500 750 ...
    1000 1250 1500 2000 2500 3000 4000 5500];
im=3;jn=2;
nflag=2;
figure('position',[100 00 220*jn*2 155*im*2])
ha = tight_subplot(im,jn,[.02 .02],[.07 .03],[.05 .02]);
% ha = tight_subplot(im,jn,[.015 .014],[.025 .01],[.026 .01]);
% ha = tight_subplot(im,jn,[0.02 0.01]);
hi=0;
% bias=zeros(im,jn,2);
for ni=1:length(casealias)
    if ni==1
        titlestr{ni}=[casealias{1},' - PHC2'];
        %         titlestr{ni}=[casealias{6},' - ',casealias{2}];
    elseif ni==2 || ni==3
        titlestr{ni}=[casealias{ni},' - ',casealias{1}];
        %         titlestr{ni}=[casealias{ni},' - ','PHC2'];
    elseif ni==4
        titlestr{ni}=[casealias{ni},' - ',casealias{1}];
        %         titlestr{ni}=[casealias{ni},' - ','PHC2'];
    end
end
titlestr{1}=[casealias{1},' - OBS'];
titlestr{2}=[casealias{3},' - OBS'];
titlestr{3}=[casealias{4},' - OBS'];

pictype='map' % profile;map
jvar=4;
% PPCCflag=0;
% PPCC=PPCCsalt;
%map
% dep=[0 200 500 1500 5500];
% dep=[0 100 1500 4000 5500];
% deploc=[1 20 40 50 56];
% depstr={'0 m','200 m','1000 m','3000 m','4500 m'};
% deploc=[10 20 33 40 44];
% depstr={'100 m','200 m','500 m','1000 m','1500 m'};
% deploc=[0 20 33 44 59];
% depstr={'0~200m','200~500m','500~1500m','1500~bottom'};
deploc=[0 1 10 44 54 59];
depstr={'0~BLD','BLD~1000m','100~1500m','1500~4000m','4000~bottom'};
HBLTloc=HBLTloc;
%%
for ii=1:im
    for jj=1:jn
        hi=hi+1
        %         nk=floor((hi-1)/4)+1;
        
        axes(ha(hi))
        
        switch jj
            case 1
                picflag=2;picopt=1;
            case 2
                %                 picflag=2;picopt=1;i=2;
                picflag=2;picopt=1;
            case 3
                %                 picflag=2;picopt=1;i=3;
                picflag=2;picopt=1;
            case 4
                %                 picflag=2;picopt=1;i=1;
                picflag=2;picopt=1;
            case 5
                %                 picflag=2;picopt=1;i=4;
                picflag=2;picopt=1;
        end
        run varioptions.m
        switch variname{jvar}
            case 'TEMP'
                if jj==1
                    cmin=-4 ;cmax=4 ; dv=1;
                    %                     cmin=-2 ;cmax=2 ; dv=0.5;
                else
                    cmin=-4 ;cmax=4  ;dv=1;
                    %                     cmin=-2 ;cmax=2 ; dv=0.5;
                end
                cmap=cmocean('balance',32);
                %                 cmap(cmap_len/2,:)=cmap(cmap_len/2+1,:);
            case 'SALT'
                if jj==1
                    cmin=-1.0; cmax=1.0; dv=0.2;
                    %                     cmin=-0.5; cmax=0.5; dv=0.1;
                else
                    cmin=-1.0; cmax=1.0; dv=0.2;
                    %                     cmin=-0.5; cmax=0.5; dv=0.1;
                    
                end
                cmap=cmocean('balance',20);
                %                 cmap(cmap_len/2,:)=cmap(cmap_len/2+1,:);
        end
        %% mask
        
        if ii==1
            mask_t_3d=seamask_interp(:,:,:,5);
        elseif ii==2
            mask_t_3d=seamask_interp(:,:,:,hi-1);
            for n=1:60
                tmask=mask_t_3d(:,:,n);
                tmask(abs(interpLAT)>60.5)=nan;
                mask_t_3d(:,:,n)=tmask;
            end
        end
        
        %% varible name
        switch hi
            case 1
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                vn1str1=[casename{1},'_'];vn1str2=[variname{jvar},timestr];
                
                switch jvar
                    case 4
                        vn2str1='tempphc';vn2str2='';
                    case 5
                        vn2str1='saltphc';vn2str2='';
                end
                %                 vn2str1=[casename{2},'_'];vn2str2=[variname{jvar},timestr];
            case 2
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                vn1str1=[casename{1},'_'];vn1str2=[variname{jvar},timestr];
                switch jvar
                    case 4
                        vn2str1='tempphc';vn2str2='';
                    case 5
                        vn2str1='saltphc';vn2str2='';
                end
                %                 vn2str1=[casename{2},'_'];vn2str2=[variname{jvar},timestr];
            case 3
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                vn1str1=[casename{3},'_'];vn1str2=[variname{jvar},timestr];
                switch jvar
                    case 4
                        vn2str1='tempphc';vn2str2='';
                    case 5
                        vn2str1='saltphc';vn2str2='';
                end
                %                 vn2str1=[casename{2},'_'];vn2str2=[variname{jvar},timestr];
            case 4
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                vn1str1=[casename{3},'_'];vn1str2=[variname{jvar},timestr];
                switch jvar
                    case 4
                        vn2str1='tempphc';vn2str2='';
                    case 5
                        vn2str1='saltphc';vn2str2='';
                end
            case 5
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                vn1str1=[casename{4},'_'];vn1str2=[variname{jvar},timestr];
                switch jvar
                    case 4
                        vn2str1='tempphc';vn2str2='';
                    case 5
                        vn2str1='saltphc';vn2str2='';
                end
                
            case 6
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                vn1str1=[casename{4},'_'];vn1str2=[variname{jvar},timestr];
                switch jvar
                    case 4
                        vn2str1='tempphc';vn2str2='';
                    case 5
                        vn2str1='saltphc';vn2str2='';
                end
                
                
        end
        
        vn1=[vn1str1,vn1str2,'_interp'];
        vn2=[vn2str1,vn2str2,'_interp'];
        if jj==10
            Vpdstr=[vn2str1,'PD',timestr,'_interp'];
            eval(['Vpd=',Vpdstr,'.*mask_t_3d;']);
            %     Vpd=K_T_PD_avg_491_500_interp.*mask_t_3d;
            hold on
            Vpd=Vpd*1000-1000;
        else
            hold on
            Vpd=pdphc_interp.*mask_t_3d;
            Vpd=Vpd-1000;
        end
        Vq=zeros(360,341);
        %% plot
        switch pictype
            case 'map'
                % map
                
                %%
                set(gca,'looseInset',[0 0 0.03 0]);
                % m_proj('Miller Cylindrical','lon',[0 360],'lat',[-80 90]) %global
                m_proj('Robinson','lon',[30 390],'lat',[-90 90]) %global
                
                clevl=cmin:dv:cmax;
                if jj==1
                    iloc=1;
                elseif jj==2
                    iloc=3;
                end
                
                %                 eval(['VV=',vn1,'(:,:,deploc(iloc)+1:deploc(iloc+1))-',vn2,'(:,:,deploc(iloc)+1:deploc(iloc+1));'])
                %                 %eval(['Vq=',vn1,'(:,:,deploc(ii))-',vn2,'(:,:,deploc(ii));'])
                %                 VV=VV.*dz_3d(:,:,deploc(iloc)+1:deploc(iloc+1));
                %                 for iin=1:360
                %                     for jjn=1:341
                %                         tV=VV(iin,jjn,:);
                %                         Vq(iin,jjn)=nansum(tV)/sum(squeeze(~isnan(tV)).*dz(deploc(iloc)+1:deploc(iloc+1)));
                %                         %                        Vq=nansum(VV,3)/(z_t(deploc(ii+1))-z_t(deploc(ii)+1));
                %                     end
                %                 end
                for iin=1:360
                    for jjn=1:341
                        if ~isnan(HBLTloc(iin,jjn))
                        if jj==1
                            
                            eval(['tV=(',vn1,'(iin,jjn,1:HBLTloc(iin,jjn))-',vn2,...
                                '(iin,jjn,1:HBLTloc(iin,jjn))).*dz_3d(iin,jjn,1:HBLTloc(iin,jjn));'])
                            %                         tV=VV(iin,jjn,:);
                            Vq(iin,jjn)=nansum(tV)/sum(squeeze(~isnan(tV)).*dz(1:HBLTloc(iin,jjn)));
                            %                        Vq=nansum(VV,3)/(z_t(deploc(ii+1))-z_t(deploc(ii)+1));
                            
                        elseif jj==2
                            
                            
                            eval(['tV=(',vn1,'(iin,jjn,HBLTloc(iin,jjn)+1:40)-',vn2,...
                                '(iin,jjn,HBLTloc(iin,jjn)+1:40)).*dz_3d(iin,jjn,HBLTloc(iin,jjn)+1:40);'])
                            %                         tV=VV(iin,jjn,:);
                            Vq(iin,jjn)=nansum(tV)/sum(squeeze(~isnan(tV)).*dz(HBLTloc(iin,jjn)+1:40));
                            %                        Vq=nansum(VV,3)/(z_t(deploc(ii+1))-z_t(deploc(ii)+1));
                            
                        end
                        end
                    end
                end
                %pcolor
                xx=cmta(interpLONG,30,360);
                zz=cmta(Vq,30,0);
                %                 m_pcolor(interpLONG,interpLAT,Vq);
                m_pcolor(xx,interpLAT,zz);
                %                 Std_minus_phc{hi,jvar-3,nflag}=zz;
                shading flat
                hold on
                m_plot(0:15:390,(0:15:390)*0+10,'--','color',[0.2 0.2 0.2])
                m_plot(0:15:390,(0:15:390)*0-10,'--','color',[0.2 0.2 0.2])
                %colorbar & colormap settings
                colorbar(ha(hi));colorbar off;
                colormap(cmap)
                caxis([clevl(1) clevl(end)])
                
                %contour
                %                 hold on
                %                 clevl=cmin:dv:cmax;
                %                 [c,h]=m_contour(interpLONG,interpLAT,Vq,clevl);
                %                 clabel(c,h);
                %                 set(h,'ShowText','off','TextList',clevl)
                %                 set(h,'linecolor','k','linestyle','-','linewidth',0.1)
                
                %axes setting
                %                 titname='';
                %                 tn=[titname,' ',num2str(dep(nn),'%4.1f'),'~',num2str(dep(nn+1),'%4.1f'),'m'];
                %                 title(tn,'Interpreter','none')
                set(gca,'fontsize',8)
                m_coast('patch',[0.7 0.7 0.7],'edgecolor',[0.7 0.7 0.7]);
                
                hold on
                
                %%
                switch hi
                    case 1
                        %                 m_text(1,85,'KPP 196~200 - WOA')
                        %                                                 m_text(1,91.5,titlestr{hi},'interpreter','none','fontsize',10,'fontweight','bold')
                        title(titlestr{hi},'interpreter','none','fontweight','bold')
                    case 2
                        %                 m_text(1,85,'KPP+Tide 196~200 - KPP 196~200')
                        %                                                 m_text(1,91.5,titlestr{hi},'interpreter','none','fontsize',10,'fontweight','bold')
                        title(titlestr{hi},'interpreter','none','fontweight','bold')
                    case 3
                        %                 m_text(1,85,'KPP+Fine 96~100 - KPP 196~200')
                        %                                                 m_text(1,91.5,titlestr{hi},'interpreter','none','fontsize',10,'fontweight','bold')
                        title(titlestr{hi},'interpreter','none','fontweight','bold')
                    case 4
                        %                 m_text(1,85,'KPP 96~100 - KPP 196~200')
                        %                                                 m_text(1,91.5,titlestr{hi},'interpreter','none','fontsize',10,'fontweight','bold')
                        title(titlestr{hi},'interpreter','none','fontweight','bold')
                end
                m_text(50,50,char(96+hi),'fontsize',10,'fontweight','bold','backgroundcolor', [.99 .99 .99], 'edgecolor', 'k','margin',1.5)
                if jj==1
                    m_text(485,85,titlestr{ii},'backgroundcolor', [.99 .99 .99], 'edgecolor', 'k')
                end
                %                 switch hi
                %                     case 1
                %                         m_text(6.3,-75.2,depstr{1},'fontsize',8,'fontweight','bold')
                %                     case 5
                %                         m_text(6.3,-75.2,depstr{2},'fontsize',8,'fontweight','bold')
                %                     case 9
                %                         m_text(6.3,-75.2,depstr{3},'fontsize',8,'fontweight','bold')
                %                     case 13
                %                         m_text(6.3,-75.2,depstr{4},'fontsize',8,'fontweight','bold')
                %                 end
                %                 if jj==1
                m_text(39.5,-75.2,depstr{jj},'fontsize',8,'fontweight','bold')
                %                 end
                title(' ')
                % xytick
                if ii<im && jj==1
                    m_grid('box','on','tickdir','out','xtick',30:90:390,'xticklabels',[],...
                        'ytick',[-90 -65 -40 -10 10 40 65 90],'linestyle','none');
                elseif ii==im && jj>1
                    m_grid('box','on','tickdir','out','xtick',30:90:390,...
                        'ytick',[-90 -65 -40 -10 10 40 65 90],'yticklabels',[],'linestyle','none');
                elseif ii==im && jj==1
                    m_grid('box','on','tickdir','out','xtick',30:90:390,...
                        'ytick',[-90 -65 -40 -10 10 40 65 90],'linestyle','none');
                else
                    m_grid('box','on','tickdir','out','xtick',30:90:390,'xticklabels',[],...
                        'ytick',[-90 -65 -40 -10 10 40 65 90],'yticklabels',[],'linestyle','none');
                end
                set(gca,'tickdir','out')
                pause(1)
                
                
                
        end
        
        
        %% colorbar
        %         if jj==1  && ii==im
        %             if jvar==4||jvar==5
        %                 cb=colorbar('horiz',...
        %                     'position',[0.03 0.025 0.225 0.02]);
        %                 caxis([cmin cmax])
        %                 %                 pause
        %                 if picflag==2
        %                     set(cb,'xtick',cmin:dv:cmax)%,'xticklabel',sprintf('\n%1.1f',cmin:dv:cmax));
        %                 else
        %                     set(cb,'xtick',clevl)
        %                 end
        %                 set(cb,'ticklength',0)
        %             end
        %
        %         end
        if jj==jn && ii==im
            if jvar==4||jvar==5
                cb=colorbar('horiz',...
                    'position',[0.1 0.028 0.8 0.02]);
                caxis([cmin cmax])
                %                 pause
                if picflag==2
                    set(cb,'xtick',cmin:dv:cmax)%,'xticklabel',sprintf('\n%1.1f',cmin:dv:cmax));
                else
                    set(cb,'xtick',clevl)
                end
                
                set(get(cb,'title'),'string',vunit,'position',[555 0 0])
                set(cb,'ticklength',0)
            end
            
        end %if jj==jn
        %     pause
    end %jj
end %ii
set(ha,'tickdir','out')
% switch pictype
%     case 'map'
%         for i=1:4
%             axes(ha(i))
%             title(titlestr{i})
%         end
% end