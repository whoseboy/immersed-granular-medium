clear

load da.mat

load dad.mat

vo=da(1).vo;
vod=dad(1).vo;

p=da(1).p;
pd=dad(1).image(:,16:18);

n=length(da);

for i=2:n
    vo=[vo;da(i).vo];
    vod=[vod;dad(i).vo];
    p=[p;da(i).p];
    pd=[pd;dad(i).image(:,16:18)];
end


x=linspace(-0.075,0.075,10);
z=linspace(-0.075,0.075,10);
y=linspace(0,0.2,15);
[X,Y,Z]=meshgrid(x,y,z);
xa=X(:);
ya=Y(:);
za=Z(:);
p_in=[xa ya za];

h=0.02;

ns=length(xa);

stdvo=sp_re1(p,p_in,h,vo,ns,0.005);
stdvod=sp_re1(pd,p_in,h,vod,ns,0.005);

c=[62 43 109; 240 100 73; 255 170 50]./255;











% mvo=zeros(ns,1);
% voR=zeros(ns,1);
% for i=1:ns
%     r=vecnorm(p-p_in(i,:),2,2);
%     d(i).vo=vo(r<=h);
%     d(i).mvo=mean(d(i).vo);
%     d(i).voR=std(d(i).vo);
%     mvo(i)=d(i).mvo;
%     voR(i)=d(i).voR;
% end
% 
% voR1=voR(mvo>=0.05);
% p_in1=p_in(mvo>=0.05,:);
% voR2=voR1(p_in1(:,2)>=0.05);
% 
% mvod=zeros(ns,1);
% voRd=zeros(ns,1);
% for i=1:ns
%     rd=vecnorm(pd-p_in(i,:),2,2);
%     dd(i).vo=vod(rd<=h);
%     dd(i).mvo=mean(dd(i).vo);
%     dd(i).voR=std(dd(i).vo);
%     mvod(i)=dd(i).mvo;
%     voRd(i)=dd(i).voR;
% end
% 
% voRd1=voRd(mvod>=0.05);
% p_ind1=p_in(mvod>=0.05,:);
% voRd2=voRd1(p_ind1(:,2)>=0.05);


ss(1).p=[0 0.06 0; 0.02 0.06 0; 0.05 0.06 0];
ss(2).p=[0 0.08 0; 0.02 0.08 0; 0.05 0.08 0];
ss(3).p=[0 0.1 0; 0.02 0.1 0; 0.05 0.1 0];
ss(4).p=[0 0.12 0; 0.02 0.12 0; 0.05 0.12 0];

s=sp_re(p,vo,ss,h,0.01,3,3);
sd=sp_re(p,vod,ss,h,0.01,4,3);

styles = {'-',  '-.',':'};

figure()


subplot(2,2,1)
for i=1:4
    
    for j=1:3

    plot3(sd(i).h(j).z./0.01,sd(i).h(j).x,sd(i).h(j).y,'color',c(j,:),'LineWidth',2.5,'LineStyle', styles{j})
    hold on
    box on;
    % 设置刻度线为外部显示
    set(gca, 'TickDir', 'out');  
    % 设置刻度线长度为0.02
    set(gca, 'TickLength', [0.02, 0.02]);
    % 设置坐标轴宽度为1.5
    set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
    set(gca, 'FontName', 'Arial', 'FontSize', 20);
    end
end

subplot(2,2,2)

for i=1:3
    
    for j=1:3

    plot3(s(i).h(j).z./0.01,s(i).h(j).x,s(i).h(j).y,'color',c(j,:),'LineWidth',2.5,'LineStyle', styles{j})
    hold on
    box on;
    % 设置刻度线为外部显示
    set(gca, 'TickDir', 'out');  
    % 设置刻度线长度为0.02
    set(gca, 'TickLength', [0.02, 0.02]);
    % 设置坐标轴宽度为1.5
    set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
    set(gca, 'FontName', 'Arial', 'FontSize', 20);
    end
end



subplot(2,2,3)
plot(stdvod.x,stdvod.y,'color',c(2,:),'LineWidth',2.5)
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
% 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 20);

subplot(2,2,4)

plot(stdvo.x,stdvo.y,'color',c(1,:),'LineWidth',2.5)
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
% 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 20);




