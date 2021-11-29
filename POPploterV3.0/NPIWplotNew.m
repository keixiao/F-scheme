% NPIW={sig_SALT_pop2,sig_SALT_v62,sig_SALT_woa2...
%     sig_TEMP_pop2,sig_TEMP_v62,sig_TEMP_woa2...
%     sig_h_pop2,sig_h_v62,sig_h_woa2};
% NPIW={pop_nt_salt_NPIW_avg_96_100,pop_tide_salt_NPIW_avg_196_200,fine_v7nt_salt_NPIW_avg_96_100,woa_salt_NPIW ...
%     ,pop_nt_temp_NPIW_avg_96_100,pop_tide_temp_NPIW_avg_196_200,fine_v7nt_temp_NPIW_avg_96_100,woa_temp_NPIW ...
%     ,pop_nt_depth_NPIW_avg_96_100,pop_tide_depth_NPIW_avg_196_200,fine_v7nt_depth_NPIW_avg_96_100,woa_depth_NPIW};
run header.m
%%

im=size(NPIW,1);jn=size(NPIW,2);
figure('position',[50 10 1200 618])
ha = tight_subplot(im,jn,[.02 .022],[.035 .03],[.04 .055]);
 legendias={casealias{1:4},'PHC'};
% ha = tight_subplot(im,jn,[0.02 0.01]);
%%
hi=0;
% for hi=1:1:12
for ii=1:im
    for jj=1:jn
        hi=hi+1
        axes(ha(hi))
        
        
        m_proj('miller','lon',[120 250],'lat',[15 65]) %North Pacific
        % m_proj('Miller Cylindrical','lon',[0 360],'lat',[-90 90]) %global
        
        pc = NPIW{ii,jj};
        Vq=pc;
        
        m_pcolor(interpLONG,interpLAT,Vq);
        
        if ii==1
%             X=get(gca,'xtick');
%             Y=get(gca,'ytick');
%             xtxt=min(X)+0.02*(max(X)-min(X));
%             ytxt=max(Y)+0.05*(max(Y)-min(Y));
            m_text(124,67,legendias{jj},'interpreter','none')
        end
        m_text(125,63,char(96+hi),'fontsize',12,'fontweight','bold')
        %                 pc = NPIW{hi};
        %                 Vq=griddata(TLONG,TLAT,pc,lonxx,latyy);
        %                 m_pcolor(lonxx,latyy,Vq);
        %                 m_text(124,63,'KPP+tide')
        shading interp
        axis square
        m_coast('patch',[0.65 0.65 0.65]);
%         m_coast('speckle')
        
%         colormap(rgb200)
        cb=colorbar(ha(hi));
        if floor((hi-1)/jn)==0
            cmin=33.5;cmax=34.5;
%             cmin=33.4;cmax=35.4;
            cbname='psu';
%             set(cb,'xtick',cmin:0.1:cmax);
            set(cb,'xtick',cmin:0.2:cmax);
            cmap=cmocean('haline',20);
        elseif floor((hi-1)/jn)==1
            cmin=-2;cmax=8;
%             cmin=-2;cmax=28;
            cbname='°C';
%             set(cb,'xtick',cmin:1.2:cmax);
            set(cb,'xtick',cmin:2:cmax);
            cmap=cmocean('thermal',20);
        elseif floor((hi-1)/jn)==2
            cmin=0;cmax=800;
            cbname='depth/m';
            set(cb,'xtick',cmin:80:cmax);
            cmap=cmocean('deep',20);
        end
        % set(get(cb,'title'),'string','°C')
        set(get(cb,'title'),'string',cbname)
        caxis([cmin cmax])
        colormap(ha(hi),cmap)
        colorbar off
        
        %% colorbar
        if jj==jn
            
            cb=colorbar('position',[0.965 0.042+(3-ii)*0.965/3 0.011 0.26]);
            colormap(cb,cmap)
            
        if floor((hi-1)/jn)==0
%             cmin=33.7;cmax=35.0;
%             cmin=33.4;cmax=35.4;
            cbname='psu';
%             set(cb,'xtick',cmin:0.1:cmax);
            set(cb,'xtick',cmin:0.2:cmax);
            
        elseif floor((hi-1)/jn)==1
%             cmin=-1.2;cmax=14.4;
%             cmin=-2;cmax=28;
            cbname='°C';
%             set(cb,'xtick',cmin:1.2:cmax);
            set(cb,'xtick',cmin:2:cmax);
%             colormap(rgb200)
        elseif floor((hi-1)/jn)==2
%             cmin=0;cmax=800;
            cbname='depth/m';
            set(cb,'xtick',cmin:80:cmax);
%             colormap(rgb200)
        end
%             if ii==1
%                 cmin=33.7;cmax=35.0;
% %                 cmin=33  ;cmax=36.6;
%                 cbname='psu';
%                 set(cb,'xtick',cmin:0.2:cmax);
%             elseif ii==2
%                 cmin=-1.2;cmax=14.4;
%                 cbname='°C';
%                 set(cb,'xtick',cmin:1.2:cmax);
%             elseif ii==3
%                 cmin=0;cmax=800;
%                 cbname='m';
%                 set(cb,'xtick',cmin:80:cmax);
%             end
            set(get(cb,'title'),'string',cbname)
            caxis([cmin cmax])
        end
        
        
        
        
        %% xytick
        if ii<im && (jj==1)
            m_grid('box','on','xtick',140:40:250,'xticklabels',[],'linestyle','none','tickdir','out');
        elseif ii==im && jj>1
            m_grid('box','on','xtick',140:40:250,'yticklabels',[],'linestyle','none','tickdir','out');
        elseif ii==im && (jj==1)
            m_grid('box','on','xtick',140:40:250,'linestyle','none','tickdir','out');
        else
            m_grid('box','on','xtick',140:40:250,'xticklabels',[],'yticklabels',[],'linestyle','none','tickdir','out');
        end
    end

end

%%
%         nnc=0;
%            for ii=1:im
%                for jj=1:jn
%                    nnc=nnc+1;
%                axes(ha(nnc));
%                set(gca,'fontsize',10)
% %                plot(randn(10,ii));
%                if ii~=im
%                    set(ha(nnc),'XTickLabel','')
%                end
%                if jj~=1
%                    set(ha(nnc),'YtickLabel','')
%                end
%                end
%            end