function [ target ] = setTarget_hor(  )
%UNTITLED3 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

target = [];

for i=1:18
    if mod(i, 2)
        % x���W, y���W
        target = [target; [1/2+0.25 i/2+0.25]];
        target = [target; [18/2+0.25 i/2+0.25]];
    else
        target = [target; [18/2+0.25 i/2+0.25]];
        target = [target; [1/2+0.25 i/2+0.25]];
    end
end


end

