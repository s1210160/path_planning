close all;
clear all;

file_env = 'env.csv';
file_cover = 'cover.csv';
file_pass = 'pass.csv';
field.env = csvread(file_env, 0, 0, [0 0 19 19]);
field.cover = csvread(file_cover, 0, 0, [0 0 19 19]);
field.pass = csvread(file_pass, 0, 0, [0 0 99 99]);

result_heatmap(field);

% ガウス分布の設定
mu = 0;
sigma = 3.0;
R = chol(sigma);

cell_w = 1/2;

% ロボットの初期姿勢
robot.x = 0.25;         % x軸座標
robot.y = 9.5;         % y軸座標
robot.theta = 0.0;     % 方角
% 一時刻前のロボットの位置情報
pre_robot.x = robot.x;
pre_robot.y = 9.75;
% ロボットのサイズ
r = 0.15;
B = 0.3;

target = calc_task(field, robot)

% 基本となるプロット
base_plot(target, target, cell_w);
% アニメーション化されたラインの作成
h = animatedline('Color', 'k', 'LineStyle', '-', 'LineWidth', 2.0);

n = 1;
tic;
while(1)
    
    if n > size(target, 1)
        break;
    end
    
    %　領域外に出た
    if 10 < robot.x || robot.x < 0
        break;
    end
    if 10 < robot.y || robot.y < 0
        break;
    end
    
     % ガウス分布の乱数生成
    noise_L = repmat(mu, 1) + randn(1) * R;
    noise_R = repmat(mu, 1) + randn(1) * R;
    
     %---------------------制御--------------------%
    % 次に向かうターゲットのある方向
    angle = calc_angle(target(n,:), robot, pre_robot);
    
    % 速度，回転速度，環境負荷
    [V, omega, rice_effect] = control(angle, noise_L, noise_R, r, B);
    
    V;
    
    % 一時刻前のロボットの位置情報の更新
    pre_robot.x = robot.x;
    pre_robot.y = robot.y;

    robot.theta = robot.theta + omega;
    robot.x = robot.x + V * cos(robot.theta);
    robot.y = robot.y + V * sin(robot.theta);
    
    % アニメーション
    addpoints(h, robot.x, robot.y);
    %drawnow;

    %---------------------------------------------%
    
    % -----------ヒートマップ用配列の更新----------%
    i = fix(2 * robot.x);
    j = fix(2 * robot.y);
    if fix(2 * pre_robot.x) ~= i || fix(2 * pre_robot.y) ~= j
        % 訪問回数の更新
        field.cover(j+1, i+1) = field.cover(j+1, i+1) + 1;
    end
    % 訪問時間の更新
    field.env(j+1, i+1) = field.env(j+1, i+1) + rice_effect;
    
    i = round(size(field.pass, 1) / 10 *robot.x, 0);
    j = round(size(field.pass, 1) / 10 *robot.y, 0);
    if round(pre_robot.x, 1) ~= i || round(pre_robot.y, 1) ~= j 
        for k=-1:1
            for l=-1:1
                if 0 < j+k && j+k < 100
                    if 0 < i+l && i+l < 100
                        % 通過回数の更新
                        field.pass(j+k, i+l) = field.pass(j+k, i+l) + 1;
                    end
                end
            end
        end
    end
    %---------------------------------------------%

    
    % ターゲットの更新
    if target(n,1)-cell_w/2 < robot.x && robot.x <= target(n,1)+cell_w/2
        if target(n,2)-cell_w/2 < robot.y && robot.y <= target(n,2)+cell_w/2
            % ターゲット番号の更新
            
            n = n + 1;
            %{
            target(1, :) = [];
            
            if size(target, 1) == 0
                break;
            end
            
            
            if size(target, 1) < 2
            elseif target(1, 3) == target(2, 3)
                target = update_task(target, robot)
            end
            %}
            
            %target = update_task(target, robot);
        end
    end
    
end

result = visit_count(field)
while_time = toc
max(field.env(:))

% 結果プロット
result_heatmap(field);
