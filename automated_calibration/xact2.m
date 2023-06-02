%Implementation of one axis calibration equation with offset prior to
%multiplication

function x = xact2(b,m)
    S=b(1:3);
    Ks=b(4:6);
    Xo=b(7);
    Xko=b(8);
    
    x=zeros(length(m),1);
    for i = 1:length(m)
        Bm=m(i,1:3);
        T=m(i,4);
        Bm2 = Bm+Xo+Xko*T;
        x(i)=dot(S,Bm2)+dot(Ks,Bm2)*T;
    end
end