function [] = init(target1, target2)
%UNTITLED3 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q


% ���c�̃v���b�g
figure;
hold on;
% �^�[�Q�b�g�̃v���b�g
plot(target1(:, 1), target1(:, 2), 'rx');
plot(target2(:, 1), target2(:, 2), 'rx');
axis([0 10 0 10]);
grid on;
ax = gca;
ax.GridAlpha = 0.5;
ax.LineWidth = 1.0;
ax.XTick = (0:0.5:10);
ax.YTick = (0:0.5:10);


end

