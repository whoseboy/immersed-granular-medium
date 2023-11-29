clear

load d.mat
% d1.mat is the continous infromation

n=length(d);

x1=linspace(-0.07,0.07,26);
z1=linspace(-0.07,0.07,26);
y1=linspace(0,0.2,35);
[X,Y,Z]=meshgrid(x1,y1,z1);
xa=X(:);
ya=Y(:);
za=Z(:);

p_in=[xa ya za];

v=d(1).svar(:,1:3);
vo=d(1).svar(:,5);

for i=2:n
    
    v=v+d(i).svar(:,1:3);
    vo=vo+d(i).svar(:,5);

end

vm=v./n;
vom=vo./n;

aa1=find(vom>0.02&vecnorm([xa za],2,2)<=0.07&ya>=0.05);


vsxy=vm(:,1:2);

cosalphx=vm(:,1)./vecnorm(vsxy,2,2);

alphx=acos(cosalphx);

cosalphy=vm(:,2)./vecnorm(vsxy,2,2);

alphy=acos(cosalphy);


malphx=reshape(alphx,size(X));
malphy=reshape(alphy,size(X));

mvo=reshape(vom,size(X));

mmvo=mvo(:,:,14);

salphx=malphx(:,:,14);
salphy=malphy(:,:,14);

salphx(isnan(salphx))=0;
salphy(isnan(salphy))=0;

deltx=x1(2)-x1(1);

delty=y1(2)-y1(1);

% calculating the alphax/dy and alphyay/dx
[dx_salphx,dy_salphx] = gradient(salphx,deltx,delty);

[dx_salphy,dy_salphy] = gradient(salphy,deltx,delty);





dy_salphx(mmvo<=0.1)=nan;
dx_salphy(mmvo<=0.1)=nan;





[X1,Y1]=meshgrid(x1,y1);


load map.mat

figure()

subplot(2,1,1)

surf(X1./0.01,Y1./0.01,dy_salphx./180)
colorbar

colormap(map)

subplot(2,1,2)

surf(X1./0.01,Y1./0.01,dx_salphy./180)
colorbar

colormap(map)


% calculating Al and Ar
p_in=[xa ya za];

p=p_in(aa1,:);
v11=vm(aa1,:);

p1=p(p(:,3)>-0.0084&p(:,3)<0.0084,:);
v1=v11(p(:,3)>-0.0084&p(:,3)<0.0084,:);

p2=p1(p1(:,1)<=0,:);
v2=v1(p1(:,1)<=0,:);


p4=p2(:,1:2);
v4=v2(:,1:2);


rv=p4-[-0.048 0.11];

a22=zeros(n11,1);
for i=1:n11
    a22(i)= atan2(det([rv(i,:) ; v4(i,:)]), dot(rv(i,:), v4(i,:)));

end
dddd=vecnorm(v4,2,2).*sin(a22)./vecnorm(rv,2,2)./(50*pi);
roo=mean(dddd);








