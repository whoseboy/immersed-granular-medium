clear

load pair.mat
load paird.mat


n=length(pair);

for i=1:n
    pwl(i)=size(pair(i).pwp,1); %particle-wall
    pwld(i)=size(paird(i).pwp,1);
    ppl1(i)=size(pair(i).pppm(pair(i).pppm(:,2)<=0.05),1);%particle-particle Hy<=5dp
    ppld1(i)=size(paird(i).pppm(paird(i).pppm(:,2)<=0.05),1);
    ppl2(i)=size(pair(i).pppm(pair(i).pppm(:,2)>0.05),1);%particle-particle Hy>5dp
    ppld2(i)=size(paird(i).pppm(paird(i).pppm(:,2)>0.05),1);
end

c=[62 43 109; 240 100 73]./255;
t=(0:1:39).*0.0025./0.02;
figure()
subplot(2,2,[1,2])
plot(t,pwl(9:48),'color',c(1,:),'LineWidth',2.5)
hold on
plot(t,pwld(9:48),'color',c(2,:),'LineWidth',2.5)
hold off
% 取消图形边框
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
% 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 20);

subplot(2,2,3)
plot(t,ppl1(9:48),'color',c(1,:),'LineWidth',2.5)
hold on
plot(t,ppld1(9:48),'color',c(2,:),'LineWidth',2.5)
hold off
% 取消图形边框
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
plot(t,ppl2(9:48),'color',c(1,:),'LineWidth',2.5)
hold on
plot(t,ppld2(9:48),'color',c(2,:),'LineWidth',2.5)
hold off
% 取消图形边框
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
% 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 20);