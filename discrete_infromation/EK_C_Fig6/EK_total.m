clear

load da.mat

load dad.mat

n=length(da);
styles = {'-', '--', ':', '-.','o-'};
cc=[62 43 109; 240 100 73; 255 170 50; 48 151 164; 5 80 91]./255;

A=0.01; %vibrtation amplitude
F=50; %vibrtation amplitude
np=800;
nph=8;

for i=1:n
    da(i).cl=(i-nph*floor(i/8)).*ones(np,1);
    if da(i).cl==0
        da(i).cl=nph.*ones(np,1);
    end
end



var=[da(1).image(:,6:8) da(1).vo];
vard=[dad(1).image(:,6:8) dad(1).vo];
cl=da(1).cl;
p=da(1).p(:,2);
pd=dad(1).image(:,17);

for i=2:n
    var=[var;[da(i).image(:,6:8) da(i).vo]];
    vard=[vard;[dad(i).image(:,6:8) dad(i).vo]];
    cl=[cl;da(i).cl];
end

ep=0.5.*(vecnorm(var(:,1:3),2,2).^2)./(A^2*F^2);
edp=0.5.*(vecnorm(vard(:,1:3),2,2).^2)./(A^2*F^2);

E=phasev_distri(log(ep),cl,0.1,nph);

Ed=phasev_distri(log(edp),cl,0.1,nph);

Vo=phasev_distri(var(:,4),cl,0.01,nph);

Vod=phasev_distri(vard(:,4),cl,0.01,nph);


flist=[1;2;5;7;8];

c=[62 43 109; 240 100 73; 255 170 50; 48 151 164; 5 80 91]./255;

figure()
subplot(2,2,1)
 for i=1:5
    plot(Ed(flist(i)).x,Ed(flist(i)).y,'color',c(i,:),'LineWidth',2.5)
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
    plot(E(flist(i)).x,E(flist(i)).y,'color',c(i,:),'LineWidth',2.5)
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
    plot(Vod(flist(i)).x,Vod(flist(i)).y,'color',c(i,:),'LineWidth',2.5)
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
    plot(Vo(flist(i)).x,Vo(flist(i)).y,'color',c(i,:),'LineWidth',2.5)
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


 










