function [ target ] = setTarget_hor( w )
%UNTITLED3 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

target = [];

for i=1:10/w-2
    if mod(i, 2)
        % x���W, y���W
        target = [target; [3*w/2 i*w+w/2]];
        target = [target; [(10/w-2)*w+w/2 i*w+w/2]];
    else
        target = [target; [(10/w-2)*w+w/2 i*w+w/2]];
        target = [target; [3*w/2 i*w+w/2]];
    end
end


end

