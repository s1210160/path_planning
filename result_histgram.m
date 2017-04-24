close all;
clear all;

filename = 'result_cover_allcell.csv';
data = csvread(filename);

for i=1:10
data_1(i, :) = mean(data(i, [1:7]));
data_2(1, :) = mean(data(i, [9:15]));
end

for i=1:size(data_1, 1)
    data_1(i, :) = data_1(i, :) / sum(data_1(i, :));
    data_2(i, :) = data_2(i, :) / sum(data_2(i, :));
end


figure('Name', 'ˆêŽü–Ú', 'NumberTitle', 'off');
hold on;
axis([0 100 0 4]);
for i=1:10
    h1 = barh(data_1(i) * 100, 'stacked');
end
figure('Name', '“ñŽü–Ú', 'NumberTitle', 'off');
hold on;
axis([0 100 0 4]);
for i=1:10
    h2 = barh(data_2(i) * 100, 'stacked');
end

set(h1(1), 'FaceColor', [0 0 255/255]);
set(h1(2), 'FaceColor', [127/255 0 255/255]);
set(h1(3), 'FaceColor', [255/255 0 191/255]);
set(h1(4), 'FaceColor', [255/255 0 63/255]);
set(h1(5), 'FaceColor', [255/255 127/255 0]);
set(h1(6), 'FaceColor', [191/255 255/255 0]);
set(h1(7), 'FaceColor', [0 255/255 0]);

set(h2(1), 'FaceColor', [0 0 255/255]);
set(h2(2), 'FaceColor', [127/255 0 255/255]);
set(h2(3), 'FaceColor', [255/255 0 191/255]);
set(h2(4), 'FaceColor', [255/255 0 63/255]);
set(h2(5), 'FaceColor', [255/255 127/255 0]);
set(h2(6), 'FaceColor', [191/255 255/255 0]);
set(h2(7), 'FaceColor', [0 255/255 0]);