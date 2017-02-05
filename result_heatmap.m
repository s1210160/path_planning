function result_heatmap( field )
%UNTITLED7 この関数の概要をここに記述
%   詳細説明をここに記述

figure('Name', '通過時間', 'NumberTitle', 'off');
hold on;
colormap jet;
imagesc([0 10], [0 10], field.pass, [0 10]);
axis([0 10 0 10]);
set(gca,'YDir','normal');
colorbar

figure('Name', '掃引時間', 'NumberTitle', 'off');
colormap jet;
imagesc([0.25 9.75], [0.25 9.75], field.time, [0 10]);
set(gca,'YDir','normal');
colorbar;

figure('Name', '掃引回数', 'NumberTitle', 'off');
colormap jet;
imagesc([0.25 9.75], [0.25 9.75], field.cover, [0 10]);
set(gca,'YDir','normal');
colorbar;


end

