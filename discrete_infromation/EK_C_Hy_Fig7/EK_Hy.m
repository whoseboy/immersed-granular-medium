clear 


load da.mat

load dad.mat


n=length(da);

np=800;
nph=8;

for i=1:n
    da(i).cl=(i-nph*floor(i/8)).*ones(np,1);
    if da(i).cl==0
        da(i).cl=nph.*ones(np,1);
    end
end





for i=1:n
    da(i).hl(da(i).p(:,2)<=0.05)=1;
    dad(i).hl(dad(i).image(:,17)<=0.05)=1;
    da(i).hl(da(i).p(:,2)>0.05&da(i).p(:,2)<=0.1)=2;
    dad(i).hl(dad(i).image(:,17)>0.05&dad(i).image(:,17)<=0.1)=2;
    da(i).hl(da(i).p(:,2)>0.1&da(i).p(:,2)<=0.15)=3;
    dad(i).hl(dad(i).image(:,17)>0.1&dad(i).image(:,17)<=0.15)=3;
    dad(i).hl(dad(i).image(:,17)>0.15)=4;
end

var=[da(1).image(:,6:8) da(1).vo];
vard=[dad(1).image(:,6:8) dad(1).vo];
cl=da(1).cl;
hl=da(1).hl';
hdl=dad(1).hl';

for i=2:n
    var=[var;[da(i).image(:,6:8) da(i).vo]];
    vard=[vard;[dad(i).image(:,6:8) dad(i).vo]];
    cl=[cl;da(i).cl];
    hl=[hl;da(i).hl'];
    hdl=[hdl;dad(i).hl'];
end

A=0.01; %vibrtation amplitude
F=50; %vibrtation amplitude

ep=0.5.*(vecnorm(var(:,1:3),2,2).^2)./(A^2*F^2);
edp=0.5.*(vecnorm(vard(:,1:3),2,2).^2)./(A^2*F^2);



nl=8;
nh=3;
ndh=4;

E=h_phasev_distri(log(ep),hl,cl,0.1,nh,nl);
Ed=h_phasev_distri(log(edp),hdl,cl,0.1,ndh,nl);

Vo=h_phasev_distri(var(:,4),hl,cl,0.01,nh,nl);
Vod=h_phasev_distri(vard(:,4),hdl,cl,0.01,ndh,nl);

c=[62 43 109; 240 100 73; 255 170 50; 48 151 164; 5 80 91]./255;

flist=[1;2;5;7;8];

figure()
subplot(2,2,1)

for i=1:ndh
    
    for j=1:length(flist)

    plot3(Ed(i).h(flist(j)).z/0.01,Ed(i).h(flist(j)).x,Ed(i).h(flist(j)).y,'color',c(j,:),'LineWidth',2.5)
    hold on
        % 取消图形边框
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
for i=1:nh
    
    for j=1:length(flist)

    plot3(E(i).h(flist(j)).z/0.01,E(i).h(flist(j)).x,E(i).h(flist(j)).y,'color',c(j,:),'LineWidth',2.5)
    hold on
    % 取消图形边框
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
for i=1:ndh
    
    for j=1:length(flist)

    plot3(Vod(i).h(flist(j)).z/0.01,Vod(i).h(flist(j)).x,Vod(i).h(flist(j)).y,'color',c(j,:),'LineWidth',2.5)
    hold on
        % 取消图形边框
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

subplot(2,2,4)
for i=1:nh
    
    for j=1:length(flist)

    plot3(Vo(i).h(flist(j)).z/0.01,Vo(i).h(flist(j)).x,Vo(i).h(flist(j)).y,'color',c(j,:),'LineWidth',2.5)
    hold on
        % 取消图形边框
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





