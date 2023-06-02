%Tests using the rearranged measurement equation such that temperature
%effects are applied prior to formulation with Bact as the dependent
%variables
%This is not used in the EGUsphere paper as the results are not as good as
%when fitting each vector separately on the reference magnetic field

%Uses non-linear regression on large dataset to extract calibration
%coefficients


data=table2array(readtable('full_data'));

refData = data(:,2:4); %x,y,z in columns 
testData = data(:,5:7); 
TempData = data(:,8)-273.15; %temperature in C


Xref=data(:,2);
Yref=data(:,3);
Zref=data(:,4);

data(:,8)=data(:,8)-273.15;

testDat=data(:,5:8); %Predictors
beta0=zeros(1,8); %These are the fit parameters, sensitivity Sx Sy Sz, Ksz Ksy Ksz O K0
%beta0(1)=1;

%
mdl=@xact;

Xmdl=fitnlm([refData, TempData],testData(:,1), mdl, beta0);
Ymdl=fitnlm([refData, TempData],testData(:,2), mdl, beta0);
Zmdl=fitnlm([refData, TempData],testData(:,3), mdl, beta0);


coeffs = [ Xmdl.Coefficients.Estimate Ymdl.Coefficients.Estimate Zmdl.Coefficients.Estimate]'

norm_RMSE = norm([Xmdl.RMSE,Ymdl.RMSE,Zmdl.RMSE,])

S = coeffs(:,1:3);
Ks = coeffs(:,4:6);
O = coeffs(:,7);
Ko = coeffs(:,8);

Bpred = zeros(length(data),3);
for i = 1:length(data) %For each point in time
    Bmes = testData(i);
    T=TempData(i);
    Bpred(i,:) = (S+Ks*T)\(Bmes-(O-Ko*T));
end

diff = Bpred - refData;
