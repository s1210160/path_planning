close all;
clear all;

% ガウス分布の設定
mu = 0;
sigma = 10.0 * pi / 180;
R = chol(sigma);

% セル幅
cell_w = 1/2; % [m]

% ターゲットの設定
target1 = setTarget_hor(cell_w);      % 水平パラレル動作
target2 = setTarget_vert(cell_w);     % 鉛直パラレル動作
target3 = setTarget_vert(cell_w);
target = target1;               % ターゲット設定
n = 1;                          % ターゲット番号

% ヒートマップ用配列の初期化
field.cover = zeros(20, 20);    % 掃引回数
field.env = zeros(20, 20);     % 環境負荷
field.pass = zeros(100, 100);   % 通過時間

% ロボットの初期姿勢
robot.x = 0.25;         % x軸座標
robot.y = 0.75;         % y軸座標
robot.theta = 0.0;     % 方角
% 一時刻前のロボットの位置情報
pre_robot.x = robot.x;
pre_robot.y = 0.0;
% ロボットのサイズ
r = 0.15;
B = 0.3;

% 基本となるプロット
base_plot(target1, target1, cell_w);
% アニメーション化されたラインの作成
h = animatedline('Color', 'k', 'LineStyle', '-', 'LineWidth', 2.0);

% ストップウォッチ開始
time1 = 0;

%--------------------------ループ---------------------------%
while(1)
    
    % 時間の更新（処理速度：1Hz）
    time1 = time1 + 1;
    
    %-----------------終了条件-------------------%
    % 最後まで訪問した
    if n > size(target, 1)
        if target == target3
            break;
        else
            n = 1;
            target3 = calc_task(field, robot);
            target = target3;   % ターゲットの更新
            
            % 一周目完了したときの結果プロット
            result_heatmap(field);

        end
    end
    
   %　領域外に出た
    if 10 < robot.x || robot.x < 0
        break;
    end
    if 10 < robot.y || robot.y < 0
        break;
    end
    %---------------------------------------------%
    
    % ガウス分布の乱数生成
    noise_L = repmat(mu, 1) + randn(1) * R;
    noise_R = repmat(mu, 1) + randn(1) * R;
    %noise_L = 0;
    %noise_R = 0;
    
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
            
            
            if target == target3
                target(1, :) = [];
                
                if size(target, 1) == 0
                    break;
                end
                
                
                if size(target, 1) < 2
                    target3 = target;
                elseif target(1, 3) == target(2, 3)
                    target3 = update_task(target, robot);
                else
                    target3 = target;
                end
                target = target3;
                n = 1;
            end
            
        end
    end
    
    % アニメーション
    addpoints(h, robot.x, robot.y);
    if target == target3
    drawnow;
    end
    %plot(robot.x, robot.y, 'b*');
end
%--------------------------ループ終了-------------------------%

% 結果プロット
result_heatmap(field);

% 経過時間[min]
while_time = time1 / 60;

file_writer(field);

result = visit_count(field)

sum(rice_effect(:))
