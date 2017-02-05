function [ target ] = setTarget_hor(  )
%UNTITLED3 この関数の概要をここに記述
%   詳細説明をここに記述

target = [];

for i=1:18
    if mod(i, 2)
        % x座標, y座標
        target = [target; [1/2+0.25 i/2+0.25]];
        target = [target; [18/2+0.25 i/2+0.25]];
    else
        target = [target; [18/2+0.25 i/2+0.25]];
        target = [target; [1/2+0.25 i/2+0.25]];
    end
end


end

