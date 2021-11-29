
variname={'VVC','VDCT','VDCS','TEMP','SALT','RHO','PD','HBLT','SSH','KVMIX'};
run header.m
% casename={'K_nT','K_T','KFnew_0','KFTnew_0','KFadd','KFTadd'};
% casealias={'K','KT','KF','KFT','KFadd','KFTadd'};
%  variname={'VVC','VDCT','VDCS','TEMP','SALT','RHO','PD','HBLT','SSH','KVMIX'};
load('G:\pop_fine\POP2ploterV2.0\mat\NCLcmap.mat','GMT_panoply');
%%
 tpdeplev=[0 250 500 750 1000 2000 3000 4000 5000 6000];
%---------%
cmap=GMT_panoply;
cmap_len=size(cmap,1);
cmin=-32;
cmax=32;
vunit='Sv';
%---------%
im=4;jn=2;

figure('position',[100 60 315*jn 225*im*1])
ha = tight_subplot(im,jn,[.035 .055],[.081 .035],[.089 .033]);
% ha = tight_subplot(im,jn,[.015 .014],[.025 .01],[.026 .01]);
% ha = tight_subplot(im,jn,[0.02 0.01]);
hi=0;
% titlestr={'K_T - PHC','KF_T - K_T','K - K_T','KF - K_T'};
pictype='MOC'
%%
for ii=1:im
    for jj=1:jn
        hi=hi+1;
        %         nk=floor((hi-1)/4)+1;
        
        axes(ha(hi));
        
        %% varible name
 
        timestr='_avg_296_300';

        vn1str1=[casename{ii},'_'];vn1str2=['MOC',timestr];
        
        vn1=[vn1str1,vn1str2];
        
        
        %% plot
        switch pictype
                          
            case 'MOC'
                
                [moc_z_1,tpdepticklabel]=unequalcmap(moc_z,tpdeplev);
%                 for i=2:2:length(tpdeplev)
%                     tpdepticklabel{i}='';
%                 end
                
                eval(['MOC=',vn1,';'])
                MOC=mean(MOC(:,:,:,:,:),5);
%                      AMOC=MOC(:,:,:,2);AMOC=sum(AMOC,3);
%                      GMOC=MOC(:,:,:,1);GMOC=sum(GMOC,3);
                AMOC=MOC(:,:,1,2);AMOC=sum(AMOC,3);%Eulerian Mean
                GMOC=MOC(:,:,1,1);GMOC=sum(GMOC,3);%Eulerian Mean
%                 
                
                switch jj
                    case 1
                        VV1=GMOC;
                        cmin=-32;cmax=32;
                        clevl=cmin:8:cmax;
                    case 2
                        VV1=AMOC;
                        cmin=-6;cmax=26;
                        clevl=cmin:4:cmax;
                        max(max(AMOC))
                end
                if ~exist('cmin','var') || ~exist('cmax','var')
                    cmin=min(min(VV1));cmax=max(max(VV1));
                end
                
                % clevl=((1:cmap_len+1)-1)*eval(vpa((cmax-cmin)/cmap_len,2))+eval(vpa(cmin,2));
%                 clevl=cmin:2:cmax;
                % clevl=clevl';
                
%                 VV1=AMOC;
                VV=VV1';
                VV(abs(VV)<=1e-5)=nan;
                
                pcolor(lat_aux_grid,moc_z_1,VV);
                shading interp;
                colormap(cmap)
%                 colormap(gray(32))
%                 colormap(BlueRed(1:252/16:end,:))
                % cb=colorbar;
                % set(get(cb,'title'),'string',vunit)
                caxis([clevl(1) clevl(end)]);
                
                set(gca,'ydir','reverse')
                % set(cb,'xtick',clevl);
                
              if jj==1
                hold on
                [c,h]=contour(lat_aux_grid,moc_z_1,VV,0:4:32);
                set(h,'ShowText','off','TextList',0:4:32)
                set(h,'linecolor','k','linestyle','-','linewidth',0.1,'labelspacing',200)
                
                [c2,h2]=contour(lat_aux_grid,moc_z_1,VV,-32:4:0);
                set(h2,'ShowText','off','TextList',-32:4:0)
                set(h2,'linecolor','k','linestyle',':','linewidth',0.1,'labelspacing',200)
                
                hold on
                [c1,h1]=contour(lat_aux_grid,moc_z_1,VV,-0.01:0.01:0.01);
                set(h1,'linecolor','k','linestyle','-','linewidth',1)
                set(h1,'showtext','off','labelspacing',900)
              elseif jj==2
                 hold on
                [c,h]=contour(lat_aux_grid,moc_z_1,VV,0:2:24);
                set(h,'ShowText','off','TextList',0:2:24)
                set(h,'linecolor','k','linestyle','-','linewidth',0.1,'labelspacing',200)
                
                [c2,h2]=contour(lat_aux_grid,moc_z_1,VV,-24:2:0);
                set(h2,'ShowText','off','TextList',-24:2:0)
                set(h2,'linecolor','k','linestyle',':','linewidth',0.1,'labelspacing',200)
                
                hold on
                [c1,h1]=contour(lat_aux_grid,moc_z_1,VV,-0.01:0.01:0.01);
                set(h1,'linecolor','k','linestyle','-','linewidth',1)
                set(h1,'showtext','off','labelspacing',900)                 
              end
              
                    
               
                
                
                % xlabel('latitude/°')
                % ylabel('depth/m')
                

                set(gca,'ytick',0:1/(length(tpdeplev)-1):1,'yticklabel',tpdepticklabel);
                
