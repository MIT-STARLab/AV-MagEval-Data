refDat = table2array(readtable('ref7.csv'));
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

testDat = table2array(readtable('data7.csv'));
testTimes=testDat(:,1);
testStart=testTimes(1);
testStop=testTimes(end);


start=max(testStart,refStart);
stop=min(testStop,refStop);

testTimes=testTimes-start;
refTimes=refTimes-start;
stop=stop-start;
start=0;

ts=start:0.25:stop;

test=interp1(testTimes,testDat,ts);
ref=interp1(refTimes,refDat,ts);

marked=[1];
%Clean the moving portion of the steps to avoid the timing errors
%Find the parts that need to be cleaned
for i=1:length(test)-1
    if abs(test(i,4)-test(i+1,4))>0.1
        if marked(end)==i
            marked = [marked i+1];
        else
            marked = [marked i i+1];
        end
    end
end
%Remove the marked indices
test(marked,:)=[];
ref(marked,:)=[];
ts(marked)=[];

out=[ref(:,1:4), test(:,2:4), test(:,12)];

