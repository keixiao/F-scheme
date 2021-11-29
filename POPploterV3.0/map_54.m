
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
im=4;jn=4;
figure('position',[100 60 225*jn*1.125 165*im*1.125])
ha = tight_subplot(im,jn,[.015 .015],[.08 .03],[.03 .015]);
% ha = tight_subplot(im,jn,[.015 .014],[.025 .01],[.026 .01]);
% ha = tight_subplot(im,jn,[0.02 0.01]);
hi=0;

for ni=2:length(casealias)
    titlestr{ni}=[casealias{ni},' - ',casealias{1}];
end
titlestr{5}=[casealias{4},' - ',casealias{3}];

pictype='map' % profile;map
jvar=5 ;

%depth integral limit
deploc=[0 10 44 54 59];
depstr={'0~100m','100~1500m','1500~4000m','4000~bottom'};
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
                    cmin=-2 ;cmax=2 ; dv=0.5;
                else
                    %                     cmin=-4 ;cmax=4  ;dv=1;
                    cmin=-2 ;cmax=2 ; dv=0.5;
                end
                cmap=cmocean('balance',20);
                %                 cmap(cmap_len/2,:)=cmap(cmap_len/2+1,:);
            case 'SALT'
                if jj==1
                    cmin=-0.5; cmax=0.5; dv=0.1;
                else
                    %                     cmin=-1.2;  cmax=1.2;dv=0.4;
                    cmin=-0.5; cmax=0.5; dv=0.1;
                end
                cmap=cmocean('balance',20);
                %                 cmap(cmap_len/2,:)=cmap(cmap_len/2+1,:);
        end
        %% mask
        if ii==1
            nsea=5;
            %             nsea=1;
        elseif ii==2
            nsea=1;
        elseif ii==3
            nsea=2;
        elseif ii==4
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
                tmask(interpLAT<-33.5)=nan;
                mask_t_3d(:,:,n)=tmask;
            end
        end
        %% varible name
        switch ii
            case 1
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                vn1str1=[casename{2},'_'];vn1str2=[variname{jvar},timestr];
                
                switch jvar
                    case 4
                        vn2str1='tempphc';vn2str2='';
                    case 5
                        vn2str1='saltphc';vn2str2='';
                end
                vn2str1=[casename{1},'_'];vn2str2=[variname{jvar},timestr];
            case 2
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                vn1str1=[casename{3},'_'];vn1str2=[variname{jvar},timestr];
                switch jvar
                    case 4
                        vn2str1='tempphc';vn2str2='';
                    case 5
                        vn2str1='saltphc';vn2str2='';
                end
                vn2str1=[casename{1},'_'];vn2str2=[variname{jvar},timestr];
            case 3
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                vn1str1=[casename{4},'_'];vn1str2=[variname{jvar},timestr];
                switch jvar
                    case 4
                        vn2str1='tempphc';vn2str2='';
                    case 5
                        vn2str1='saltphc';vn2str2='';
                end
                vn2str1=[casename{1},'_'];vn2str2=[variname{jvar},timestr];
            case 4
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                vn1str1=[casename{4},'_'];vn1str2=[variname{jvar},timestr];
                switch jvar
                    case 4
                        vn2str1='tempphc';vn2str2='';
                    case 5
                        vn2str1='saltphc';vn2str2='';
                end
                timestr='_avg_296_300';
                vn2str1=[casename{3},'_'];vn2str2=[variname{jvar},timestr];
            case 5
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                vn1str1=[casename{6},'_'];vn1str2=[variname{jvar},timestr];
                switch jvar
                    case 4
                        vn2str1='tempphc';vn2str2='';
                    case 5
                        vn2str1='saltphc';vn2str2='';
                end
                vn2str1=[casename{1},'_'];vn2str2=[variname{jvar},timestr];
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
                % clevl=((1:cmap_len+1)-1)*eval(vpa((cmax-cmin)/cmap_len,2))+eval(vpa(cmin,2));
                % clevl=cmin:(cmax-cmin)/(cmap_len):cmax;
                % clevl=clevl';
                clevl=cmin:dv:cmax;
                eval(['VV=',vn1,'(:,:,deploc(jj)+1:deploc(jj+1))-',vn2,'(:,:,deploc(jj)+1:deploc(jj+1));'])
                %eval(['Vq=',vn1,'(:,:,deploc(ii))-',vn2,'(:,:,deploc(ii));'])
                VV=VV.*dz_3d(:,:,deploc(jj)+1:deploc(jj+1));
                for iin=1:360
                    for jjn=1:341
                        tV=VV(iin,jjn,:);
                        Vq(iin,jjn)=nansum(tV)/sum(squeeze(~isnan(tV)).*dz(deploc(jj)+1:deploc(jj+1)));
                        %                        Vq=nansum(VV,3)/(z_t(deploc(ii+1))-z_t(deploc(ii)+1));
                    end
                end
              %pcolor
                
              xx=cmta(interpLONG,30,360);
              zz=cmta(Vq,30,0);
              m_pcolor(xx,interpLAT,zz);
              shading flat

                hold on
                m_plot(0:15:390,(0:15:390)*0+10,'--','color',[0.2 0.2 0.2])
                m_plot(0:15:390,(0:15:390)*0-10,'--','color',[0.2 0.2 0.2])
                
                %colorbar & colormap settings
                colorbar(ha(hi));colorbar off;
                colormap(cmap)
                caxis([clevl(1) clevl(end)])
                
                %bias shading
                if ii==4
                    zq=Std_minus_phc{jj,jvar-3,2};
                else
                    zq=Std_minus_phc{jj,jvar-3,1};
                end
                p_tmp=((zq.*zz)<0).*((abs(zz)./abs(zq))>0.05).*((abs(zz)./abs(zq))<1.1);
                p_tmp(p_tmp==0)=nan;
                
                % shading good region
                hold on
                s=m_scatter(reshape(xx(1:4:end,1:4:end),[],1),reshape(interpLAT(1:4:end,1:4:end),[],1),...
                    0.1,reshape(p_tmp(1:4:end,1:4:end),[],1)*[0.0 1 0.0]);
                %                     colormap(s,[0 0 0])
                %                     alpha color
                alpha(s,.8)


                set(gca,'fontsize',8)
                m_coast('patch',[0.7 0.7 0.7],'edgecolor',[0.7 0.7 0.7]);
                

                hold on
                
                %                 %% bias mean
                %                 switch jvar
                %                     case 4
                %                         posi_Vq=Vq(Vq>=0.5);
                %                         nega_Vq=Vq(Vq<=-0.5);
                %                     case 5
                %                         posi_Vq=Vq(Vq>=0.1);
                %                         nega_Vq=Vq(Vq<=-0.1);
                %                 end
                %                 bias(ii,jj,1)=mean(posi_Vq);
                %                 bias(ii,jj,2)=mean(nega_Vq);
                %%
                if mod(hi,4)==1

                        m_text(465,-85,titlestr{ii+1},'backgroundcolor', [.99 .99 .99], 'edgecolor', 'k')
                end
                m_text(52,50,char(96+hi),'fontsize',8,'fontweight','bold','backgroundcolor', [.99 .99 .99], 'edgecolor', 'k','margin',1.5)
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
                if ii==1
                    m_text(38,-75.2,depstr{jj},'fontsize',7,'fontweight','bold')
                end
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
                    'position',[0.1 0.025 0.8 0.02]);
                caxis([cmin cmax])
                %                 pause
                if picflag==2
                    set(cb,'xtick',cmin:dv:cmax)%,'xticklabel',sprintf('\n%1.1f',cmin:dv:cmax));
                else
                    set(cb,'xtick',clevl)
                end
                
                set(get(cb,'title'),'string',vunit,'position',[625 0 0])
                set(cb,'ticklength',0)
            end
            
        end %if jj==jn
        %     pause
    end %jj
end %ii
set(ha,'tickdir','out')
% figure(2)
switch pictype
    case 'map'
        for i=1:4
            axes(ha(i))
            title('')
        end
end