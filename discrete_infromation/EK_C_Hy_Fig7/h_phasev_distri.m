function [D]=h_phasev_distri(ft,hl,cl,h,nh,nl)


for i=1:nh
     D(i).hf=ft(hl==i);
     D(i).cl=cl(hl==i);
     cll=D(i).cl;
     hf=D(i).hf;
     for j=1:nl
%          l=find(cll==j);
         D(i).h(j).f=hf(cll==j);
         D(i).h(j).h=histogram(D(i).h(j).f,'Normalization','probability');
         D(i).h(j).h.BinWidth = h;
         D(i).h(j).y=D(i).h(j).h.Values';
         a=D(i).h(j).h.BinEdges';
         deltx=a(2)-a(1);
         D(i).h(j).x=a(1:(length(a)-1))+deltx/2;
         D(i).h(j).z=0.05*i.*ones(length(D(i).h(j).y),1);
     end
end
end