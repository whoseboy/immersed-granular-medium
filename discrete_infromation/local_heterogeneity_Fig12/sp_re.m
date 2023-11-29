function [D]=sp_re(p,vo,s,R,h,nh,nl)


for i=1:nh
     for j=1:nl
         rs=vecnorm(p-s(i).p(j,:),2,2);
         D(i).h(j).f=vo(rs<=R);
         D(i).h(j).h=histogram(D(i).h(j).f,'Normalization','probability');
         D(i).h(j).h.BinWidth = h;
         D(i).h(j).y=D(i).h(j).h.Values';
         a=D(i).h(j).h.BinEdges';
         deltx=a(2)-a(1);
         D(i).h(j).x=a(1:(length(a)-1))+deltx/2;
         D(i).h(j).z=0.04+0.02*i.*ones(length(D(i).h(j).y),1);
     end
end
end