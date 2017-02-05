function [ target ] = setTarget_all(  )
%UNTITLED5 この関数の概要をここに記述
%   詳細説明をここに記述

target = [];
for i=1:18
    if mod(i, 2)
        for j=1:18
            % x座標, y座標
            target = [target; [j/2+0.25 i/2+0.25]];
        end
    else
        for j=18:-1:1
            % x座標, y座標
            target = [target; [j/2+0.25 i/2+0.25]];
        end
    end
end

end

