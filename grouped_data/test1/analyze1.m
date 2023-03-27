

myDat = table2array(readtable('ref1.csv'));

times=myDat(:,1);
times=times-times(1);

dT=zeros(length(times)-1,1);
for i=1:length(dT)
    dT(i)=times(i+1)-times(i);
end

figure(1)
plot(times(1:end-1),dT)
title("Sample Period Variation")

figure(2)
plot(times,myDat(:,3));
hold on
plot(times,myDat(:,2));
plot(times,myDat(:,4).*-1);
legend("X","Y","Z");
title("Reference Field")
xlabel("Time")
ylabel("Field (uT)")
