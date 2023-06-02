%Magnitude fitting

function x = magact(b,m)
    S=[b(1:3);b(4:6);b(7:9)];
    Ks=[b(10:12);b(13:15);b(16:18)];
    O=b(19:21);
    Ko=b(2:4);
    
    x=zeros(length(m),1);
    for i = 1:length(m) %For each point in time
        Bm=m(i,1:3);
        T=m(i,4);
        Bpred = (S+Ks*T)\(Bm-(O-Ko*T))';
        x(i)= norm(Bpred);
    end
end