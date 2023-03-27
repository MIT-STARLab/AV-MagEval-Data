dat3 = table2array(readtable('../grouped_data/test3/out_data.csv'));
dat4 = table2array(readtable('../grouped_data/test4/out_data.csv'));
dat5 = table2array(readtable('../grouped_data/test5/out_data.csv'));
dat6 = table2array(readtable('../grouped_data/test6/out_data.csv'));
dat7 = table2array(readtable('../grouped_data/test7/out_data.csv'));
dat8 = table2array(readtable('../grouped_data/test8/out_data.csv'));

full_dat = [dat3;dat4;dat5;dat6;dat7;dat8];

dlmwrite("full_data.csv",full_dat,'precision',15);