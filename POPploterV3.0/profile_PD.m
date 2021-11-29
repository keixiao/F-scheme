
 run header.m
% abbreviation.m
% casename_MOC={'K_T','KF_T','K_nT','KF_nT'};
% casealias_MOC={'K_T','KF_T','K','KF'};
%  variname={'VVC','VDCT','VDCS','TEMP','SALT','RHO','PD','HBLT','SSH','KVMIX'};
% legendias={'K','KT','KF','KFT',sprintf('\n'),'KFadd','KFTadd','PHC'};
lstyle={'--','-','--','-','-'};
lcolor={'k','k',[0.850,  0.325,  0.098],[0.850,  0.325,  0.098],'b'};
lwidth=[0.5 0.5 0.5 0.5 0.5 0.5 0.5];
% casename={'K_nT','K_T','KFnew_0','KFTnew_0','KFadd','KFTadd'};
% casealias={'K','KT','KF','KFT','KFadd','KFTadd'};
%%


%---------%
im=2;jn=2;

figure('position',[100 60 500*jn 400*im])
% ha = tight_subplot(im,jn,[.04 .03],[.04 .03],[.05 .02]);
ha = tight_subplot(im,jn,[.03 .03],[.07 .03],[.070 .02]);
% ha = tight_subplot(im,jn,[.015 .014],[.025 .01],[.026 .01]);
% ha = tight_subplot(im,jn,[0.02 0.01]);
hi=0;
% titlestr={'K_T - PHC','KF_T - K_T','K - K_T','KF - K_T'};
pictype='profile';jvar=3;%timestr=
 caseloc=[1 2 3 4 5 6];
%%
for ii=1:im
    for jj=1:jn
        
        hi=hi+1
        %         nk=floor((hi-1)/4)+1;
        
        axes(ha(hi))
        
        %% mask
        if hi==1
            nsea=5;
            %             nsea=1;
        elseif hi==2
            nsea=1;
        elseif hi==3
            nsea=2;     
        elseif hi==4
%             tmask1=seamask_interpgrid(:,:,:,3);
%             tmask1(isnan(tmask1))=0;
%             tmask2=seamask_interpgrid(:,:,:,4);
%             tmask2(isnan(tmask2))=0;
%             tmask=tmask1+tmask2;
%             tmask(tmask==0)=nan;
%             mask_t_3d=tmask;
            nsea=3;  
        end
        mask_t_3d=seamask_interpgrid(:,:,:,nsea);
        if nsea~=5
            for n=1:60
                tmask=mask_t_3d(:,:,n);
                tmask(interpLAT<-4)=nan;
                mask_t_3d(:,:,n)=tmask;
            end
        end
        %% plot
        switch pictype
                
            case 'profile'
                %         profile
                [zbt_interpLAT_mesh_1,tpdepticklabel]=unequalcmap(zbt_interpLAT_mesh,tpdeplev);
                
                vname='PD';
                switch vname
                    case 'PD'
                                clevel=26.4:0.4:27.6;
%                         clevel=26.95:0.1:27.35;
                end
                
                shape=squeeze(nanmean(mask_t_3d,1));
                pcolor(interpLAT_mesh,zbt_interpLAT_mesh_1,shape);shading flat;colormap([1 1 1])
                
                hold on
                for nk=[1 2 3 4 5]
                    if nk~=5
                        vn=[casename{caseloc(nk)},'_',vname,timestr];
                    else
                        vn=[lower(vname),'phc'];%_interp
                        switch vname
                            case 'TEMP'
                                vn='ptmpphc';
                        end
                    end
                    eval(['pc=',vn,'_interp.*mask_t_3d;'])
                    %     pc2=pop_nt_PD_avg_196_200.*mask_t_3d;
                    %     pc2=zonnalmean(pc2,interpLONG,interpLAT,interpLONG,interpLAT);
                    
                    pc(28:43,242:252,:)=nan;
                    pc(16:24,268:292,:)=nan;
                    pc=squeeze(nanmean(pc,1));
                    
                    switch vname
                        case 'PD'
                            VV=pc*1000-1000;
                            if nk==5
                                VV=pc-1000;
                            end
                    end
                    
                    hold on
                    [c,h]=contour(interpLAT_mesh,zbt_interpLAT_mesh_1,VV,clevel);
                    clabel(c,h)
                    set(h,'linecolor',lcolor{nk},'linestyle',lstyle{nk},'linewidth',lwidth(nk))
                    set(h,'ShowText','off','TextList',clevel)
                    if nk==7
                        set(h,'ShowText','on','TextList',clevel,'LabelSpacing',550)
                    end
                    
                    set(gca,'ydir','reverse')
                    set(gca,'color',[1 1 1]*0.7)
                    set(gca,'tickdir','out')
                end
                
                title(' ')
                
                X=get(gca,'xtick');
                Y=get(gca,'ytick');
                xtxt=-88;%min(X)+0.02*(max(X)-min(X));
                ytxt=-0.035;%min(Y)-0.08*(max(Y)-min(Y));
                
                switch hi
                    case 1
                        text(xtxt,ytxt,'Global','fontsize',8,'fontweight','bold') %titlestr{1}
                        h = zeros(5, 1);
                        for ih=[ 1 2 3 4 5]
                            h(ih) = plot(0,0,'visible','on','color',lcolor{ih},'linestyle',lstyle{ih},'linewidth',lwidth(ih));
                        end
                        
