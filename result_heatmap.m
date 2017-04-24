function [h] = result_heatmap( field, num, name )
%UNTITLED7 この関数の概要をここに記述
%   詳細説明をここに記述

%{
filename = strcat('experiment/static/mu=0,sigma=10/trial', num2str(name))

if num == 1
    file_count_size1 = strcat(filename, '/count_size_1.png');
    file_env1 = strcat(filename, '/env_1.png');
    file_env_count1 = strcat(filename, '/env_count_1.png');
    file_count1 = strcat(filename, '/count_1.png');
    file_count_size2 = strcat(filename, '/count_size_1.fig');
    file_env2 = strcat(filename, '/env_1.fig');
    file_env_count2 = strcat(filename, '/env_count_1.fig');
    file_count2 = strcat(filename, '/count_1.fig');
    
    fp_pass = fopen(strcat(filename, '/pass1.csv'), 'w');
    fp_env = fopen(strcat(filename, '/env1.csv'), 'w');
    fp_env_count = fopen(strcat(filename, '/envcount1.csv'), 'w');
    fp_cover = fopen(strcat(filename, '/cover1.csv'), 'w');
end

if num == 2
    file_count_size1 = strcat(filename, '/count_size_2.png');
    file_env1 = strcat(filename, '/env_2.png');
    file_env_count1 = strcat(filename, '/env_count_2.png');
    file_count1 = strcat(filename, '/count_2.png');
    file_count_size2 = strcat(filename, '/count_size_2.fig');
    file_env2 = strcat(filename, '/env_2.fig');
    file_env_count2 = strcat(filename, '/env_count_2.fig');
    file_count2 = strcat(filename, '/count_2.fig');
    
    fp_pass = fopen(strcat(filename, '/pass2.csv'), 'w');
    fp_env = fopen(strcat(filename, '/env2.csv'), 'w');
    fp_env_count = fopen(strcat(filename, '/envcount2.csv'), 'w');
    fp_cover = fopen(strcat(filename, '/cover2.csv'), 'w');
end
%}

figure('Name', '通過時間', 'NumberTitle', 'off');
hold on;
colormap jet;
imagesc([0 10], [0 10], field.pass, [0 10]);
axis([0 10 0 10]);
set(gca,'YDir','normal');
colorbar
axis square;
%saveas(gcf, file_count_size1);
%saveas(gcf, file_count_size2);

figure('Name', '環境負荷', 'NumberTitle', 'off');
colormap jet;
imagesc([0.25 9.75], [0.25 9.75], field.env, [0 15]);
set(gca,'YDir','normal');
colorbar;
axis square;
%saveas(gcf, file_env1);
%saveas(gcf, file_env2);

figure('Name', '環境負荷(test)', 'NumberTitle', 'off');
colormap jet;
imagesc([0.25 9.75], [0.25 9.75], field.env./field.cover, [0 15]);
set(gca,'YDir','normal');
colorbar;
axis square;
%saveas(gcf, file_env_count1);
%saveas(gcf, file_env_count2);

figure('Name', '掃引回数', 'NumberTitle', 'off');
colormap jet;
imagesc([0.25 9.75], [0.25 9.75], field.cover, [0 10]);
set(gca,'YDir','normal');
colorbar;
axis square;
hold on;
h = gca;
%saveas(gcf, file_count1);
%saveas(gcf, file_count2);


%{
% data
for i=1: size(field.cover, 1)
    for j=1:size(field.cover, 2)
        fprintf(fp_env, '%d, ', field.env(i, j));
        fprintf(fp_env_count, '%d, ', field.env(i, j)/field.cover(i, j));
        fprintf(fp_cover, '%d, ', field.cover(i, j));
    end
    fprintf(fp_env, '\n');
    fprintf(fp_env_count, '\n');
    fprintf(fp_cover, '\n');
end

for i=1:size(field.pass, 1)
    for j=1:size(field.pass, 2)
        fprintf(fp_pass, '%d, ', field.pass(i, j));
    end
    fprintf(fp_pass, '\n');
end
fclose(fp_env);
fclose(fp_cover);
fclose(fp_pass);
%}
end

