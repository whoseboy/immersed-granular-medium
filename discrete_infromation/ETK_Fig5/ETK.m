clear

load da.mat

load dad.mat

% in da.mat, da.image is the discrete infromation, [:,1] is the particle's id, [:,6:8] is the velocity, 
% [:,9:11] is the total force, [:,12] is the radius, [:,13:15] is the rotational velocity,
% [:,16:18] is the fluid force; [:,19:21] is the position. 
% da.voro is the voronoi cell volume, da.vo is the particle's volume fraction.

% in dad.mat, dad.image is the discrete infromation, [:,1] is the particle's id, [:,6:8] is the velocity, 
% [:,9:11] is the total force, [:,12] is the radius, [:,13:15] is the position,
% [:,16:18] is the position.
% dad.voro is the voronoi cell volume, dad.vo is the particle's volume fraction.


styles = {'-', '--', ':', '-.'};
cc=[62 43 109; 240 100 73; 255 170 50; 48 151 164; 5 80 91]./255;
np=800; %number of particle number
A=0.01; %vibrtation amplitude
F=50; %vibrtation amplitude

%% 14-18 ETK temporal variation

n=length(dad);

et=zeros(n,1);
edt=zeros(n,1);

for i=1:n
    et(i)=0.5*sum(vecnorm(da(i).image(:,6:8),2,2).^2)/(A^2*F^2);% VIGS ETK dimensionless
    edt(i)=0.5*sum(vecnorm(dad(i).image(:,6:8),2,2).^2)/(A^2*F^2);% VDGS ETK dimensionless
end

t=(14+(0:1:1599).*0.0025)./0.02; %dimensionless t 14-18s

std_et=std(et); % VIGS ETK SD
std_edt=std(edt); % VDGS ETK SD


% PLOT ETK-T
figure()
subplot(2,1,1)
plot(t,edt,'color',cc(1,:),'LineWidth',1)
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
subplot(2,1,2)
plot(t,et,'color',cc(2,:),'LineWidth',1)
legend('off');
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



%% 14-14.2 15-15.2 16-16.2 17-17.2 ETK variation
delt_t=(0:1:79).*0.0025./0.02;

figure()
subplot(2,1,1)% VDGS
plot(delt_t,edt(1:80),'color',cc(1,:),'LineWidth',2,'LineStyle', styles{1})
hold on 
plot(delt_t,edt(561:640),'color',cc(2,:),'LineWidth',2,'LineStyle', styles{2})
hold on
plot(delt_t,edt(1001:1080),'color',cc(3,:),'LineWidth',2,'LineStyle', styles{3})
hold on
plot(delt_t,edt(1521:1600),'color',cc(4,:),'LineWidth',2,'LineStyle', styles{4})
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

subplot(2,1,2)% VIGS
plot(delt_t,et(1:80),'color',cc(1,:),'LineWidth',2,'LineStyle', styles{1})
hold on 
plot(delt_t,et(561:640),'color',cc(2,:),'LineWidth',2,'LineStyle', styles{2})
hold on
plot(delt_t,et(1001:1080),'color',cc(3,:),'LineWidth',2,'LineStyle', styles{3})
hold on
plot(delt_t,et(1521:1600),'color',cc(4,:),'LineWidth',2,'LineStyle', styles{4})
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


% delt_t1=(0:1:7).*0.0025./0.02;
delt_t1=(0:1:8).*0.0025./0.02;
% y=sin(2*pi*50.*(0:1:8).*0.0025);

figure()
% subplot(3,1,1)
% plot(delt_t1,y,'k-','LineWidth',2)
% % 取消图形边框
% box off;
% % 设置刻度线为外部显示
% set(gca, 'TickDir', 'out');  
% % 设置刻度线长度为0.02
% set(gca, 'TickLength', [0.02, 0.02]);
% % 设置坐标轴宽度为1.5
% set(gca, 'LineWidth', 1.5);
% % 更改字体样式和大小
% set(gca, 'FontName', 'Arial', 'FontSize', 20);


subplot(2,1,1)% VDGS
plot(delt_t1,edt(1:9),'color',cc(1,:),'LineWidth',2,'LineStyle', styles{1})
hold on 
plot(delt_t1,edt(561:569),'color',cc(2,:),'LineWidth',2,'LineStyle', styles{2})
hold on
plot(delt_t1,edt(1001:1009),'color',cc(3,:),'LineWidth',2,'LineStyle', styles{3})
hold on
plot(delt_t1,edt(1521:1529),'color',cc(4,:),'LineWidth',2,'LineStyle', styles{4})
% 取消图形边框
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
% 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 17);

