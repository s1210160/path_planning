function [ target ] = setTarget_all( w )
%UNTITLED5 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

target = [];
for i=1:10/w-2
    if mod(i, 2)
        for j=1:10/w-2
            % x���W, y���W
            target = [target; [j*w+w/2 i*w+w/2]];
        end
    else
        for j=10/w-2:-1:1
            % x���W, y���W
            target = [target; [j*w+w/2 i*w+w/2]];
        end
    end
end


end

