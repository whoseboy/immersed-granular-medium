clear

load da.mat

load dad.mat


n=length(da);

var=[da(1).image(:,6:8) da(1).vo];
vard=[dad(1).image(:,6:8) dad(1).vo];

p=da(1).p;
pd=dad(1).image(:,16:18);

for i=2:n
    var=[var;[da(i).image(:,6:8) da(i).vo]];
    vard=[vard;[dad(i).image(:,6:8) dad(i).vo]];
    p=[p;da(i).p];
    pd=[pd;dad(i).image(:,16:18)];
end

var=var(p(:,2)>=0.05,:);
vard=vard(pd(:,2)>=0.05,:);
p=p(p(:,2)>=0.05,:);
pd=pd(pd(:,2)>=0.05,:);


A=0.01; %vibrtation amplitude
F=50; %vibrtation amplitude

ep=0.5.*(vecnorm(var(:,1:3),2,2).^2)./(A^2*F^2);
edp=0.5.*(vecnorm(vard(:,1:3),2,2).^2)./(A^2*F^2);


palpha=acos(p(:,1)./vecnorm([p(:,1) p(:,3)],2,2));
palpha(p(:,3)<0)=palpha(p(:,3)<0)+pi;
xzalpha=acos(var(:,1)./vecnorm([var(:,1) var(:,3)],2,2));
xzalpha(var(:,3)<0)=xzalpha(var(:,3)<0)+pi;
yalpha=acos(var(:,2)./vecnorm(var(:,1:3),2,2));
% yalpha(var(:,2)<0)=-yalpha(var(:,2)<0)+0.5*pi;


pdalpha=acos(pd(:,1)./vecnorm([pd(:,1) pd(:,3)],2,2));
pdalpha(pd(:,3)<0)=pdalpha(pd(:,3)<0)+pi;
xzdalpha=acos(vard(:,1)./vecnorm([vard(:,1) vard(:,3)],2,2));
xzdalpha(vard(:,3)<0)=xzdalpha(vard(:,3)<0)+pi;
ydalpha=acos(vard(:,2)./vecnorm(vard(:,1:3),2,2));
% ydalpha(vard(:,2)<0)=-ydalpha(vard(:,2)<0)+0.5*pi;
load map.mat
figure()
subplot(2,4,1)
h=histogram2(palpha./pi,xzalpha./pi,'DisplayStyle','tile','ShowEmptyBins','on');
h.Normalization='probability';
h.NumBins=[15 20];
h.FaceColor= 'flat';
cb = colorbar();
cb.Ruler.Exponent = -3;
colormap(map)
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 20);
subplot(2,4,2)
h=histogram2(palpha./pi,yalpha./pi,'DisplayStyle','tile','ShowEmptyBins','on');
h.Normalization='probability';
h.NumBins=[15 20];
h.FaceColor= 'flat';
cb = colorbar();
cb.Ruler.Exponent = -3;
colormap(map)
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 20);
subplot(2,4,3)
h=histogram2(palpha./pi,log(ep),'DisplayStyle','tile','ShowEmptyBins','on');
h.Normalization='probability';
h.NumBins=[15 20];
h.FaceColor= 'flat';
cb = colorbar();
cb.Ruler.Exponent = -2;
colormap(map)
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 20);
subplot(2,4,4)
h=histogram2(palpha./pi,var(:,4),'DisplayStyle','tile','ShowEmptyBins','on');
h.Normalization='probability';
h.NumBins=[15 20];
h.FaceColor= 'flat';
cb = colorbar();
cb.Ruler.Exponent = -3;
colormap(map)
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 20);
subplot(2,4,5)
h=histogram2(pdalpha./pi,xzdalpha./pi,'DisplayStyle','tile','ShowEmptyBins','on');
h.Normalization='probability';
h.NumBins=[15 20];
h.FaceColor= 'flat';
cb = colorbar();
cb.Ruler.Exponent = -3;
cb.Limits = [0.0017 0.0042];
cb.Ticks = 0.002:0.0005:0.004;
colormap(map)
caxis([0.0017 0.0042]);
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 20);
subplot(2,4,6)
h=histogram2(pdalpha./pi,ydalpha./pi,'DisplayStyle','tile','ShowEmptyBins','on');
h.Normalization='probability';
h.NumBins=[15 20];
h.FaceColor= 'flat';
cb = colorbar();
cb.Ruler.Exponent = -3;
colormap(map)
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 20);
subplot(2,4,7)
h=histogram2(pdalpha./pi,log(edp),'DisplayStyle','tile','ShowEmptyBins','on');
h.Normalization='probability';
h.NumBins=[15 20];
h.FaceColor= 'flat';
cb = colorbar();
cb.Ruler.Exponent = -2;
colormap(map)
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 20);
subplot(2,4,8)
h=histogram2(pdalpha./pi,vard(:,4),'DisplayStyle','tile','ShowEmptyBins','on');
h.Normalization='probability';
h.NumBins=[15 20];
h.FaceColor= 'flat';
cb = colorbar();
cb.Ruler.Exponent = -3;
colormap(map)
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 20);












