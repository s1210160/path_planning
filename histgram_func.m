function [ output_args ] = histgram_func( name, data1, data2, data3, a )
%UNTITLED5 この関数の概要をここに記述
%   詳細説明をここに記述

rate = [];
figure('Name', name, 'NumberTitle', 'off');
hold on;
axis([0 100 0 31]);
for i=1:10
   rate = [rate; data1(i, [a:a+7]) / 324];
end
for i=1:10
   rate = [rate; data2(i, [a:a+7]) / 324];
end
for i=1:10
   rate = [rate; data3(i, [a:a+7]) / 324];
end
h = barh(100*rate, 'stacked');
set(h(1), 'FaceColor', [0 0 255/255]);
set(h(2), 'FaceColor', [127/255 0 255/255]);
set(h(3), 'FaceColor', [255/255 0 191/255]);
set(h(4), 'FaceColor', [255/255 0 63/255]);
set(h(5), 'FaceColor', [255/255 127/255 0]);
set(h(6), 'FaceColor', [191/255 255/255 0]);
set(h(7), 'FaceColor', [0 255/255 0]);

end

