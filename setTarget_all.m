function [ target ] = setTarget_all(  )
%UNTITLED5 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

target = [];
for i=1:18
    if mod(i, 2)
        for j=1:18
            % x���W, y���W
            target = [target; [j/2+0.25 i/2+0.25]];
        end
    else
        for j=18:-1:1
            % x���W, y���W
            target = [target; [j/2+0.25 i/2+0.25]];
        end
    end
end

end

