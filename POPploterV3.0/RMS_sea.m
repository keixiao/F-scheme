% load seaname.mat
% load TSP.mat
run header.m
% casename={'K','KF','K_p','KF_p','KFnT','KFnTnb'};
% disp("casename={'K','KF','K_p','KF_p'}")
% casealias={'K','KF','K-p','KF-p','KF-nT','KF-nT-p'};
% disp("casealias={'K','KF','K-p','KF-p'}")
%  variname={'VVC','VDCT','VDCS','TEMP','SALT','RHO','PD','HBLT','SSH','KVMIX'};
tpdeplev=[0 50 100 150 200 300 400 500 750 ...
    1000 1250 1500 2000 2500 3000 4000 5500];
%%
% SALT_pc={};

im=2;jn=2;
% depthloc=[0 10 44 54 59];
% depstr={'0~100m','100~1500m','1500~4000m','4000~bottom'};

spcolor=  [0 0 0
    0.000,  0.447,  0.741
    0.850,  0.325,  0.098
    0.929,  0.694,  0.125
    0.494,  0.184,  0.556
    0.466,  0.674,  0.188
    0.301,  0.745,  0.933
    0.635,  0.078,  0.184];
nnnflag=1
RMSs=zeros(60,5,4);
for nn=2:2

    %     hi=0
    figure('position',[100 60 255*jn*1.4 255*im*1.4])
    ha = tight_subplot(im,jn,[.1 .1],[.075 .06],[.09 .015]);
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
            mask_t_3d(mask_t_3d==0)=nan;
            
            %%
            %PHC
            
            if nnnflag==1
                
                for k=1:60
                    T0=ptmpphc_interp.*mask_t_3d;
                    S0=saltphc_interp.*mask_t_3d;
                    
                    
                    T0=T0(:,:,k);
                    S0=S0(:,:,k);
                    
                    T0_1d=reshape(T0,[],1);fT0=isnan(T0_1d);T0_1d(isnan(T0_1d))=[];
                    S0_1d=reshape(S0,[],1);fS0=isnan(S0_1d);S0_1d(isnan(S0_1d))=[];
                    
                    
                    SS=S0_1d';
                    TT=T0_1d';
                    
                    
                    %Cases
                    timestr='_avg_296_300';
                    for in=1:4%size(casename,2)
                        eval(['T1=',casename{in},'_TEMP',timestr,'_interp.*mask_t_3d;'])
                        eval(['S1=',casename{in},'_SALT',timestr,'_interp.*mask_t_3d;'])
                        T1=T1(:,:,k);
                        S1=S1(:,:,k);
                        T1_1d=reshape(T1,[],1);T1_1d(fT0)=[];
                        S1_1d=reshape(S1,[],1);S1_1d(fS0)=[];
                        %                 T1_1d=(T1_1d-min(T1_1d))/(max(T1_1d)-min(T1_1d));
                        %                 S1_1d=(S1_1d-min(S1_1d))/(max(S1_1d)-min(S1_1d));
                        %                 T1_1d=(T1_1d-Tmin)/(Tmax-Tmin);
                        %                 S1_1d=(S1_1d-Smin)/(Smax-Smin);
                        SS=[SS;S1_1d'];
                        TT=[TT;T1_1d'];
                    end
                    
                    
                    for iii = 2:size(TT,1)
                        c1=TT(1,:);
                        c2=TT(iii,:);
                        nflag=isnan(c2);
                        c1(nflag)=[];
                        c2(nflag)=[];
                        C = allstats(c1,c2);
                        statm(iii,:) = C(:,2);
                    end
                    
                    statm(1,:) = C(:,1);
                    %             refstd=statm(1,2);
                    %             statm(1:end,2:3)=statm(1:end,2:3)/refstd;
                    %             disp(num2str(statm,'% 1.3f'))
                    %              STDs=squeeze(statm(:,2));
                    %              RMSs=squeeze(statm(:,3));
                    %              CORs=squeeze(statm(:,4));
                    RMSs(k,:,hi)=squeeze(statm(1:5,3));
                    %             nSTD=0.2;mSTD=1;lSTD=1.5;
                    %             nRMS=0.25;mRMS=1;lRMS=1;
                end
            end
            disp(k)
            [z_t_1,tpdepticklabel]=unequalcmap(z_t,tpdeplev);
            for k=2:5
                hold on
                plot(RMSs(:,k,hi),z_t_1,'-','color',spcolor(k,:));
            end
            
            ylim([0 1])
            for i=2:length(tpdeplev)-1
                if 2*tpdeplev(i)==tpdeplev(i-1)+tpdeplev(i+1)
                    tpdepticklabel{i}='';
                end
            end
            set(gca,'ytick',0:1/(length(tpdeplev)-1):1,'yticklabel',tpdepticklabel);
            
            if hi==2
                hil=legend(casealias{1:4},'edgecolor','k');
                set(hil,'orientation','horizontal','position',[0.27 0.48 0.48 0.028])
            end
            
            set(gca,'ydir','reverse','box','on','tickdir','out')
            %             xlabel('RMS')
            ylabel('depth/m')
%             ylim([0 5500])
            
            X=get(gca,'xlim');
            Y=get(gca,'ylim');
            
            xtxt=X(2)-0.25*(X(2)-X(1));
            ytxt=Y(2)-0.08*(Y(2)-Y(1));
            text(xtxt,ytxt,seaname_TS{hi},'edgecolor','k','backgroundcolor','w','fontsize',11)
            
            xtxt=X(1)+0.05*(X(2)-X(1));
            text(xtxt,1/16,char(96+hi),'fontsize',10,'fontweight','bold',...
                'backgroundcolor', [.99 .99 .99], 'edgecolor', 'k','margin',1.5)
            
%             xtxt=X(2)-0.165*(X(2)-X(1));
%             ytxt=Y(2)+0.01*(Y(2)-Y(1));
            xtxt=X(1)+0.15*(X(2)-X(1));
            if hi==1
                ti=text(xtxt,1/16,' RMS \theta ','edgecolor','k','backgroundcolor','w');
%                 set(ti,'position',[2.1 0 0])
                %                 get(ti,'position')
            end
            %%
            
            pause(0.5)
            
            %% colorbar
            
        end %jj
    end %ii
    % set(ha,'tickdir','out')
end
