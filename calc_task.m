function [ task2 ] = calc_task( field, robot )
%UNTITLED この関数の概要をここに記述
%   詳細説明をここに記述

% 掃引回数0のセルを抽出し，距離をもとにソート
task = [];
for i=1:size(field.cover, 1)
    for j=1:size(field.cover, 2)
        if field.cover(i, j) < 1
            x = j/2 - 0.25;
            y = i/2 - 0.25;
            d = sqrt((robot.x - x).^2 + (robot.y - y).^2);
            if 0.5 < x && x <= 9.5
                if 0.5 < y && y <= 9.5
                    task = [task; [d x y 0]];
                end
            end
        end
    end
end
task = sortrows(task);
task = task(:, [2:4]);
%task2 = task;



% クラスタリング（一列ごと）
task1 = task;
task1(1, 3) = 1;
n = 1;
for i=1:size(task1, 1)
    for j=1:size(task1, 1)
        if task1(i, 1)-0.5 <= task1(j, 1) && task1(j, 1) <= task1(i, 1)+0.5
            if task1(i, 2) == task1(j, 2)
                if task1(i, 3) == 0
                    n = n + 1;
                    task1(i, 3) = n;
                end
                task1(j, 3) = task1(i, 3);
            end
        end
    end
end
task1 = sortrows(task1, 3);

% 端のものだけ残す
task2 = task1(1, :);
n = 1;
for i=1:size(task1, 1)-1
    if task1(i+1, 3) == n+1
        task2 = [task2; task1(i, :); task1(i+1, :)];
        n = n + 1;
    end
end
task2 = [task2; task1(size(task1, 1), :)];


% ヒートマップ作成
data = zeros(20, 20);
for n=1:size(task1, 1)
    i = fix(2 * task1(n, 1));
    j = fix(2 * task1(n, 2));
    data(j+1, i+1) = data(j+1, i+1) + task1(n, 3);
end

figure;
hold on;
colormap jet;
imagesc([0 10], [0 10], data, [0 10]);
axis([0 10 0 10]);
set(gca,'YDir','normal');
colorbar




end


