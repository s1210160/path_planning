function [ task ] = calc_task( field, robot, pre_robot, w )
%UNTITLED この関数の概要をここに記述
%   詳細説明をここに記述

px = robot.x;
py = robot.y;

target = [];

w = 1/2;

% 未掃引セルの抽出
task = [];
test = [];

for i=1:size(field.cover, 1)-1
    for j=1:size(field.cover, 2)-1
        flag = 0;
        % 掃引回数が０回であり、かつ掃引領域に含まれる
        if (field.cover(i, j) < 1) && (is_area(i, j, w) == 1)
            flag = flag + 1;
        end
        if (field.cover(i+1, j) < 1) && (is_area(i+1, j, w) == 1)
            flag = flag + 1;
        end
        if (field.cover(i, j+1) < 1) && (is_area(i, j+1, w) == 1)
            flag = flag + 1;
        end
        if (field.cover(i+1, j+1) < 1) && (is_area(i+1, j+1, w) == 1)
            flag = flag + 1;
        end
        %３ブロック以上未掃引セルが連結している
        if flag >= 3
            x = (j - 0.5) * w;
            y = (i - 0.5) * w;
            
            task = [task; [x+0.25 y+0.25]];
        end
    end
end

if size(task) == 0
    return;
end


% グループ化（一列ごと）
task(1, 3) = 1;
n = 1;
for i=1:size(task, 1)
    for j=1:size(task, 1)
        if task(i, 1)-1*w <= task(j, 1) && task(j, 1) <= task(i, 1)+1*w
            % yが等しい
            if task(i, 2) == task(j, 2)
                if task(i, 3) == 0
                    n = n + 1;
                    task(i, 3) = n;
                end
                task(j, 3) = task(i, 3);
            end
        end
    end
end
task = sortrows(task, 3)

% 端のものだけ残す
target = task(1, :);
n = 1;
for i=1:size(task, 1)-1
    if task(i+1, 3) == n+1
        target = [target; task(i, :); task(i+1, :)];
        n = n + 1;
    end
end
target = [target; task(size(task, 1), :)];
task = target;

% ターゲットの順番付け
for i=1:size(task, 1)
    x(i, :) = task(i, 1);
    y(i, :) = task(i, 2);
    c(i, :) = task(i, 3);
    distance(i, :) = sqrt((robot.x - x(i, :)).^2 + (robot.y - y(i, :)).^2);
    angle(i, :) = calc_angle([x(i, :) y(i, :)], robot, pre_robot);
end
angle_rate = abs(angle) / sum(abs(angle));
distance_rate = distance / sum(distance);
target = [0*distance_rate+1*angle_rate x y c];
target = sortrows(target);

task = target(:, [2:4]);
for i=1:2:size(task, 1)-1
    for j=i+1:size(task, 1)
        if task(i, 3) == task(j, 3)
            a = task(i+1, :);
            task(i+1, :) = task(j, :);
            task(j, :) = a;
            break;
        end
    end
end

%{
% ヒートマップ作成
data = zeros(20, 20);
for n=1:size(task, 1)
    i = fix(2 * task(n, 1));
    j = fix(2 * task(n, 2));
    data(j+1, i+1) = data(j+1, i+1) + task(n, 3);
end

figure;
hold on;
colormap jet;
imagesc([0 10], [0 10], data, [0 max(task(:, 3))]);
axis([0 10 0 10]);
set(gca,'YDir','normal');
colorbar
%}

end


