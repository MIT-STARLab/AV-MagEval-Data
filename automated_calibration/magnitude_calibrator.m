%Tests using the reference field as a predictor and fitting on the test
%field
%This is not used in the EGUsphere paper as the results are not as good as
%when fitting on the reference magnetic field

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
beta0=zeros(1,24); %These are the fit parameters, sensitivity Sx Sy Sz, Ksz Ksy Ksz O K0
beta0(1)=1;
beta0(5)=1;
beta0(9)=1; %Start with identity sensitivity matrix

my_mdl=fitnlm([refData, TempData],vecnorm(testData,2,2), @magact, beta0);

b = my_mdl.Coefficients.Estimate


Bpred = zeros(length(data),3);
for i = 1:length(data) %For each point in time
    Bmes = testData(i);
    T=TempData(i);
    Bpred(i,:) = (S+Ks*T)\(Bmes-(O-Ko*T))';
end

diff = Bpred - testData;
