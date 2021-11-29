% load seaname.mat
% load TSP.mat
run header.m
% casename={'K','KF','K_p','KF_p','KFnT','KFnTnb'};
% disp("casename={'K','KF','K_p','KF_p'}")
% casealias={'K','KF','K-p','KF-p','KF-nT','KF-nT-p'};
% disp("casealias={'K','KF','K-p','KF-p'}")
%  variname={'VVC','VDCT','VDCS','TEMP','SALT','RHO','PD','HBLT','SSH','KVMIX'};
%%
% SALT_pc={};

im=2;jn=2;
% depthloc=[0 10 44 54 59];
% depstr={'0~100m','100~1500m','1500~4000m','4000~bottom'};
depthloc=[0 10 40 44 54 59];
depstr={'0~100m','100~1000m','1000~1500m','1500~4000m','4000~bottom'};
% figure(1)
% figure(2)
% spcolor={'k','b','r','g','y'};
spcolor=  [0 0 0
    0.000,  0.447,  0.741
  0.850,  0.325,  0.098
  0.929,  0.694,  0.125
  0.494,  0.184,  0.556
  0.466,  0.674,  0.188
  0.301,  0.745,  0.933
  0.635,  0.078,  0.184];
for nn=2:2
    deploc=[depthloc(nn)+1 depthloc(nn+1)]
%     hi=0
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
            mask_t_3d(mask_t_3d==0)=nan;
%             if hi~=4
%                 for n=1:60
%                     tmask=mask_t_3d(:,:,n);
%                     %                         tmask(interpLAT<-33.5)=nan;
%                     %                         tmask(abs(interpLAT)>15)=nan;
%                     tmask(abs(interpLAT)>60)=nan;
%                     %                         tmask(abs(interpLAT)>10)=nan;
%                     mask_t_3d(:,:,n)=tmask;
%                 end
%             end
            %%
            %PHC
            T0=ptmpphc_interp.*mask_t_3d;
            S0=saltphc_interp.*mask_t_3d;
            T0=T0(:,:,deploc(1):deploc(2));
            S0=S0(:,:,deploc(1):deploc(2));
            
            T0_1d=reshape(T0,[],1);fT0=isnan(T0_1d);T0_1d(isnan(T0_1d))=[];
            S0_1d=reshape(S0,[],1);fS0=isnan(S0_1d);S0_1d(isnan(S0_1d))=[];
            
            %normalize
%             T0_1d=(T0_1d-min(T0_1d))/(max(T0_1d)-min(T0_1d));
%             S0_1d=(S0_1d-min(S0_1d))/(max(S0_1d)-min(S0_1d));
%             
%             Tmin=-2.5;Tmax=10;
%             Smin=33  ;Smax=35;
%             T0_1d=(T0_1d-Tmin)/(Tmax-Tmin);
%             S0_1d=(S0_1d-Smin)/(Smax-Smin);
            
            
            SS=S0_1d';
            TT=T0_1d';
            
            
            %Cases
            timestr='_avg_296_300';
            for in=1:4%size(casename,2)
                eval(['T1=',casename{in},'_TEMP',timestr,'_interp.*mask_t_3d;'])
                eval(['S1=',casename{in},'_SALT',timestr,'_interp.*mask_t_3d;'])
                T1=T1(:,:,deploc(1):deploc(2));
                S1=S1(:,:,deploc(1):deploc(2));
                T1_1d=reshape(T1,[],1);T1_1d(fT0)=[];
                S1_1d=reshape(S1,[],1);S1_1d(fS0)=[];
