clear


load da.mat
load dad.mat

n=length(da);

rlist=[0 0.014 0.028 0.042 0.056 0.071];

for i=1:n
    r=vecnorm([da(i).p(:,1) da(i).p(:,3)],2,2);
    rd=vecnorm([dad(i).image(:,16) dad(i).image(:,18)],2,2);
    for j=1:length(rlist)-1
        da(i).rl(r<=rlist(j+1)&r>rlist(j))=j;
        dad(i).rl(rd<=rlist(j+1)&rd>rlist(j))=j;
    end
end

var1=[da(1).image(:,6:8) da(1).vo];
vard1=[dad(1).image(:,6:8) dad(1).vo];

p1=da(1).p;
pd1=dad(1).image(:,16:18);

rl1=da(1).rl';
rdl1=dad(1).rl';

for i=2:n
    var1=[var1;[da(i).image(:,6:8) da(i).vo]];
    vard1=[vard1;[dad(i).image(:,6:8) dad(i).vo]];
    p1=[p1;da(i).p];
    pd1=[pd1;dad(i).image(:,16:18)];
    rl1=[rl1;da(i).rl'];
    rdl1=[rdl1;dad(i).rl'];
end

var=var1(p1(:,2)>=0.05&p1(:,2)<=0.2,:);
vard=vard1(pd1(:,2)>=0.05&pd1(:,2)<=0.2,:);
p=p1(p1(:,2)>=0.05&p1(:,2)<=0.2,:);
pd=pd1(pd1(:,2)>=0.05&pd1(:,2)<=0.2,:);
rl=rl1(p1(:,2)>=0.05&p1(:,2)<=0.2,:);
rdl=rdl1(pd1(:,2)>=0.05&pd1(:,2)<=0.2,:);

A=0.01; %vibrtation amplitude
F=50; %vibrtation amplitude

ep=0.5.*(vecnorm(var(:,1:3),2,2).^2)./(A^2*F^2);
edp=0.5.*(vecnorm(vard(:,1:3),2,2).^2)./(A^2*F^2);

xzalpha=acos(var(:,1)./vecnorm([var(:,1) var(:,3)],2,2));
xzalpha(var(:,3)<0)=xzalpha(var(:,3)<0)+pi;
yalpha=acos(var(:,2)./vecnorm(var(:,1:3),2,2));
% yalpha(var(:,2)<0)=-yalpha(var(:,2)<0)+0.5*pi;


xzdalpha=acos(vard(:,1)./vecnorm([vard(:,1) vard(:,3)],2,2));
xzdalpha(vard(:,3)<0)=xzdalpha(vard(:,3)<0)+pi;
ydalpha=acos(vard(:,2)./vecnorm(vard(:,1:3),2,2));
% ydalpha(vard(:,2)<0)=-ydalpha(vard(:,2)<0)+0.5*pi;

E=phasev_distri(log(ep),rl,0.1,5);
Ed=phasev_distri(log(edp),rdl,0.1,5);

Vo=phasev_distri(var(:,4),rl,0.01,5);
Vod=phasev_distri(vard(:,4),rdl,0.01,5);

Yalpha=phasev_distri(yalpha,rl,0.1,5);
Ydalpha=phasev_distri(ydalpha,rdl,0.1,5);

XZalpha=phasev_distri(xzalpha,rl,0.1,5);
XZdalpha=phasev_distri(xzdalpha,rdl,0.1,5);



c=[62 43 109; 240 100 73; 255 170 50; 48 151 164; 5 80 91]./255;

figure()
subplot(2,2,1)
 for i=1:5
    plot(E(i).x,E(i).y,'color',c(i,:),'LineWidth',2.5)
    hold on
    box off;
    % 设置刻度线为外部显示
    set(gca, 'TickDir', 'out');  
    % 设置刻度线长度为0.02
    set(gca, 'TickLength', [0.02, 0.02]);
    % 设置坐标轴宽度为1.5
    set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
    set(gca, 'FontName', 'Arial', 'FontSize', 20);
 end

subplot(2,2,2)
 for i=1:5
    plot(Vo(i).x,Vo(i).y,'color',c(i,:),'LineWidth',2.5)
    hold on
    box off;
    % 设置刻度线为外部显示
    set(gca, 'TickDir', 'out');  
    % 设置刻度线长度为0.02
    set(gca, 'TickLength', [0.02, 0.02]);
    % 设置坐标轴宽度为1.5
    set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
    set(gca, 'FontName', 'Arial', 'FontSize', 20);
 end

subplot(2,2,3)
 for i=1:5
    plot(Yalpha(i).x./pi,Yalpha(i).y,'color',c(i,:),'LineWidth',2.5)
    hold on
    box off;
    % 设置刻度线为外部显示
    set(gca, 'TickDir', 'out');  
    % 设置刻度线长度为0.02
    set(gca, 'TickLength', [0.02, 0.02]);
    % 设置坐标轴宽度为1.5
    set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
    set(gca, 'FontName', 'Arial', 'FontSize', 20);
 end

subplot(2,2,4)
 for i=1:5
    plot(XZalpha(i).x./pi,XZalpha(i).y,'color',c(i,:),'LineWidth',2.5)
    hold on
    box off;
    % 设置刻度线为外部显示
    set(gca, 'TickDir', 'out');  
    % 设置刻度线长度为0.02
    set(gca, 'TickLength', [0.02, 0.02]);
    % 设置坐标轴宽度为1.5
    set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
    set(gca, 'FontName', 'Arial', 'FontSize', 20);
 end

figure()
subplot(2,2,1)
 for i=1:5
    plot(Ed(i).x,Ed(i).y,'color',c(i,:),'LineWidth',2.5)
    hold on
    box off;
    % 设置刻度线为外部显示
    set(gca, 'TickDir', 'out');  
    % 设置刻度线长度为0.02
    set(gca, 'TickLength', [0.02, 0.02]);
    % 设置坐标轴宽度为1.5
    set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
    set(gca, 'FontName', 'Arial', 'FontSize', 20);
 end

subplot(2,2,2)
 for i=1:5
    plot(Vod(i).x,Vod(i).y,'color',c(i,:),'LineWidth',2.5)
    hold on
    box off;
    % 设置刻度线为外部显示
    set(gca, 'TickDir', 'out');  
    % 设置刻度线长度为0.02
    set(gca, 'TickLength', [0.02, 0.02]);
    % 设置坐标轴宽度为1.5
    set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
    set(gca, 'FontName', 'Arial', 'FontSize', 20);
 end

subplot(2,2,3)
 for i=1:5
    plot(Ydalpha(i).x./pi,Ydalpha(i).y,'color',c(i,:),'LineWidth',2.5)
    hold on
    box off;
    % 设置刻度线为外部显示
    set(gca, 'TickDir', 'out');  
    % 设置刻度线长度为0.02
    set(gca, 'TickLength', [0.02, 0.02]);
    % 设置坐标轴宽度为1.5
    set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
    set(gca, 'FontName', 'Arial', 'FontSize', 20);
 end

subplot(2,2,4)
 for i=1:5
    plot(XZdalpha(i).x./pi,XZdalpha(i).y,'color',c(i,:),'LineWidth',2.5)
    hold on
    box off;
    % 设置刻度线为外部显示
    set(gca, 'TickDir', 'out');  
    % 设置刻度线长度为0.02
    set(gca, 'TickLength', [0.02, 0.02]);
    % 设置坐标轴宽度为1.5
    set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
    set(gca, 'FontName', 'Arial', 'FontSize', 20);
 end
 