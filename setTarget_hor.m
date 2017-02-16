function [ target ] = setTarget_hor( w )
%UNTITLED3 この関数の概要をここに記述
%   詳細説明をここに記述

target = [];

for i=1:10/w-2
    if mod(i, 2)
        % x座標, y座標
        target = [target; [3*w/2 i*w+w/2]];
        target = [target; [(10/w-2)*w+w/2 i*w+w/2]];
    else
        target = [target; [(10/w-2)*w+w/2 i*w+w/2]];
        target = [target; [3*w/2 i*w+w/2]];
    end
end


end

