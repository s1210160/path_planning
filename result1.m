close all;
clear all;

filename1 = 'result1.csv';
filename2 = 'result2.csv';
filename3 = 'result3.csv';
data1 = csvread(filename1);
data2 = csvread(filename2);
data3 = csvread(filename3);

x = [0:0.01:3];
    figure('Name', 'mu=0, sigma=0.5', 'NumberTitle', 'off');
    hold on;
    grid on;
    for i=1:10
        norm1 = normpdf(x, data1(i, 1), data1(i, 2));
        norm2 = normpdf(x, data2(i, 1), data2(i, 2));
        norm3 = normpdf(x, data3(i, 1), data3(i, 2));
        plot(x, norm1/324, 'r');
        plot(x, norm2/324, 'b');
        plot(x, norm3/324, 'g');
    end
    axis([0 3 0 0.15]);
    
    figure('Name', 'mu=0, sigma=1.0', 'NumberTitle', 'off');
    hold on;
    grid on;
    for i=1:10
        norm1 = normpdf(x, data1(i, 4), data1(i, 5));
        norm2 = normpdf(x, data2(i, 4), data2(i, 5));
        norm3 = normpdf(x, data3(i, 4), data3(i, 5));
        plot(x, norm1/324, 'r');
        plot(x, norm2/324, 'b');
        plot(x, norm3/324, 'g');
    end
    axis([0 3 0 0.15]);
    
    figure('Name', 'mu=0, sigma=1.5', 'NumberTitle', 'off');
    hold on;
    grid on;
    for i=1:10
        norm1 = normpdf(x, data1(i, 7), data1(i, 8));
        norm2 = normpdf(x, data2(i, 7), data2(i, 8));
        norm3 = normpdf(x, data3(i, 7), data3(i, 8));
        plot(x, norm1/324, 'r');
        plot(x, norm2/324, 'b');
        plot(x, norm3/324, 'g');
    end
    axis([0 3 0 0.15]);
    
    figure('Name', 'mu=0, sigma=2.0', 'NumberTitle', 'off');
    hold on;
    grid on;
    for i=1:10
        norm1 = normpdf(x, data1(i, 10), data1(i, 11));
        norm2 = normpdf(x, data2(i, 10), data2(i, 11));
        norm3 = normpdf(x, data3(i, 10), data3(i, 11));
        plot(x, norm1/324, 'r');
        plot(x, norm2/324, 'b');
        plot(x, norm3/324, 'g');
    end
    axis([0 3 0 0.15]);
    
    figure('Name', 'mu=0, sigma=2.5', 'NumberTitle', 'off');
    hold on;
    grid on;
    for i=1:10
        norm1 = normpdf(x, data1(i, 13), data1(i, 14));
        norm2 = normpdf(x, data2(i, 13), data2(i, 14));
        norm3 = normpdf(x, data3(i, 13), data3(i, 14));
        plot(x, norm1/324, 'r');
        plot(x, norm2/324, 'b');
        plot(x, norm3/324, 'g');
    end
    axis([0 3 0 0.15]);
    
    figure('Name', 'mu=0, sigma=3.0', 'NumberTitle', 'off');
    hold on;
    grid on;
    for i=1:10
        norm1 = normpdf(x, data1(i, 16), data1(i, 17));
        norm2 = normpdf(x, data2(i, 16), data2(i, 17));
        norm3 = normpdf(x, data3(i, 16), data3(i, 17));
        plot(x, norm1/324, 'r');
        plot(x, norm2/324, 'b');
        plot(x, norm3/324, 'g');
    end
    axis([0 3 0 0.15]);
    
    ave1 = []; ave2 = []; ave3 = [];
    figure;
    hold on;
    for i=1:3:18
        ave1 = [ave1; data1(:, i)];
        ave2 = [ave2; data2(:, i)];
        ave3 = [ave3; data3(:, i)];
    end
    plot(sort(ave1), 'r');
    plot(sort(ave2), 'b');
    plot(sort(ave3), 'g');
    
    sigma1 = []; sigma2 = []; sigma3 = [];
    figure;
    hold on;
    for i=2:3:18
        sigma1 = [sigma1; data1(:, i)];
        sigma2 = [sigma2; data2(:, i)];
        sigma3 = [sigma3; data3(:, i)];
    end
    plot(sort(sigma1), 'r');
    plot(sort(sigma2), 'b');
    plot(sort(sigma3), 'g');
    