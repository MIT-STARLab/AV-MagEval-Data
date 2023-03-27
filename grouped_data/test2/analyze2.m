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
plot(times,myDat(:,2));
hold on
plot(times,myDat(:,3));
plot(times,myDat(:,4));
legend("X","Y","Z");
title("Test Magnetometer")
xlabel("Time")
ylabel("Field (uT)")
hold off

figure(3)
plot(times,myDat(:,5));
hold on
plot(times,myDat(:,6));
plot(times,myDat(:,7));
legend("X","Y","Z");
title("RM3100 Reference Magnetometer (U7 near Pi)")
xlabel("Time")
ylabel("Field (uT)")
hold off

figure(4)
plot(times,myDat(:,8));
hold on
plot(times,myDat(:,9));
plot(times,myDat(:,10));
legend("X","Y","Z");
title("RM3100 Reference Magnetometer (U9 away from Pi)")
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
