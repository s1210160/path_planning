function result_heatmap( field )
%UNTITLED7 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

figure('Name', '�ʉߎ���', 'NumberTitle', 'off');
hold on;
colormap jet;
imagesc([0 10], [0 10], field.pass, [0 10]);
axis([0 10 0 10]);
set(gca,'YDir','normal');
colorbar

figure('Name', '�|������', 'NumberTitle', 'off');
colormap jet;
imagesc([0.25 9.75], [0.25 9.75], field.time, [0 10]);
set(gca,'YDir','normal');
colorbar;

figure('Name', '�|����', 'NumberTitle', 'off');
colormap jet;
imagesc([0.25 9.75], [0.25 9.75], field.cover, [0 10]);
set(gca,'YDir','normal');
colorbar;


end

