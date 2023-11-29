clear

load da.mat

load dad.mat


v=da(1).v;
vd=dad(1).image(:,6:8);

p=da(1).p(:,2);
pd=da(1).image(:,17);

n=length(da);

for i=2:n
    v=[v;da(i).v];
    vd=[vd;dad(i).image(:,6:8)];
    p=[p;da(i).p(:,2)];
    pd=[pd;dad(i).image(:,17)];
end

v=v(p>=0.05,:);
vd=vd(pd>=0.05,:);

A=0.01; %vibrtation amplitude
F=50; %vibrtation amplitude

ev=log(0.5.*(v.^2)./(A^2*F^2));
evd=log(0.5.*(vd.^2)./(A^2*F^2));






for i=1:3
    D(i).ev=ev(:,i);
    D(i).h=histogram(D(i).ev,'Normalization','probability');
    D(i).h.BinWidth = 0.1;
    D(i).y=D(i).h.Values';
    a=D(i).h.BinEdges';
    deltx=a(2)-a(1);
    D(i).x=a(1:(length(a)-1))+deltx/2;
    
    Dd(i).ev=evd(:,i);
    Dd(i).h=histogram(Dd(i).ev,'Normalization','probability');
    Dd(i).h.BinWidth = 0.1;
    Dd(i).y=Dd(i).h.Values';
    ad=Dd(i).h.BinEdges';
    deltxd=ad(2)-ad(1);
    Dd(i).x=ad(1:(length(ad)-1))+deltxd/2;
    
    
    
end

c=[62 43 109; 240 100 73; 255 170 50]./255;
styles = {'-',  '-.',':'};

figure()
subplot(2,1,1)
 for i=1:3
    plot(Dd(i).x,Dd(i).y,'color',c(i,:),'LineWidth',2.5,'LineStyle', styles{i})
    hold on
        box off;
    % 设置刻度线为外部显示
    set(gca, 'TickDir', 'out');  
    % 设置刻度线长度为0.02
    set(gca, 'TickLength', [0.02, 0.02]);
    % 设置坐标轴宽度为1.5
    set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
    set(gca, 'FontName', 'Arial', 'FontSize', 17);
 end



subplot(2,1,2)
 for i=1:3
%     style = styles{mod(i, length(styles)) + 1}; % Cycle through line styles
%     marker = markers{mod(i, length(markers)) + 1}; % Cycle through markers
    plot(D(i).x,D(i).y,'color',c(i,:),'LineWidth',2.5,'LineStyle', styles{i})
    hold on
    box off;
    % 设置刻度线为外部显示
    set(gca, 'TickDir', 'out');  
    % 设置刻度线长度为0.02
    set(gca, 'TickLength', [0.02, 0.02]);
    % 设置坐标轴宽度为1.5
    set(gca, 'LineWidth', 1.5);
    % 更改字体样式和大小
    set(gca, 'FontName', 'Arial', 'FontSize', 17);
 end

 


