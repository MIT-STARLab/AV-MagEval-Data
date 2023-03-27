%Uses non-linear regression on large dataset to extract calibration
%coefficients

data=table2array(readtable('full_data'));
Xref=data(:,2);
Yref=data(:,3);
Zref=data(:,4);

data(:,8)=data(:,8)-273.15;

testDat=data(:,5:8); %Predictors
beta0=zeros(1,8);
%beta0(1)=1;

Xmdl=fitnlm(testDat,Xref,@xact,beta0);
Ymdl=fitnlm(testDat,Yref,@xact,beta0);
Zmdl=fitnlm(testDat,Zref,@xact,beta0);

norm_RMSE = norm([Xmdl.RMSE,Ymdl.RMSE,Zmdl.RMSE,])