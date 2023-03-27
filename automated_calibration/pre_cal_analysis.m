%Nicholas Belsten
%Created 1/10/2023

%This script computes the rms error of all the data collected during the
%evaluation of the MagEval HMC1053 accuracy

full_dat = table2array(readtable('full_data.csv'));

ref = full_dat(:,2:4);
test = full_dat(:,5:7);

vec_diff = ref-test;

RMSE = rms(vec_diff,1)

norm_RMSE = norm(RMSE)