function [] = init(target1, target2)
%UNTITLED3 この関数の概要をここに記述
%   詳細説明をここに記述


% 水田のプロット
figure;
hold on;
% ターゲットのプロット
plot(target1(:, 1), target1(:, 2), 'rx');
plot(target2(:, 1), target2(:, 2), 'rx');
axis([0 10 0 10]);
grid on;
ax = gca;
ax.GridAlpha = 0.5;
ax.LineWidth = 1.0;
ax.XTick = (0:0.5:10);
ax.YTick = (0:0.5:10);


end

