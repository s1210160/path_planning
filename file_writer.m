function file_writer( field )
%UNTITLED2 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

fp_pass = fopen('pass.csv', 'w');
fp_env = fopen('env.csv', 'w');
fp_cover = fopen('cover.csv', 'w');

for i=1: size(field.cover, 1)
    for j=1:size(field.cover, 2)
        fprintf(fp_env, '%d, ', field.env(i, j));
        fprintf(fp_cover, '%d, ', field.cover(i, j));
    end
    fprintf(fp_env, '\n');
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


end

