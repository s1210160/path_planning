close all;
clear all;

file_env = 'env.csv';
file_cover = 'cover.csv';
file_pass = 'pass.csv';
field.env = csvread(file_env, 0, 0, [0 0 19 19]);
field.cover = csvread(file_cover, 0, 0, [0 0 19 19]);
field.pass = csvread(file_pass, 0, 0, [0 0 99 99]);

result_heatmap(field);

% �K�E�X���z�̐ݒ�
mu = 0;
sigma = 3.0;
R = chol(sigma);

cell_w = 1/2;

% ���{�b�g�̏����p��
robot.x = 0.25;         % x�����W
robot.y = 9.5;         % y�����W
robot.theta = 0.0;     % ���p
% �ꎞ���O�̃��{�b�g�̈ʒu���
pre_robot.x = robot.x;
pre_robot.y = 9.75;
% ���{�b�g�̃T�C�Y
r = 0.15;
B = 0.3;

target = calc_task(field, robot)

% ��{�ƂȂ�v���b�g
base_plot(target, target, cell_w);
% �A�j���[�V���������ꂽ���C���̍쐬
h = animatedline('Color', 'k', 'LineStyle', '-', 'LineWidth', 2.0);

n = 1;
tic;
while(1)
    
    if n > size(target, 1)
        break;
    end
    
    %�@�̈�O�ɏo��
    if 10 < robot.x || robot.x < 0
        break;
    end
    if 10 < robot.y || robot.y < 0
        break;
    end
    
     % �K�E�X���z�̗�������
    noise_L = repmat(mu, 1) + randn(1) * R;
    noise_R = repmat(mu, 1) + randn(1) * R;
    
     %---------------------����--------------------%
    % ���Ɍ������^�[�Q�b�g�̂������
    angle = calc_angle(target(n,:), robot, pre_robot);
    
    % ���x�C��]���x�C������
    [V, omega, rice_effect] = control(angle, noise_L, noise_R, r, B);
    
    V;
    
    % �ꎞ���O�̃��{�b�g�̈ʒu���̍X�V
    pre_robot.x = robot.x;
    pre_robot.y = robot.y;

    robot.theta = robot.theta + omega;
    robot.x = robot.x + V * cos(robot.theta);
    robot.y = robot.y + V * sin(robot.theta);
    
    % �A�j���[�V����
    addpoints(h, robot.x, robot.y);
    %drawnow;

    %---------------------------------------------%
    
    % -----------�q�[�g�}�b�v�p�z��̍X�V----------%
    i = fix(2 * robot.x);
    j = fix(2 * robot.y);
    if fix(2 * pre_robot.x) ~= i || fix(2 * pre_robot.y) ~= j
        % �K��񐔂̍X�V
        field.cover(j+1, i+1) = field.cover(j+1, i+1) + 1;
    end
    % �K�⎞�Ԃ̍X�V
    field.env(j+1, i+1) = field.env(j+1, i+1) + rice_effect;
    
    i = round(size(field.pass, 1) / 10 *robot.x, 0);
    j = round(size(field.pass, 1) / 10 *robot.y, 0);
    if round(pre_robot.x, 1) ~= i || round(pre_robot.y, 1) ~= j 
        for k=-1:1
            for l=-1:1
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

    
    % �^�[�Q�b�g�̍X�V
    if target(n,1)-cell_w/2 < robot.x && robot.x <= target(n,1)+cell_w/2
        if target(n,2)-cell_w/2 < robot.y && robot.y <= target(n,2)+cell_w/2
            % �^�[�Q�b�g�ԍ��̍X�V
            
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

% ���ʃv���b�g
result_heatmap(field);