%                 T1_1d=(T1_1d-min(T1_1d))/(max(T1_1d)-min(T1_1d));
%                 S1_1d=(S1_1d-min(S1_1d))/(max(S1_1d)-min(S1_1d));
%                 T1_1d=(T1_1d-Tmin)/(Tmax-Tmin);
%                 S1_1d=(S1_1d-Smin)/(Smax-Smin);
                SS=[SS;S1_1d'];
                TT=[TT;T1_1d'];
            end
            % K-p
            %             T1=K_p_TEMP_avg_296_300_interp.*mask_t_3d;
            %             S1=K_p_SALT_avg_296_300_interp.*mask_t_3d;
            %             T1=T1(:,:,deploc(1):deploc(2));
            %             S1=S1(:,:,deploc(1):deploc(2));
            %             T1_1d=reshape(T1,[],1);T1_1d(fT0)=[];
            %             S1_1d=reshape(S1,[],1);S1_1d(fS0)=[];
            
            % KF-p
            %             T2=KF_p_TEMP_avg_296_300_interp.*mask_t_3d;
            %             S2=KF_p_SALT_avg_296_300_interp.*mask_t_3d;
            %             T2=T2(:,:,deploc(1):deploc(2));
            %             S2=S2(:,:,deploc(1):deploc(2));
            %             T2_1d=reshape(T2,[],1);T2_1d(fT0)=[];
            %             S2_1d=reshape(S2,[],1);S2_1d(fS0)=[];
            
            
            
            
            %% pic
            % Taylor digram cal
            
            for iii = 2:size(TT,1)
                c1=SS(1,:);
                c2=SS(iii,:);
                nflag=isnan(c2);
                c1(nflag)=[];
                c2(nflag)=[];
                C = allstats(c1,c2);
                statm(iii,:) = C(:,2);
            end
            statm(1,:) = C(:,1);
            refstd=statm(1,2);
            statm(1:end,2:3)=statm(1:end,2:3)/refstd;
            disp(num2str(statm,'% 1.3f'))
             STDs=squeeze(statm(:,2));
             RMSs=squeeze(statm(:,3));
             CORs=squeeze(statm(:,4));

            nSTD=0.2;mSTD=1;lSTD=1.5;
            nRMS=0.25;mRMS=1;lRMS=1;
%             if hi~=1
%                 nSTD=0.1;mSTD=0.3;lSTD=0.3;
%             end
% if hi==4
%     nSTD=0.05;mSTD=0.2;lSTD=0.2;
% end
            [pp tt axl] = taylordiag(STDs,RMSs,CORs,...
                'tickSTD',[0.:nSTD:mSTD],'limSTD',lSTD,...
                'tickRMS',[0:nRMS:mRMS],'titleRMS',0,'showlabelsRMS',0.0,'widthRMS',0.5,...
                'tickCOR',[.1:.2:.9 .95 .99],'showlabelsCOR',1,'titleCOR',1,'styleCOR','-.');

            for ii = 1 : length(tt)
                set(tt(ii),'fontsize',10,'fontweight','bold','String','')
                set(pp(ii),'markersize',20,'marker','.','linestyle','none','color',spcolor(ii,:))
                if ii==1
                    set(pp(ii),'markersize',20,'marker','.','linestyle','none','color',spcolor(ii,:))
                end
            end
            

            if hi==3
            hil=legend(pp,'PHC',casealias{1:4},'edgecolor','k');
            set(hil,'orientation','horizontal','position',[0.19 0.488 0.59 0.02])
            end

            X=get(gca,'xlim');
            Y=get(gca,'ylim');
            xtxt=X(1)+0.05*(X(2)-X(1));
            ytxt=Y(2)-0.25*(Y(2)-Y(1));
            text(xtxt,ytxt,seaname_TS{hi},'edgecolor','k','backgroundcolor','w','fontsize',11)
            
            xtxt=X(2)-0.165*(X(2)-X(1));
            ytxt=Y(2)+0.01*(Y(2)-Y(1));
            if hi==1
                ti=text(xtxt,ytxt,'SALT 100~1000m','edgecolor','k','backgroundcolor','w');
%                 set(ti,'position',[0.135 0.26 0])
%                 get(ti,'position')
            end
            %%
 
            pause(0.5)
        
            %% colorbar

        end %jj
    end %ii
    % set(ha,'tickdir','out')
end