%                         a1=gca;
%                         hold off
%                         axes(a1)
                        
                    case 2
                        text(xtxt,ytxt,'Atlantic','fontsize',8,'fontweight','bold')%titlestr{2}
                    case 3
                        text(xtxt,ytxt,'Pacific','fontsize',8,'fontweight','bold')   %titlestr{3}
                    case 4
                        text(xtxt,ytxt,'Indian','fontsize',8,'fontweight','bold')  %titlestr{4}
                end
                text(-85,1/16-1/64,char(96+hi),'fontsize',12,'fontweight','bold')
                run picsetting.m
                
                if ii<im && jj==1
                    set(gca,'xticklabels',[]); ylabel('Depth(m)')
                elseif ii==im && jj>1
                    set(gca,'yticklabels',[]);
                elseif ii==im && jj==1
                    ylabel('Depth(m)')
                else
                    set(gca,'xticklabels',[],'yticklabels',[]);
                end
                set(gca,'fontsize',10)
                                         
                                     

        end
%         if jj==jn && ii==im
%                 cb=colorbar('horiz',...
%                     'position',[0.2 0.035 0.6 0.02]);
%                 caxis([clevl(1) clevl(end)])
%                 set(get(cb,'title'),'string',vunit,'position',[500 0 0])
%                 if jvar==4
%                     set(cb,'xtick',cmin:2:cmax,'xticklabel',sprintf('%2d\n',cmin:2:cmax))
%                 elseif jvar==5
%                     set(cb,'xtick',cmin:0.2:cmax,'xticklabel',sprintf('%2.1f\n',cmin:0.2:cmax))
%                 elseif jvar==3
%                     caxis([0 1]);
%                     set(cb,'xtick',0:1/(length(cmaplev)-1):1,'xticklabel',sprintf('%1.2f\n',cmaplev));
%                     set(get(cb,'title'),'string',vunit)
%                 end
%         end
        %% colorbar
        if jj==jn && ii==im
            
            
            %                 cb=colorbar('position',...
            %                     [0.95 (0.19*0.945/im)/2+0.025+(im-ii)*0.945/im 0.012 0.81*0.945/im]);
            %'location','southoutside',...
            %                 cb=colorbar('horiz',...
            %                     'position',[0.2 0.03 0.6 0.025]);
            %                 caxis([clevl(1) clevl(end)])
            %                 set(get(cb,'title'),'string',vunit,'position',[425 0 0])
            %                 set(cb,'xtick',cmin:2:cmax)
            
            
        end %if jj==jn
        if hi==1
                        h00=legend(h([1 2 3 4 5]),'K','KF','K-p','KF-p','PHC',...
                             'box','off','Orientation','horizon','location','south','interpreter','none');
%                         h00=legend(h(2:4),'K','KT','KF','KFT',...
%                             'box','off','Orientation','horizon','location','south','interpreter','none');
%                         set(h00,'position',[0.156000000953674,0.573333333333333,0.267999998092651,0.024999999403954])
%                         hold on
%                         ah=axes('position',get(gca,'position'),'visible','off');
%                         legend(ah,h(5:7),'KFadd','KFTadd','PHC','box','off','Orientation','horizon','location','south','interpreter','none'); 
        end
    end %jj
end %ii
