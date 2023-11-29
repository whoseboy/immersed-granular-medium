function pl=sp_re1(p,p_in,R,vo,ns,hh)

mvo=zeros(ns,1);
voR=zeros(ns,1);
for i=1:ns
    r=vecnorm(p-p_in(i,:),2,2);
    d(i).vo=vo(r<=R);
    d(i).mvo=mean(d(i).vo);
    d(i).voR=std(d(i).vo);
    mvo(i)=d(i).mvo;
    voR(i)=d(i).voR;
end

voR1=voR(mvo>=0.05);
p_in1=p_in(mvo>=0.05,:);
voR2=voR1(p_in1(:,2)>=0.05);

pl.vo=voR2;
h=histogram(voR2,'Normalization','probability');
h.BinWidth = hh;
pl.y=h.Values';
a=h.BinEdges';
deltx=a(2)-a(1);
pl.x=a(1:(length(a)-1))+deltx/2;
end
