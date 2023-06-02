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

mdl=@xact;

Xmdl=fitnlm(testDat,Xref,mdl,beta0);
Ymdl=fitnlm(testDat,Yref,mdl,beta0);
Zmdl=fitnlm(testDat,Zref,mdl,beta0);

coeffs = [ Xmdl.Coefficients.Estimate Ymdl.Coefficients.Estimate Zmdl.Coefficients.Estimate]'

