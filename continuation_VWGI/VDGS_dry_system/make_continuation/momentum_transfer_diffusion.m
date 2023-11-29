clear

load d.mat

n=length(d);

x1=linspace(-0.07,0.07,26);
z1=linspace(-0.07,0.07,26);
y1=linspace(0,0.2,35);
[X,Y,Z]=meshgrid(x1,y1,z1);
xa=X(:);
ya=Y(:);
za=Z(:);

v=d(1).svar(:,1:3);
vo=d(1).svar(:,5);

for i=2:n
    
    v=v+d(i).svar(:,1:3);
    vo=vo+d(i).svar(:,5);

end

vm=v./n;
vom=vo./n;

aa1=find(vom>0.02&vecnorm([xa za],2,2)<=0.07&ya>=0.05);
aa2=find(vom>0.02&vecnorm([xa za],2,2)<=0.07&ya<0.12&ya>=0.1);

A=0.01;
F=50;
% momentum transfer

pt=d(1).svar(:,1:3).*d(1).svar(:,5)./(A*F);

for i=2:n
    
    pt=pt+d(i).svar(:,1:3).*d(i).svar(:,5)./(A*F);
    
end

mpt=abs(pt./n);
mmpt=mean(mpt(aa1,:),1);

% momentum diffusion
for i=1:n
    pdd(i).pd=abs(d(i).svar(:,1:3).*d(i).svar(:,5)./(A*F)-(pt./n));
end

pd=pdd(1).pd;

for i=2:n
    pd=pd+pdd(i).pd;
end

mpd=pd./n;
mmpd=mean(mpd(aa1,:),1);
    
aaa=find(vom<=0.02);
bbb=find(vecnorm([xa za],2,2)>0.07);
ccc=find(ya<0.05);

aa=[aaa;bbb;ccc];

mpd(aa,:)=0;
mpt(aa,:)=0;

x=X;
y=Y;
z=Z;

%1准备数据
filename=['convec_difuse1_NEW.plt'];
title='';%无标题
variables={'X','Y','Z','eu','ev','ew','edu','edv','edw'};
%variables={'X','Y','Z','V','ux','uy','uz'};
zone_title='';%无标题
Mat_Data=[x(:),y(:),z(:),mpt(:,1),mpt(:,2),mpt(:,3),mpd(:,1),mpd(:,2),mpd(:,3)];
%Mat_Data=[x(:),y(:),z(:),vmag_dep(:),ux_dep(:),uy_dep(:),uz_dep(:)];
IJK=size(x);
time=[];

%2创建文件
if exist(filename,'file')
    delete(filename)
end
f_id=fopen(filename,'a');
fclose(f_id);

%3创建文件头
plt_Head(filename,title,variables)
%4创建zone（point）格式
plt_Zone(filename,zone_title,IJK,time,Mat_Data)

function plt_Head(filename,title,variables)
%创建文件头
f_id=fopen(filename,'a');
%名称
if ~isempty(title)
    s=['TITLE = "',title,'"'];
    fprintf(f_id,'%s \r\n',s);
end

%变量
v=numel(variables);
s='VARIABLES = ';
for k=1:v
    if k~=1
        s=[s,','];
    end
    s=[s,' "',variables{k},'"'];
end
fprintf(f_id,'%s \r\n',s);
fclose(f_id);

end


function plt_Zone(filename,zone_title,IJK,time,Mat_Data)
%创建zone,point格式
f_id=fopen(filename,'a');
N=size(Mat_Data,1);

Dim=numel(IJK);
if Dim==1
    s=['zone I=',num2str( IJK(1) )];
elseif Dim==2
    s=['zone I=',num2str( IJK(1) ),',J=',num2str( IJK(2) )];
elseif Dim==3
    s=['zone I=',num2str( IJK(1) ),',J=',num2str( IJK(2) ),',K=',num2str( IJK(3) )];
end


%标题
if ~isempty(zone_title)
    s=[s,',t="',zone_title,'"'];
end
fprintf(f_id,'%s \r\n',s);
%格式为point
s='DATAPACKING=point';
fprintf(f_id,'%s \r\n',s);
%定义非定常时间
if ~isempty(time)
    s=['SOLUTIONTIME=',num2str(time)];
    fprintf(f_id,'%s \r\n',s);
end


%导入数据
for k=1:N
    fprintf(f_id,'%s \r\n',num2str(Mat_Data(k,:)));
end
fclose(f_id);
end
    
    




% for i=1:n
%     dd(i).e=1000.*d(i).svar(:,5).*d(i).svar(:,1:3);
% end
% 
% c=8; %因为一个周期取了8个样
% nc=floor(n/c);
% 
% for i=1:nc
%     ddc(i).ec=dd(1+(i-1)*c).e;
%     for j=2:c
%         ddc(i).ec=ddc(i).ec+dd(j+(i-1)*c).e;
%     end
%     ddc(i).ec=ddc(i).ec./c;
% %     mpec(i,:)=mean(ddc(i).ec(aa2,:),1);
% %     mpec_cum(i,:)=0.2*sum(mpec(1:i-1,:),1);
% end
% c=[62 43 109; 240 100 73; 255 170 50]./255;
% % 
% % 
% % figure()
% % 
% % for i=1:3
% %     plot((0:0.2:7.8),mpec_cum(:,i),'color',c(i,:),'LineWidth',1.5)
% %     hold on
% % end
% 
% 
% ttec=ddc(1).ec;
% for i=2:nc
%     ttec=ttec+ddc(i).ec;
% end
% 
% mtec=abs(ttec./nc);
% 
% mptec=mean(mtec(aa1,:),1);
% 
% % mpecd1=abs(mpec-mptec);
% % 
% % for i=1:nc
% %     mpecd1_cum(i,:)=0.2.*sum(mpecd1(1:i-1,:),1);
% % end
% % 
% % figure()
% % 
% % for i=1:3
% %     plot((0:0.2:7.8),mpecd1_cum(:,i),'color',c(i,:),'LineWidth',1.5)
% %     hold on
% % end
% 
% 
% 
% for i=1:nc
%     ddc(i).ecd=abs(ddc(i).ec-ttec./nc);
%     mpecd(i,:)=mean(ddc(i).ecd(aa1,:),1);
%     mpecd_cum(i,:)=0.2.*sum(mpecd(1:i-1,:),1);
% end
% 
% figure()
% 
% for i=1:3
%     plot((0:0.2:7.8),mpecd_cum(:,i),'color',c(i,:),'LineWidth',1.5)
%     hold on
% end
% 
% ttecd=ddc(1).ecd;
% for i=2:nc
%     ttecd=ttecd+ddc(i).ecd;
% end
% 
% mtecd=ttecd./nc;
% 
% mptecd=mean(mtecd(aa1,:),1);









    
















