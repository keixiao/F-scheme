
run header.m
%%
% SALT_pc={};
tpdeplev=[0 50 100 150 200 300 400 500 750 ...
    1000 1250 1500 2000 2500 3000 4000 5500];
im=1;jn=1;

% hi=0;
% bias=zeros(im,jn,2);

jvar=3;
% nflag=3;
var=variname{jvar};
for ni=1:length(casename)
    if ni==1
%         titlestr{ni}=[c];
    else
        titlestr{ni}=[casealias{ni},' - ',casealias{1}];
    end
end
% seaname={'Atlantic','Pacific','Indian','Arctic','Global'};
pictype='profile' % profile;map

dep=[0 100 1500 4000 5500];

%%
% for nsea=1:5
%     disp(seaname{nsea})
hi=0;

figure('position',[100 60 225*jn*1.8 165*im*2])
ha = tight_subplot(im,jn,[.035 .025],[.095 .05],[.05 .03]);
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
        switch var
            case 'VDCS'
                cmin=0.1;cmax=0.49;
                cmap=cmocean('matter',20);
                cmap_len=size(cmap,1);
            case 'TEMP'
                if jj==1
                    cmin=-4 ;cmax=28 ; dv=1;
                else
                    %                     cmin=-4 ;cmax=4  ;dv=1;
                    cmin=-4 ;cmax=28 ; dv=1;
                end
                cmap=cmocean('thermal',32);
                cmap_len=size(cmap,1);
                %                  cmap(cmap_len/2,:)=cmap(cmap_len/2+1,:);
            case 'SALT'
                if jj==1
                    cmin=32; cmax=37; dv=0.2;
                else
                    %                     cmin=-1.2;  cmax=1.2;dv=0.4;
                    cmin=32; cmax=37; dv=0.2;
                end
                cmap=cmocean('haline',25);
                cmap_len=size(cmap,1);
                %                 cmap(cmap_len/2,:)=cmap(cmap_len/2+1,:);
        end
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
                tmask(interpLAT<-33.5)=nan;
                mask_t_3d(:,:,n)=tmask;
            end
        end
        mask_t_3d=seamask_interpgrid(:,:,:,nsea);
        
        %% varible name
        switch hi
            case 1
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
%                 vn1str1=[casename{4},'_'];vn1str2=[var,timestr];
                
                switch jvar
                    case 4
                        vn1str1='ptmpphc';vn1str2='';
                    case 5
                        vn1str1='saltphc';vn1str2='';
                end
                
            case 2
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
%                 vn1str1=[casename{4},'_'];vn1str2=[var,timestr];
                switch jvar
                    case 4
                        vn1str1='ptmpphc';vn1str2='';
                    case 5
                        vn1str1='saltphc';vn1str2='';
                end
                %                 vn2str1=[casename{1},'_'];vn2str2=[var,timestr];
                
            case 3
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
%                 vn1str1=[casename{4},'_'];vn1str2=[var,timestr];
                switch jvar
                    case 4
                        vn1str1='ptmpphc';vn1str2='';
                    case 5
                        vn1str1='saltphc';vn1str2='';
                end
                %                 vn2str1=[casename{1},'_'];vn2str2=[var,timestr];
                
            case 4
                timestr='_avg_296_300';
                %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
%                 vn1str1=[casename{4},'_'];vn1str2=[var,timestr];
                switch jvar
                    case 4
                        vn1str1='ptmpphc';vn1str2='';
                    case 5
                        vn1str1='saltphc';vn1str2='';
                end
                timestr='_avg_296_300';
                
                %                 vn2str1=[casename{1},'_'];vn2str2=[var,timestr];
                
        end
        
        vn1=[vn1str1,vn1str2,'_interp'];
        vn2='blank';
        vn1='VDC_KF_T*10000';
        vn2='blank';
        
        %% plot
        switch pictype
            case 'profile'
                %         profile
                run profile2_idv.m
                
%                 astd_minus_phc{hi,jvar-3,nflag}=VV;
                
                title(' ')
                
                X=get(gca,'xtick');
                Y=get(gca,'ytick');
                xtxt=max(X)-0.042*(max(X)-min(X));
                ytxt=min(Y)-0.065*(max(Y)-min(Y));
                
                
                %title
                
                if hi==1
                    text(xtxt,ytxt,titlestr{hi},'interpreter','none','fontsize',10,'fontweight','bold',...
                       'backgroundcolor', [.99 .99 .99], 'edgecolor', 'k')  %titlestr{4}
                end
                %sea
                text(-85,0.95,seaname{nsea},'fontsize',10,'fontweight','bold')
                
                if ii<im && jj==1
                    set(gca,'xticklabels',[]);
                elseif ii==im && jj>1
                    set(gca,'yticklabels',[]);
                elseif ii==im && jj==1
                    
                else
                    set(gca,'xticklabels',[],'yticklabels',[]);
                end
                set(gca,'fontsize',8,'box','on')
                
                dxMINORXY(3,[])
                
                text(-86,1/16,char(96+hi),'fontsize',11,'fontweight','bold')
                %                 % line depth & lat------------------------
                %                 [ldep,~]=unequalcmap([200 500 1500],tpdeplev);
                %                 for iline=1:3
                %                     line([-90 90],[ldep(iline),ldep(iline)],'linestyle','--','color',[0.75 0.75 0.75])
                %                 end
                %                 for iline=1:6
                %                 line([-75 -75]+(iline-1)*30,[0 1],'linestyle','--','color',[0.75 0.75 0.75])
                %                 end
                %                 % ------------------------------------line
                
        end
        
        pause(0.1)
        %% colorbar
        %         if jj==1  && ii==im
        %             if jvar==4||jvar==5
        %                 cb=colorbar('horiz',...
        %                     'position',[0.03 0.025 0.225 0.02]);
        %                 caxis([cmin cmax])
        % %                 pause
        %                 if picflag==2
        %                     set(cb,'xtick',cmin:dv:cmax)%,'xticklabel',sprintf('\n%1.1f',cmin:dv:cmax));
        %                 else
        %                     set(cb,'xtick',clevl)
        %                 end
        %                 set(cb,'ticklength',0)
        %             end
        
        %         end
        if jj==jn && ii==im
            
            cb=colorbar('horiz',...
                'position',[0.1 0.0275 0.8 0.02]);
            caxis([cmin cmax])
            %                 pause
            if picflag==2
                set(cb,'xtick',cmin:dv:cmax)%,'xticklabel',sprintf('\n%1.1f',cmin:dv:cmax));
            else
                set(cb,'xtick',clevl)
            end
            
            set(get(cb,'title'),'string',vunit,'position',[500 0 0])
            set(cb,'ticklength',0)
            
            
        end %if jj==jn
        %     pause
    end %jj
end %ii
set(ha,'tickdir','out')
switch pictype
    case 'map'
        for i=1:4
            axes(ha(i))
            title(titlestr{i})
        end
end
% end %nsea
