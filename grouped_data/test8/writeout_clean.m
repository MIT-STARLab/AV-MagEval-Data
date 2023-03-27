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


out=[ref(:,1:4), test(:,2:4), test(:,12)];

