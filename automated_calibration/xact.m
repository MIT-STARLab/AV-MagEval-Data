%Implementation of one axis calibration equation

function x = xact(b,m)
    S=b(1:3);
    Ks=b(4:6);
    Xo=b(7);
    Xko=b(8);
    
    x=zeros(length(m),1);
    for i = 1:length(m)
        Bm=m(i,1:3);
        T=m(i,4);
        x(i)=dot(S,Bm)+dot(Ks,Bm)*T+Xo+Xko*T;
    end
end