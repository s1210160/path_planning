function [ task1 ] = update_task( target, robot, pre_robot )
%UNTITLED2 この関数の概要をここに記述
%   詳細説明をここに記述

% 距離をもとにソート
task = [];
for i=1:size(target, 1)
    x = target(i, 1);
    y = target(i, 2);
    c = target(i, 3);
    dis = sqrt((robot.x - x).^2 + (robot.y - y).^2);
    angle = calc_angle([x y], robot, pre_robot);
    task = [task; [abs(angle) x y c]];
end
task = sortrows(task)

task1 = task(:, [2:4]);

% グループごとに並び替える
for i=1:2:size(task1, 1)-1
    for j=i+1:size(task1, 1)
        if task1(i, 3) == task1(j, 3)
            a = task1(i+1, :);
            task1(i+1, :) = task1(j, :);
            task1(j, :) = a;
            break;
        end
    end
end


end

