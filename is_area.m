function [ out ] = is_area( i, j, w )
%UNTITLED この関数の概要をここに記述
%   詳細説明をここに記述

out = 0;

x = (j - 0.5) * w;
y = (i - 0.5) * w;
if 1 < x && x < 9
    if 1 < y && y < 9
        out = 1;
    end
end

end

