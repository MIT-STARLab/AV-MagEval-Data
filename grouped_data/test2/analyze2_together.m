myDat = table2array(readtable('data0.csv'));

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
hold on
plot(times,myDat(:,2),'r-');
plot(times,myDat(:,3),'g-');
plot(times,myDat(:,4),'b-');

plot(times,myDat(:,5),'r:');
plot(times,myDat(:,6),'g:');
plot(times,myDat(:,7),'b:');

plot(times,myDat(:,8),'r--');
plot(times,myDat(:,9),'g--');
plot(times,myDat(:,10),'b--');

title("Magnetic Measurements");

legend("X - Test","Y - Test","Z - Test","X - Ref1","Y - Ref1","Z - Ref1","X - Ref2","Y - Ref2","Z - Ref2");

xlabel("Time")
ylabel("Field (uT)")
hold off

figure(5)
plot(times,myDat(:,11));
hold on
plot(times,myDat(:,12));
legend("T1-Near Pi","T2 - Away from Pi");
title("Board Temperatures")
xlabel("Time")
ylabel("T (K)")
hold off
