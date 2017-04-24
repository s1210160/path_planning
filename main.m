close all;
clear all;

% �K�E�X���z�̐ݒ�
mu = 0;
sigma = 10.0 * pi / 180;
R = chol(sigma);

% �Z����
cell_w = 1/2; % [m]

% �^�[�Q�b�g�̐ݒ�
target1 = setTarget_hor(cell_w);      % �����p����������
target2 = setTarget_vert(cell_w);     % �����p����������
target3 = setTarget_vert(cell_w);
target = target1;               % �^�[�Q�b�g�ݒ�
n = 1;                          % �^�[�Q�b�g�ԍ�

% �q�[�g�}�b�v�p�z��̏�����
field.cover = zeros(20, 20);    % �|����
field.env = zeros(20, 20);     % ������
field.pass = zeros(100, 100);   % �ʉߎ���

% ���{�b�g�̏����p��
robot.x = 0.25;         % x�����W
robot.y = 0.75;         % y�����W
robot.theta = 0.0;     % ���p
% �ꎞ���O�̃��{�b�g�̈ʒu���
pre_robot.x = robot.x;
pre_robot.y = 0.0;
% ���{�b�g�̃T�C�Y
r = 0.15;
B = 0.3;

% ��{�ƂȂ�v���b�g
base_plot(target1, target1, cell_w);
% �A�j���[�V���������ꂽ���C���̍쐬
h = animatedline('Color', 'k', 'LineStyle', '-', 'LineWidth', 2.0);

% �X�g�b�v�E�H�b�`�J�n
time1 = 0;

%--------------------------���[�v---------------------------%
while(1)
    
    % ���Ԃ̍X�V�i�������x�F1Hz�j
    time1 = time1 + 1;
    
    %-----------------�I������-------------------%
    % �Ō�܂ŖK�₵��
    if n > size(target, 1)
        if target == target3
            break;
        else
            n = 1;
            target3 = calc_task(field, robot);
            target = target3;   % �^�[�Q�b�g�̍X�V
            
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
    
    % ���x�C��]���x�C������
    [V, omega, rice_effect] = control(angle, noise_L, noise_R, r, B);
    
    V;
    
    % �ꎞ���O�̃��{�b�g�̈ʒu���̍X�V
    pre_robot.x = robot.x;
    pre_robot.y = robot.y;

    robot.theta = robot.theta + omega;
    robot.x = robot.x + V * cos(robot.theta);
    robot.y = robot.y + V * sin(robot.theta);

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
    
    % �A�j���[�V����
    addpoints(h, robot.x, robot.y);
    if target == target3
    drawnow;
    end
    %plot(robot.x, robot.y, 'b*');
end
%--------------------------���[�v�I��-------------------------%

% ���ʃv���b�g
result_heatmap(field);

% �o�ߎ���[min]
while_time = time1 / 60;

file_writer(field);

result = visit_count(field)

sum(rice_effect(:))
