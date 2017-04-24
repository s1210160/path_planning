close all;
clear all;

name = 0;

% �K�E�X���z�̐ݒ�
mu = 0;
sigma = 20.0 * pi / 180;
R = chol(sigma);

% �Z����
cell_w = 1; % [m]

% �^�[�Q�b�g�̐ݒ�
target1 = setTarget_hor(cell_w);      % �����p����������
target2 = setTarget_vert(cell_w);     % �����p����������
target = target1;               % �^�[�Q�b�g�ݒ�
n = 1;                          % �^�[�Q�b�g�ԍ�
circle = 1;

% �q�[�g�}�b�v�p�z��̏�����
field.cover = zeros(20, 20);    % �|����
field.env = zeros(20, 20);     % ������
field.pass = zeros(100, 100);   % �ʉߎ���

% ���{�b�g�̏����p��
for i=1:4
robot(i).x = 0.25;         % x�����W
robot(i).y = 0.75;         % y�����W
robot(i).theta = 0.0;      % ���p
end

% ���{�b�g�̃T�C�Y
r = 0.15;
B = 0.3;

angle = 0;

% ��{�ƂȂ�v���b�g
f = base_plot(target1, cell_w);
% �A�j���[�V���������ꂽ���C���̍쐬
h1 = animatedline(f, 'Color', 'k', 'LineStyle', '-', 'LineWidth', 2.0);
axis square;

% �o�H��
len = 0;

% �X�g�b�v�E�H�b�`�J�n
time1 = 0;
tic;

%--------------------------���[�v---------------------------%
while(1)
    
    % ���Ԃ̍X�V�i�������x�F1Hz�j
    time1 = time1 + 1;
    
    %-----------------�I������-------------------%
    % �Ō�܂ŖK�₵��
    if size(target, 1) == 0
        if circle == 2
                break;
        else
            circle = circle + 1;
            
            while_time(1) = time1 / 60;
            program_time(1) = toc;
            path_l(1) = len;
            count1 = visit_count(field);
            
            target = calc_task(field, robot(2), robot(3), cell_w) % �^�[�Q�b�g�̍X�V
            
            if size(target) == 0
                break;
            end
            
            % ����ڊ��������Ƃ��̌��ʃv���b�g
            f2 = result_heatmap(field, 1, name);
            
            h1 = animatedline(f, 'Color', 'b', 'LineStyle', '-', 'LineWidth', 2.0);
            h2 = animatedline(f2, 'Color', 'r', 'LineStyle', '-', 'LineWidth', 2.0);
            
            tic;
        end
    end
    
    %�@�̈�O�ɏo��
    if 10 < robot(2).x || robot(2).x < 0
        break;
    end
    if 10 < robot(2).y || robot(2).y < 0
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
    if mod(time1, 2) == 0
        angle = calc_angle(target(n, :), robot(2), robot(3));
        plot(f, target(n, 1), target(n, 2), 'r*');
        if circle == 2
            plot(f2, target(n, 1), target(n, 2), 'r*');
        end
    end
    
    % ���x�C��]���x�C������
    [V, omega, rice_effect] = control(angle, noise_L, noise_R, r, B);
    
    % �ꎞ���O�̃��{�b�g�̈ʒu���̍X�V
    for i=4:-1:2
    robot(i).x = robot(i-1).x;
    robot(i).y = robot(i-1).y;
    end
    
    robot(1).theta = robot(1).theta + omega;
    robot(1).x = robot(1).x + V * cos(robot(1).theta);
    robot(1).y = robot(1).y + V * sin(robot(1).theta);
    
    len = sqrt((robot(2).x-robot(3).x).^2 + (robot(2).y-robot(3).y).^2) + len;
    
    %---------------------------------------------%
    
    % ---------------�^�[�Q�b�g�̍X�V--------------%
    if circle == 1
        if target(n,1)-0.5*cell_w < robot(2).x && robot(2).x <= target(n,1)+0.5*cell_w
            if target(n,2)-0.5*cell_w < robot(2).y && robot(2).y <= target(n,2)+0.5*cell_w
                target(n, :) = [];
            end
        end
    end
    
    if circle == 2
        if target(n, 1)-0.5 < robot(2).x && robot(2).x < target(n, 1)+0.5
            if target(n, 2)-0.5 < robot(2).y && robot(2).y < target(n, 2)+0.5
                plot(f, target(n, 1), target(n, 2), 'g*');
                plot(f2, target(n, 1), target(n, 2), 'g*');
                
                if size(target, 1) > 1 && target(n, 3) == target(n+1, 3)
                    target(n, :) = [];
                else
                    target(n, :) = [];
                    target = calc_task(field, robot(2), robot(3), cell_w);
                end
            end
        end
    end

    %---------------------------------------------%
    
    % -----------�q�[�g�}�b�v�p�z��̍X�V----------%
    i = fix(2 * robot(2).x);
    j = fix(2 * robot(2).y);
    if fix(2 * robot(3).x) ~= i || fix(2 * robot(3).y) ~= j
        % �K��񐔂̍X�V
        field.cover(j+1, i+1) = field.cover(j+1, i+1) + 1;
    end
    % �K�⎞�Ԃ̍X�V
    field.env(j+1, i+1) = field.env(j+1, i+1) + rice_effect;
    
    i = round(size(field.pass, 1) / 10 *robot(2).x, 0);
    j = round(size(field.pass, 1) / 10 *robot(2).y, 0);
    if round(robot(3).x, 1) ~= i || round(robot(3).y, 1) ~= j
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
    
    % �A�j���[�V����
    addpoints(h1, robot(2).x, robot(2).y);
    if circle == 2
        addpoints(h2, robot(2).x, robot(2).y);
        drawnow;
    end
end
%--------------------------���[�v�I��-------------------------%
% �v���O��������
program_time(2) = program_time(1) + toc;

% ���ʃv���b�g
result_heatmap(field, 2, name);

% �o�ߎ���[min]
while_time(2) = time1 / 60;
% �o�H��
path_l(2) = len;
count2 = visit_count(field);


%{
filename = strcat('experiment/static/mu=0,sigma=10/trial', num2str(name));
saveas(f, strcat(filename, '/path.png'));
saveas(f, strcat(filename, '/path.fig'));
fp = fopen(strcat(filename, '/data.csv'), 'w');

fprintf(fp, 'count1,');
for i=1:size(count1, 2)
    fprintf(fp, '%d,', count1(i));
end
fprintf(fp, '\n');

fprintf(fp, 'count2,');
for i=1:size(count2, 2)
    fprintf(fp, '%d,', count2(i));
end
fprintf(fp, '\n\n');

fprintf(fp, 'time, %f, %f\n', while_time(1), while_time(2));
fprintf(fp, 'length, %f, %f\n', path_l(1), path_l(2));

fclose('all');
%}
