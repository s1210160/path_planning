function [ target ] = setTarget_all( w )
%UNTITLED5 この関数の概要をここに記述
%   詳細説明をここに記述

target = [];
for i=1:10/w-2
    if mod(i, 2)
        for j=1:10/w-2
            % x座標, y座標
            target = [target; [j*w+w/2 i*w+w/2]];
        end
    else
        for j=10/w-2:-1:1
            % x座標, y座標
            target = [target; [j*w+w/2 i*w+w/2]];
        end
    end
end


end

