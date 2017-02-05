close all;
clear all;

% �K�E�X���z�̐ݒ�
mu = 0;
sigma = 0.8;
R = chol(sigma);

% �^�[�Q�b�g�̐ݒ�
target1 = setTarget_hor();      % �����p����������
target2 = setTarget_vert();     % �����p����������
target = target1;               % �^�[�Q�b�g�ݒ�
n = 1;                          % �^�[�Q�b�g�ԍ�

% �q�[�g�}�b�v�p�z��̏�����
field.cover = zeros(20, 20);    % �|����
field.time = zeros(20, 20);     % �|������
field.pass = zeros(100, 100);   % �ʉߎ���

% ���{�b�g�̏����p��
robot.x = 0.25;         % x�����W
robot.y = 0.75;         % y�����W
robot.theta = 0.0;      % ���p
% �ꎞ���O�̃��{�b�g�̈ʒu���
pre_robot.x = robot.x;
pre_robot.y = 0.0;
% ���{�b�g�̃T�C�Y
r = 0.03;               % �ԗ֔��a[m]
B = 0.06;

%i=1; j=1;
% �����
turn_cnt = 0;
% �O�i��
straight_cnt = 0;

% ��{�ƂȂ�v���b�g
base_plot(target1, target2);
% �A�j���[�V���������ꂽ���C���̍쐬
h = animatedline('Color', 'k', 'LineStyle', '-', 'LineWidth', 2.0);

% �X�g�b�v�E�H�b�`�J�n
time1 = 0;
time2 = 0;

%--------------------------���[�v---------------------------%
while(1)
    
    % ���Ԃ̍X�V�i�������x�F1Hz�j
    time1 = time1 + 1;
    time2 = time2 + 1;
    
    %-----------------�I������-------------------%
    % �Ō�܂ŖK�₵��
    if n > size(target, 1)
        if target == target2
            break;
        else
            n = 1;
            target = target2;   % �^�[�Q�b�g�̍X�V
            
            % ����ڊ��������Ƃ��̌��ʃv���b�g
            result_heatmap(field);

        end
    end
    
   %�@�̈�O�ɏo��
    if 10 < robot.x || robot.x < 0
        break;
    end
    if 10 < robot.y || robot.y < 0
        break;
    end
    %---------------------------------------------%
    
    % �K�E�X���z�̗�������
    noise_L = repmat(mu, 1) + randn(1) * R;
    noise_R = repmat(mu, 1) + randn(1) * R;
    %noise_L = 0;
    %noise_R = 0;
    
    %---------------------����--------------------%
    % ���Ɍ������^�[�Q�b�g�̂������
    angle = calc_angle(target(n,:), robot, pre_robot);
    
    % ���x�Ɖ�]���x
    [turn, straight, V, omega] = control(angle, noise_L, noise_R, r, B);
    turn_cnt = turn_cnt + turn;
    straight_cnt = straight_cnt + straight;  
  
    V;
    
    % �ꎞ���O�̃��{�b�g�̈ʒu���̍X�V
    pre_robot.x = robot.x;
    pre_robot.y = robot.y;

    robot.theta = robot.theta + omega * 2;
    robot.x = robot.x + V * cos(robot.theta * pi / 180);
    robot.y = robot.y + V * sin(robot.theta * pi / 180);
    
    %---------------------------------------------%
    
    % �^�[�Q�b�g�̍X�V
    if target(n,1)-0.25 < robot.x && robot.x <= target(n,1)+0.25
        if target(n,2)-0.25 < robot.y && robot.y <= target(n,2)+0.25
            % �^�[�Q�b�g�ԍ��̍X�V
            n = n + 1;            
        end
    end
    
    % -----------�q�[�g�}�b�v�p�z��̍X�V----------%
    i = fix(2 * robot.x);
    j = fix(2 * robot.y);
    if fix(2*pre_robot.x) ~= i || fix(2*pre_robot.y) ~= j
        % �K��񐔂̍X�V
        field.cover(j+1, i+1) = field.cover(j+1, i+1) + 1;
        % �K�⎞�Ԃ̍X�V
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
                        % �ʉ߉񐔂̍X�V
                        field.pass(j+k, i+l) = field.pass(j+k, i+l) + 1;
                    end
                end
            end
        end
    end
    %---------------------------------------------%
    
    % �A�j���[�V����
    addpoints(h, robot.x, robot.y);
    %drawnow;
end
%--------------------------���[�v�I��-------------------------%

% ���ʃv���b�g
result_heatmap(field);

% �o�ߎ���[min]
while_time = time1 / 60;
% ����
turn_rate = turn_cnt / (turn_cnt + straight_cnt);   

% �]���l�̎Z�o
grade = 0;
for i=1: max(round(field.time(:), 1)) * 10 + 1
    A = round(field.time, 1) == (i-1)/10;
    time_rate(i) = sum(A(:)) / (size(field.time, 1) * size(field.time, 2));
    grade = grade + time_rate(i) * (i-1);
end

% ���|���Z���̎Z�o
for i=1:20
    for j=1:20
        if field.cover(i, j) == 0
            x = i/2 - 0.25;
            y = j/2 - 0.25;
        end
    end
end
