clear

load da1.mat % discrete infrmation

% in da1.mat, da.image is the discrete infromation, [:,1] is the particle's id, [:,6:8] is the velocity, 
% [:,9:11] is the total force, [:,12] is the radius, [:,13:15] is the rotational velocity,
% [:,16:18] is the fluid force; [:,19:21] is the position. 
% da.voro is the voronoi cell volume, da.vo is the particle's volume fraction.
% based on the VWGI method, you can obtain the continious infrmation using these discrete infromation. 

n=320;  % analysis duration
n1=0;


% selecting the parameters
for i=1:n
    dda(i).ftp=da(i+n1).ftp;
    dda(i).fdp=da(i+n1).fdp;
    dda(i).fbp=da(i+n1).fbp;
    dda(i).v=da(i+n1).v;
    dda(i).V=da(i+n1).V;
    dda(i).vo=da(i+n1).vo;
    dda(i).p=da(i+n1).p;
    dda(i).voro=da(i+n1).voro;
end

% mmaking mesh point for continuation
x1=linspace(-0.07,0.07,26);
z1=linspace(-0.07,0.07,26);
y1=linspace(0,0.2,35);
[X,Y,Z]=meshgrid(x1,y1,z1);
xa=X(:);
ya=Y(:);
za=Z(:);
p_in=[xa ya za];


% n=length(dda);



% doing continuation using VWGI method

ni=length(xa);
h=(0.002:0.001:0.06);

a=length(h);

hh=waitbar(0,'please wait');
for i=1:n
    for j=1:ni
        p=dda(i).p-p_in(j,:);
        r=vecnorm(p,2,2);
        d(i).s(j).sw=zeros(a,1);
        for k=1:a
            rr=r(r<=h(k));
            v=dda(i).voro(r<=h(k),2);
            d(i).s(j).sw(k)=sum((1/((h(k)^3)*(pi^1.5)).*v.*exp(-(rr.^2/(2.*(h(k)).^2)))));
        end
    end
     waitbar(i/n,hh)
end
delete(hh);

% save d.mat d
% save dda.mat dda

hh=waitbar(0,'please wait');
for i=1:n
    dda(i).V=vecnorm(dda(i).v,2,2);
    dda(i).var=[dda(i).ftp dda(i).fdp  dda(i).fbp  dda(i).v dda(i).V dda(i).vo];
    d(i).svar=zeros(ni,size(dda(i).var,2));
    d(i).sRo=zeros(ni,size(dda(i).var,2));
    d(i).sR=zeros(ni,size(dda(i).var,2));
    d(i).swp=zeros(ni,1);
    waitbar(i/n,hh)
end
delete(hh);
% save d.mat d
% save dda.mat dda
R=0.075;
hh=waitbar(0,'please wait');
for i=1:n
    for j=1:ni
        [s,l]=min(abs(d(i).s(j).sw-1));
        d(i).swp(j)=s;
        hp=h(l);
        p=dda(i).p-p_in(j,:);
        r=vecnorm(p,2,2);
        pl=find(r<=h(l));
        rr=r(pl);
        v=dda(i).voro(pl,2);
        var=dda(i).var(pl,:);
        dd=vecnorm((p_in(j,:)-[0,ya(j),0]),2,2);
        w=(1/((hp^3)*(pi^1.5)).*v.*exp(-(rr.^2/(2.*(hp^2)))));
        if dd>R-hp&&dd<R+hp
            alpha=(R^2+dd^2-hp^2)/(2*R*dd);
            h1=R*(1-alpha);
            alphb=(hp^2+dd^2-R^2)/(2*hp*dd);
            h2=hp*(1-alphb);
            ratio=((pi*((3*R-h1)*h1^2+(3*hp-h2)*h2^2))/3)/((4*pi*hp^3)/3);
            d(i).svar(j,:)=(sum(var.*w,1))/ratio;
        else
            d(i).svar(j,:)=sum(var.*w,1);
        end
        
        
            
%         d(i).sRo(j,:)=mean((var-d(i).svar(j,:)).^2,1);
%         d(i).sR(j,:)=mean((var.*w-d(i).svar(j,:)).^2,1);
    end
    d(i).svarn=d(i).svar;
%     d(i).svarn(d(i).svar(:,8)<=0.02,:)=0;
%     tri = delaunayn(dda(i).p);
%     tn =tsearchn(dda(i).p,tri,[xa ya za]);
%     in = ~isnan(tn);
%     d(i).svar(~in,:)=0;
    
    waitbar(i/n,hh)
end

delete(hh);

tri = delaunayn(dda(1).p);
tn =tsearchn(dda(1).p,tri,[xa ya za]);
in = ~isnan(tn);



histogram(d(1).swp(in))
% save d.mat d
% save dda.mat dda

x=X;
y=Y;
z=Z;
% time-averaging

vm=d(1).svarn(:,4:6);

V=d(1).svarn(:,7);

vo=d(1).svarn(:,8);




for i=2:n
    
    vm=vm+d(i).svarn(:,4:6);
    V=V+d(i).svarn(:,7);
    vo=vo+d(i).svarn(:,8);
end

vm=vm./n;
V=V./n;
vo=vo./n;

vm1=vm;
V1=V;
vo1=vo;

vm1(vo<=0.02,:)=0;
V1(vo<=0.02,:)=0;
vo1(vo<=0.02,:)=0;





% to Tecplot

% 1准备数据
filename=['var_s1.plt'];
title='';%无标题
variables={'X','Y','Z','u','v','w','rho','mv'};
% variables={'X','Y','Z','V','ux','uy','uz'};
zone_title='';%无标题
Mat_data=[x(:),y(:),z(:),vm1(:,1),vm1(:,2),vm1(:,3),vo1,V1];
% Mat_ddata=[x(:),y(:),z(:),vmag_dep(:),ux_dep(:),uy_dep(:),uz_dep(:)];
IJK=size(x);
time=[];

% 2创建文件
if exist(filename,'file')
    delete(filename)
end
f_id=fopen(filename,'a');
fclose(f_id);

% 3创建文件头
plt_Head(filename,title,variables)
% 4创建zone（point）格式
plt_Zone(filename,zone_title,IJK,time,Mat_data)

function plt_Head(filename,title,variables)
% 创建文件头
f_id=fopen(filename,'a');
% 名称
if ~isempty(title)
    s=['TITLE = "',title,'"'];
    fprintf(f_id,'%s \r\n',s);
end

% 变量
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


function plt_Zone(filename,zone_title,IJK,time,Mat_data)
% 创建zone,point格式
f_id=fopen(filename,'a');
N=size(Mat_data,1);

Dim=numel(IJK);
if Dim==1
    s=['zone I=',num2str( IJK(1) )];
elseif Dim==2
    s=['zone I=',num2str( IJK(1) ),',J=',num2str( IJK(2) )];
elseif Dim==3
    s=['zone I=',num2str( IJK(1) ),',J=',num2str( IJK(2) ),',K=',num2str( IJK(3) )];
end


% 标题
if ~isempty(zone_title)
    s=[s,',t="',zone_title,'"'];
end
fprintf(f_id,'%s \r\n',s);
% 格式为point
s='daTAPACKING=point';
fprintf(f_id,'%s \r\n',s);
% 定义非定常时间
if ~isempty(time)
    s=['SOLUTIONTIME=',num2str(time)];
    fprintf(f_id,'%s \r\n',s);
end


% 导入数据
for k=1:N
    fprintf(f_id,'%s \r\n',num2str(Mat_data(k,:)));
end
fclose(f_id);
end





