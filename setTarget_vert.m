function [ target ] = setTarget_vert( w )
%UNTITLED4 この関数の概要をここに記述
%   詳細説明をここに記述

target = [];

for i=1:10/w-2
    if mod(i, 2)
        % x座標, y座標
        target = [target; [i*w+w/2 (10/w-2)*w+w/2]];
        target = [target; [i*w+w/2 3*w/2]];
    else
        target = [target; [i*w+w/2 3*w/2]];
        target = [target; [i*w+w/2 (10/w-2)*w+w/2]];
    end
end


end

