function [ target ] = setTarget_vert( w )
%UNTITLED4 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

target = [];

for i=1:10/w-2
    if mod(i, 2)
        % x���W, y���W
        target = [target; [i*w+w/2 (10/w-2)*w+w/2]];
        target = [target; [i*w+w/2 3*w/2]];
    else
        target = [target; [i*w+w/2 3*w/2]];
        target = [target; [i*w+w/2 (10/w-2)*w+w/2]];
    end
end


end

