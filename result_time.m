close all;
clear all;

filename1 = 'result1_time.csv';
filename2 = 'result2_time.csv';
filename3 = 'result3_time.csv';
data1 = csvread(filename1);
data2 = csvread(filename2);
data3 = csvread(filename3);


time1 = []; time2 = []; time3 = [];
figure;
hold on;
for i=1:2:14
    time1 = [time1; data1(:, i)];
end
for i=1:2:12
    time2 = [time2; data2(:, i)];
    time3 = [time3; data3(:, i)];
end
plot(sort(time1), 'r');
plot(sort(time2), 'b');
plot(sort(time3), 'g');