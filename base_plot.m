function [ax] = base_plot(target, w)
%UNTITLED3 この関数の概要をここに記述
%   詳細説明をここに記述


% 水田のプロット
figure;
hold on;
% ターゲットのプロット
plot(target(:, 1), target(:, 2), 'bx');
axis([0 10 0 10]);
grid on;
ax = gca;
ax.GridAlpha = 0.5;
ax.LineWidth = 1.0;
ax.XTick = (0:w:10);
ax.YTick = (0:w:10);


end

