function [D]=phasev_distri(ft,cl,h,n)


for i=1:n
    D(i).f=ft(cl==i);
    D(i).h=histogram(D(i).f,'Normalization','probability');
    D(i).h.BinWidth = h;
    D(i).y=D(i).h.Values';
    a=D(i).h.BinEdges';
    deltx=a(2)-a(1);
    D(i).x=a(1:(length(a)-1))+deltx/2;
end


end