subplot(2,1,2)% VIGS
plot(delt_t1,et(1:9),'color',cc(1,:),'LineWidth',2,'LineStyle', styles{1})
hold on 
plot(delt_t1,et(561:569),'color',cc(2,:),'LineWidth',2,'LineStyle', styles{2})
hold on
plot(delt_t1,et(1001:1009),'color',cc(3,:),'LineWidth',2,'LineStyle', styles{3})
hold on
plot(delt_t1,et(1521:1529),'color',cc(4,:),'LineWidth',2,'LineStyle', styles{4})
% 取消图形边框
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
% 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 17);











%% ETK variation among vibrating period

c=8; %因为一个周期取了8个样

nc=floor(n/c);

etc=zeros(nc,1);
edtc=zeros(nc,1);

for i=1:nc
    etc(i)=mean(et(1+(i-1)*c:i*c));
    edtc(i)=mean(edt(1+(i-1)*c:i*c));
end

std_etc=std(etc);
std_edtc=std(edtc);

figure()
subplot(2,1,1)
plot(edtc,'color',cc(1,:),'LineWidth',1)
% 取消图形边框
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
% 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 17);

subplot(2,1,2)
plot(etc,'color',cc(2,:),'LineWidth',1)
% 取消图形边框
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
% 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 17);


%% ETK FFT


Fs = 400;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1600;             % Length of signal
t = (0:L-1)*T;        % Time vector

Ygan = fft(edt);
P2gan = abs(Ygan/L);
P1gan = P2gan(1:L/2+1);
P1gan(2:end-1) = 2*P1gan(2:end-1);
fgan = Fs*(0:(L/2))/L;

Yim = fft(et);
P2im = abs(Yim/L);
P1im = P2im(1:L/2+1);
P1im(2:end-1) = 2*P1im(2:end-1);
fim = Fs*(0:(L/2))/L;

figure()
subplot(2,1,1)
plot(log(fgan.*0.02),P1gan./sum(P1gan),'color',cc(1,:),'LineWidth',2) 
% 取消图形边框
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
% 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 17);

subplot(2,1,2)
plot(log(fim.*0.02),P1im./sum(P1im),'color',cc(2,:),'LineWidth',2)
% 取消图形边框
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
% 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 17);


%% histogram of ETK (mean value of period)

figure()
subplot(2,1,1)
hd=histogram(edtc,'Normalization','probability','FaceColor',cc(1,:));
hd.BinWidth = 30;
yd=hd.Values';
ad=hd.BinEdges';
deltxd=ad(2)-ad(1);
xd=ad(1:(length(ad)-1))+deltxd/2;
hold on
plot(xd,yd,'color',cc(1,:),'LineWidth',2)
hold on
x1=min(edtc):3:max(edtc);
fx=normpdf(x1,mean(edtc),std(edtc));
plot(x1,fx*length(edtc)./(sum(fx*length(edtc))*0.1),'color',cc(1,:),'LineWidth',2,'LineStyle', styles{2})

% 取消图形边框
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
% 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 17);

subplot(2,1,2)
h=histogram(etc,'Normalization','probability','FaceColor',cc(2,:));
h.BinWidth = 30;
y=h.Values';
a=h.BinEdges';
deltx=a(2)-a(1);
x=a(1:(length(a)-1))+deltx/2;
hold on
plot(x,y,'color',cc(2,:),'LineWidth',2) 
hold on
x2=min(etc):3:max(etc);
fx=normpdf(x2,mean(etc),std(etc));
plot(x2,fx*length(etc)./(sum(fx*length(etc))*0.1),'color',cc(2,:),'LineWidth',2,'LineStyle', styles{2})

% 取消图形边框
box off;
% 设置刻度线为外部显示
set(gca, 'TickDir', 'out');  
% 设置刻度线长度为0.02
set(gca, 'TickLength', [0.02, 0.02]);
% 设置坐标轴宽度为1.5
set(gca, 'LineWidth', 1.5);
% 更改字体样式和大小
set(gca, 'FontName', 'Arial', 'FontSize', 17);













    


    





    
    
