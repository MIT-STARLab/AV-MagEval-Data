refDat = table2array(readtable('ref8.csv'));
%apply axis conversion
xtemp=refDat(:,3);
ytemp=refDat(:,2);
refDat(:,4)=-refDat(:,4);
refDat(:,2)=xtemp;
refDat(:,3)=ytemp;

deltaT=4*60*60; %Manual time correction

refTimes=refDat(:,1)+deltaT-0.5;
refStart=refTimes(1);
refStop=refTimes(end);

testDat = table2array(readtable('data9.csv'));
testTimes=testDat(:,1);
testStart=testTimes(1);
testStop=testTimes(end);


start=max(testStart,refStart);
stop=min(testStop,refStop);

testTimes=testTimes-start;
refTimes=refTimes-start;
stop=stop-start;
start=75;

ts=start:0.25:stop;

test=interp1(testTimes,testDat,ts);
ref=interp1(refTimes,refDat,ts);


%Apply calibration
test(:,2)=test(:,2).*(-0.1861+0.004372*test(:,12));
test(:,3)=test(:,3)*1.12;
test(:,4)=test(:,4)*1.115;

figure(1)
hold on
plot(ts,test(:,2),'r-');
plot(ts,test(:,3),'g-');
plot(ts,test(:,4),'b-');

plot(ts,ref(:,2),'r--');
plot(ts,ref(:,3),'g--');
plot(ts,ref(:,4),'b--');

legend("X - Test","Y - Test","Z - Test","X - Ref","Y - Ref","Z - Ref");
title("Measurement Comparison");
xlabel("Time (s)");
ylabel("Field (uT)");
hold off

Xdelta=test(:,2)-ref(:,2);
Ydelta=test(:,3)-ref(:,3);
Zdelta=test(:,4)-ref(:,4);

figure(2)
hold on
plot(ts,test(:,2)-mean(Xdelta),'r-');
plot(ts,test(:,3)-mean(Ydelta),'g-');
plot(ts,test(:,4)-mean(Zdelta),'b-');

plot(ts,ref(:,2),'r--');
plot(ts,ref(:,3),'g--');
plot(ts,ref(:,4),'b--');

legend("X - Test","Y - Test","Z - Test","X - Ref","Y - Ref","Z - Ref");
title("Measurement Comparison - Static Error Subtraction");
xlabel("Time (s)");
ylabel("Field (uT)");
hold off


figure(3)
hold on
plot(ts,Xdelta,'r-');
plot(ts,Ydelta,'g-');
plot(ts,Zdelta,'b-');

legend("X","Y","Z");
title("Delta (test-reference)");
xlabel("Time (s)");
ylabel("Field (uT)");
hold off

Xoffset=mean(Xdelta)
Yoffset=mean(Ydelta)
Zoffset=mean(Zdelta)

figure(4)
hold on
plot(ts,Xdelta-Xoffset,'r-');
plot(ts,Ydelta-mean(Ydelta),'g-');
plot(ts,Zdelta-mean(Zdelta),'b-');

legend("X","Y","Z");
title("Delta (test-reference-static offset)");
xlabel("Time (s)");
ylabel("Field (uT)");
hold off


Xsigma=rms(Xdelta-mean(Xdelta))
Ysigma=rms(Ydelta-mean(Ydelta))
Zsigma=rms(Zdelta-mean(Zdelta))

figure(5)
plot(ts,test(:,11));
hold on
plot(ts,test(:,12));
legend("T1-Near Pi","T2 - Away from Pi");
title("Board Temperatures")
xlabel("Time")
ylabel("T (K)")
hold off

