
run header.m
%%
%  dz=z_w_bot(2:end)-z_w_bot(1:end-1);
%  dz_3d=zeros(360,341,59);
%  for i=1:360
%      for j=1:341
%          dz_3d(i,j,:)=dz;
%      end
%  end
load('G:\pop_fine\POP2ploterV2.0\mat\NCLcmap.mat','GMT_haxby');
%%
% SALT_pc={};
tpdeplev=[0 50 100 150 200 300 400 500 750 ...
    1000 1250 1500 2000 2500 3000 4000 5500];
im=2;jn=2;
nflag=2;
figure('position',[100 00 180*jn*2 140*im*2])
ha = tight_subplot(im,jn,[.05 .02],[.1 .03],[.05 .02]);

hi=0;

pictype='map' % profile;map
jvar=3;

deploc=[20 33 43 50];
depstr={'200m','500m','1500m','3000m'};
% HBLTloc=HBLTloc;
%%
for ii=1:im
    for jj=1:jn
        hi=hi+1
        %         nk=floor((hi-1)/4)+1;
        
        axes(ha(hi))
%         switch ii
%             case 1
%                 jvar=4;
%             case 2
%                 jvar=5;
%         end
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
            case 'VDCS'
                cmin=0.01;cmax=0.49;dv=0.03;
                cmap=GMT_haxby;
                cmap_len=size(cmap,1);
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

%         vn1='real(VDC_KF_T)*10000';
%         vn2='blank';
        Vq=nan(360,341);
        %% plot
        switch pictype
            case 'map'
                % map
                
                %%
                set(gca,'looseInset',[0 0 0.03 0]);
                % m_proj('Miller Cylindrical','lon',[0 360],'lat',[-80 90]) %global
                m_proj('Robinson','lon',[30 390],'lat',[-90 90]) %global
                
                clevl=cmin:dv:cmax;

                Vq=real(VDC_KF_T(:,:,deploc(hi)))*10000;Vq(:,161)=0.01;
                Vq=Vq.*tflag;Vq(Vq==0)=nan;
                
                %pcolor
                
                Vq(360,:)=Vq(359,:);
                Vq(1,:)=Vq(2,:);
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
%                 cb(ha(hi))=colorbar(ha(hi));colorbar off;
                colormap(cmap)
                caxis([cmin cmax])
%                 if jvar==4
%                     caxis([-2.25 2.25])
%                 elseif jvar==5
%                     caxis([-0.55 0.55])
%                 end

                set(gca,'fontsize',8)
                m_coast('patch',[0.7 0.7 0.7],'edgecolor',[0.7 0.7 0.7]);
                
                hold on
                
                %%

                m_text(50,50,char(96+hi),'fontsize',10,'fontweight','bold','backgroundcolor', [.99 .99 .99], 'edgecolor', 'k','margin',1.5)
%                 if jj==1
%                     m_text(485,85,titlestr{ii},'backgroundcolor', [.99 .99 .99], 'edgecolor', 'k')
%                 end
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
                m_text(66.5,-75.2,depstr{hi},'fontsize',8,'fontweight','bold'...
                    ,'backgroundcolor', [.99 .99 .99], 'edgecolor', 'k')
                %                 end
                title(' ')
                % xytick
                if ii<im && jj==1
                    m_grid('box','on','tickdir','out','xtick',30:90:390,...
                        'ytick',[-90 -65 -40 -10 10 40 65 90],'linestyle','none');
                elseif ii==im && jj>1
                    m_grid('box','on','tickdir','out','xtick',30:90:390,...
                        'ytick',[-90 -65 -40 -10 10 40 65 90],'yticklabels',[],'linestyle','none');
                elseif ii==im && jj==1
                    m_grid('box','on','tickdir','out','xtick',30:90:390,...
                        'ytick',[-90 -65 -40 -10 10 40 65 90],'linestyle','none');
                else
                    m_grid('box','on','tickdir','out','xtick',30:90:390,...
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
            
                cb=colorbar('horiz',...
                    'position',[0.1 .035 0.8 0.02]);
                colormap(cb,cmap)
                caxis([cmin cmax])
%                 if jvar==4
%                     caxis([-2.25 2.25])
%                 elseif jvar==5
%                     caxis([-0.55 0.55])
%                 end
                %                 pause

                    set(cb,'xtick',cmin:dv:cmax,'xticklabel',sprintf('%1.2f\n',cmin:dv:cmax));


                
                set(get(cb,'title'),'string',vunit,'position',[455 0 0])
                set(cb,'ticklength',0)
            
            
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