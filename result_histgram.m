close all;
clear all;

filename1 = 'result1_histgram.csv';
filename2 = 'result2_histgram.csv';
filename3 = 'result3_histgram.csv';
data1 = csvread(filename1);
data2 = csvread(filename2);
data3 = csvread(filename3);


histgram_func('mu=0, sigma=0.5', data1, data2, data3, 1);
histgram_func('mu=0, sigma=1.0', data1, data2, data3, 10);
histgram_func('mu=0, sigma=1.5', data1, data2, data3, 19);
histgram_func('mu=0, sigma=2.0', data1, data2, data3, 28);
histgram_func('mu=0, sigma=2.5', data1, data2, data3, 37);
histgram_func('mu=0, sigma=3.0', data1, data2, data3, 46);