%                 box on
                % xlimit = get(gca,'xLim');
                % ylimit = get(gca,'yLim');
                % line([xlimit(1),xlimit(end)],[ylimit(1) ylimit(1)],'Color',[0 0 0])
                % line([xlimit(end),xlimit(end)],[ylimit(1) ylimit(end)],'Color',[0 0 0])
                set(gca,'layer','top')
%                 
                switch jj
                    case 1
                xlim([-80 90]);%ylim([-0.1 5500.1])
                xtk=-90:30:90;%ytk=0:250:5500;
                set(gca,'xtick',xtk,'xticklabel',{'90°S','60°S','30°S','Eq.','30°N','60°N','90°N'})%,'ytick',ytk)
                X=get(gca,'xtick')+10;
                    case 2
                xlim([-30 90]);%ylim([-0.1 5500.1])
                xtk=-30:30:90;%ytk=0:250:5500;
                set(gca,'xtick',xtk,'xticklabel',{'30°S','Eq.','30°N','60°N','90°N'})%,'ytick',ytk)
                X=get(gca,'xtick');
                end
%                 xlim([-30 90]);%ylim([-0.1 5500.1])
%                 xtk=-30:30:90;%ytk=0:250:5500;
%                 set(gca,'xtick',xtk,'xticklabel',{'30°S','Eq.','30°N','60°N','90°N'})%,'ytick',ytk)
%                 X=get(gca,'xtick');
%                    ylim([0 5500])    
%                    ytk=0:1000:5000;
%                    set(gca,'ytick',ytk,'yminortick','on')
                
                
                set(gca,'xminortick','on','tickdir','out')
                dxMINORXY(3,[])
                set(gca,'color',[0.65 0.65 0.65])
                
                title(' ')
                
                
                Y=get(gca,'ytick');
                xtxt=min(X)+0.02*(max(X)-min(X));
                ytxt=min(Y)-0.09*(max(Y)-min(Y));
                
                if jj==1
                text(xtxt,ytxt,casealias{ii},'interpreter','none','fontsize',10,'fontweight','bold',...
                    'backgroundcolor', [.99 .99 .99], 'edgecolor', 'k')
                end
                
                
                if ii<im && jj==1
                    set(gca,'xticklabels',[]);ylabel('Depth(m)')
                elseif ii==im && jj>1
                    set(gca,'yticklabels',[]);
                elseif ii==im && jj==1
                    ylabel('Depth(m)')
                else
                    set(gca,'xticklabels',[],'yticklabels',[]);
                end
                set(gca,'fontsize',8,'box','on')
        end
        
        
        %% colorbar
        if ii==im % && jj==jn
          
            cb=colorbar('horiz',...
                'position',[0.09+(jj-1)*0.465 0.025 0.40 0.022]);
            caxis([clevl(1) clevl(end)])
            set(get(cb,'title'),'string',vunit,'position',[415 0 0])
            if jj==1
                set(cb,'xtick',cmin:8:cmax,'ticklength',0)
            elseif jj==2
                set(cb,'xtick',cmin:6:cmax,'ticklength',0)
            end
%             cb=colorbar('horiz',...
%                 'position',[0.09+(jj-2)*0.465 0.025 0.865 0.022]);
%             caxis([clevl(1) clevl(end)])
%             set(get(cb,'title'),'string',vunit,'position',[395 0 0])
%             set(cb,'xtick',cmin:4:cmax,'ticklength',0)
            
        end %if jj==jn
        
    end %jj
end %ii
