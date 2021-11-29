
run header.m
%%
% SALT_pc={};
tpdeplev=[0 50 100 150 200 300 400 500 750 ...
    1000 1250 1500 2000 2500 3000 4000 5500];
im=3;jn=2;

% hi=0;
% bias=zeros(im,jn,2);

jvar=4;
var=variname{jvar};
for ni=1:length(casename)
    if ni==1
        titlestr{ni}=[casealias{ni},' - PHC2'];
    else
        titlestr{ni}=[casealias{ni},' - ',casealias{1}];
        
    end
end

pictype='profile' % profile;map

dep=[0 100 1500 4000 5500];

%%
for nsea=1:5
    disp(seaname{nsea})
    hi=0;
    
    figure('position',[100 60 225*jn*1.8 165*im*1.6])
    ha = tight_subplot(im,jn,[.035 .015],[.08 .03],[.05 .03]);
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
                case 'TEMP'
                    if jj==1
                        cmin=-3 ;cmax=3 ; dv=0.5;
                    else
                        %                     cmin=-4 ;cmax=4  ;dv=1;
                        cmin=-3 ;cmax=3 ; dv=0.5;
                    end
                    cmap=cmocean('balance',24);
                    cmap_len=size(cmap,1);
                    %                  cmap(cmap_len/2,:)=cmap(cmap_len/2+1,:);
                case 'SALT'
                    if jj==1
                        cmin=-1.0; cmax=1.0; dv=0.2;
                    else
                        %                     cmin=-1.2;  cmax=1.2;dv=0.4;
                        cmin=-1.0; cmax=1.0; dv=0.2;
                    end
                    cmap=cmocean('balance',20);
                    cmap_len=size(cmap,1);
                    %                 cmap(cmap_len/2,:)=cmap(cmap_len/2+1,:);
            end
            %% mask
            
            mask_t_3d=seamask_interpgrid(:,:,:,nsea);
            
            %% varible name
            switch hi
                case 1
                    timestr='_avg_296_300';
                    %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                    vn1str1=[casename{1},'_'];vn1str2=[var,timestr];
                    
                    switch jvar
                        case 4
                            vn2str1='ptmpphc';vn2str2='';
                        case 5
                            vn2str1='saltphc';vn2str2='';
                    end
                    
                case 2
                    timestr='_avg_296_300';
                    %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                    vn1str1=[casename{2},'_'];vn1str2=[var,timestr];
                    switch jvar
                        case 4
                            vn2str1='ptmpphc';vn2str2='';
                        case 5
                            vn2str1='saltphc';vn2str2='';
                    end
                    vn2str1=[casename{1},'_'];vn2str2=[var,timestr];
                    
                case 3
                    timestr='_avg_296_300';
                    %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                    vn1str1=[casename{3},'_'];vn1str2=[var,timestr];
                    switch jvar
                        case 4
                            vn2str1='ptmpphc';vn2str2='';
                        case 5
                            vn2str1='saltphc';vn2str2='';
                    end
                    vn2str1=[casename{1},'_'];vn2str2=[var,timestr];
                    
                case 4
                    timestr='_avg_296_300';
                    %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                    vn1str1=[casename{4},'_'];vn1str2=[var,timestr];
                    switch jvar
                        case 4
                            vn2str1='ptmpphc';vn2str2='';
                        case 5
                            vn2str1='saltphc';vn2str2='';
                    end
                    timestr='_avg_296_300';
                    
                    vn2str1=[casename{1},'_'];vn2str2=[var,timestr];
                    
                case 5
                    timestr='_avg_296_300';
                    %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                    vn1str1=[casename{5},'_'];vn1str2=[var,timestr];
                    switch jvar
                        case 4
                            vn2str1='ptmpphc';vn2str2='';
                        case 5
                            vn2str1='saltphc';vn2str2='';
                    end
                    timestr='_avg_296_300';
                    
                    vn2str1=[casename{1},'_'];vn2str2=[var,timestr];
                    
                case 6
                    timestr='_avg_296_300';
                    %                 vn1str1=[casename{jj},'_'];vn1str2=[variname{j},timestr];
                    vn1str1=[casename{6},'_'];vn1str2=[var,timestr];
                    switch jvar
                        case 4
                            vn2str1='ptmpphc';vn2str2='';
                        case 5
                            vn2str1='saltphc';vn2str2='';
                    end
                    timestr='_avg_296_300';
                    
                    vn2str1=[casename{1},'_'];vn2str2=[var,timestr];
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
            %% plot
            switch pictype
                case 'profile'
                    %         profile
                    run profile2_idv.m
                    
                    %% bias mean
                    
                    title(' ')
                    
                    X=get(gca,'xtick');
                    Y=get(gca,'ytick');
                    xtxt=min(X)+0.01*(max(X)-min(X));
                    ytxt=min(Y)-0.065*(max(Y)-min(Y));
                    
                    
                    %title
                    text(xtxt,ytxt,titlestr{hi},'interpreter','none','fontsize',10,'fontweight','bold')  %titlestr{4}
                    if hi==1
                        %sea
                        text(-85,0.95,seaname{nsea},'fontsize',10,'fontweight','bold')
                    end
                    
                    if ii<im && jj==1
                        set(gca,'xticklabels',[]);
                    elseif ii==im && jj>1
                        set(gca,'yticklabels',[]);
                    elseif ii==im && jj==1
                        
                    else
                        set(gca,'xticklabels',[],'yticklabels',[]);
                    end
                    set(gca,'fontsize',8,'box','on')
                    
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
                    
                    
                    
                case 'MOC'
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
                    'position',[0.1 0.025 0.8 0.02]);
                caxis([cmin cmax])
                %                 pause
                if picflag==2
                    set(cb,'xtick',cmin:dv:cmax)%,'xticklabel',sprintf('\n%1.1f',cmin:dv:cmax));
                else
                    set(cb,'xtick',clevl)
                end
                
                set(get(cb,'title'),'string',vunit,'position',[685 0 0])
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
end %nsea
