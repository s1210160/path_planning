function [ result ] = visit_count( field )
%UNTITLED この関数の概要をここに記述
%   詳細説明をここに記述

result = zeros(1, max(field.cover(:))+1);
for i=1:size(field.cover, 1)
    for j=1:size(field.cover, 2)
        x = j/2 - 0.25;
        y = i/2 - 0.25;
        if 0.5 < x && x <= 9.5
            if 0.5 < y && y <= 9.5
                result(field.cover(i, j) + 1) = result(field.cover(i, j) + 1) + 1;
            end
        end
    end
end

end

