function [ target ] = setTarget_vert(  )
%UNTITLED4 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

target = [];

for i=1:18
    if mod(i, 2)
        % x���W, y���W
        target = [target; [i/2+0.25 18/2+0.25]];
        target = [target; [i/2+0.25 1/2+0.25]];
    else
        target = [target; [i/2+0.25 1/2+0.25]];
        target = [target; [i/2+0.25 18/2+0.25]];
    end
end


end

