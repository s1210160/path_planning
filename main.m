close all;
clear all;

% ガウス分布の設定
mu = 0;
sigma = 0.8;
R = chol(sigma);

% ターゲットの設定
target1 = setTarget_hor();      % 水平パラレル動作
target2 = setTarget_vert();     % 鉛直パラレル動作
target = target1;               % ターゲット設定
n = 1;                          % ターゲット番号

% ヒートマップ用配列の初期化
field.cover = zeros(20, 20);    % 掃引回数
field.time = zeros(20, 20);     % 掃引時間
field.pass = zeros(100, 100);   % 通過時間

% ロボットの初期姿勢
robot.x = 0.25;         % x軸座標
robot.y = 0.75;         % y軸座標
robot.theta = 0.0;      % 方角
% 一時刻前のロボットの位置情報
pre_robot.x = robot.x;
pre_robot.y = 0.0;
% ロボットのサイズ
r = 0.03;               % 車輪半径[m]
B = 0.06;

%i=1; j=1;
% 旋回回数
turn_cnt = 0;
% 前進回数
straight_cnt = 0;

% 基本となるプロット
base_plot(target1, target2);
% アニメーション化されたラインの作成
h = animatedline('Color', 'k', 'LineStyle', '-', 'LineWidth', 2.0);

% ストップウォッチ開始
time1 = 0;
time2 = 0;

%--------------------------ループ---------------------------%
while(1)
    
    % 時間の更新（処理速度：1Hz）
    time1 = time1 + 1;
    time2 = time2 + 1;
    
    %-----------------終了条件-------------------%
    % 最後まで訪問した
    if n > size(target, 1)
        if target == target2
            break;
        else
            n = 1;
            target = target2;   % ターゲットの更新
            
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
    
    % 速度と回転速度
    [turn, straight, V, omega] = control(angle, noise_L, noise_R, r, B);
    turn_cnt = turn_cnt + turn;
    straight_cnt = straight_cnt + straight;  
  
    V;
    
    % 一時刻前のロボットの位置情報の更新
    pre_robot.x = robot.x;
    pre_robot.y = robot.y;

    robot.theta = robot.theta + omega * 2;
    robot.x = robot.x + V * cos(robot.theta * pi / 180);
    robot.y = robot.y + V * sin(robot.theta * pi / 180);
    
    %---------------------------------------------%
    
    % ターゲットの更新
    if target(n,1)-0.25 < robot.x && robot.x <= target(n,1)+0.25
        if target(n,2)-0.25 < robot.y && robot.y <= target(n,2)+0.25
            % ターゲット番号の更新
            n = n + 1;            
        end
    end
    
    % -----------ヒートマップ用配列の更新----------%
    i = fix(2 * robot.x);
    j = fix(2 * robot.y);
    if fix(2*pre_robot.x) ~= i || fix(2*pre_robot.y) ~= j
        % 訪問回数の更新
        field.cover(j+1, i+1) = field.cover(j+1, i+1) + 1;
        % 訪問時間の更新
        field.time(j+1, i+1) = field.time(j+1, i+1) + time2;
        time2 = 0;
    end
    
    i = 10 * round(robot.x, 1);
    j = 10 * round(robot.y, 1);
    if round(pre_robot.x, 1) ~= i || round(pre_robot.y, 1) ~= j 
        for k=-2:2
            for l=-2:2
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
    
    % アニメーション
    addpoints(h, robot.x, robot.y);
    %drawnow;
end
%--------------------------ループ終了-------------------------%

% 結果プロット
result_heatmap(field);

% 経過時間[min]
while_time = time1 / 60;
% 旋回率
turn_rate = turn_cnt / (turn_cnt + straight_cnt);   

% 評価値の算出
grade = 0;
for i=1: max(round(field.time(:), 1)) * 10 + 1
    A = round(field.time, 1) == (i-1)/10;
    time_rate(i) = sum(A(:)) / (size(field.time, 1) * size(field.time, 2));
    grade = grade + time_rate(i) * (i-1);
end

% 未掃引セルの算出
for i=1:20
    for j=1:20
        if field.cover(i, j) == 0
            x = i/2 - 0.25;
            y = j/2 - 0.25;
        end
    end
end
