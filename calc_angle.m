function [ theta ] = calc_angle( target, now, prev )
%UNTITLED4 この関数の概要をここに記述
%   詳細説明をここに記述

t = [target(1) target(2)];
n = [now.x now.y];
p = [prev.x prev.y];

P0 = n - p;
P1 = t - n;

theta = acos(dot(P0, P1) / (sqrt(P0(1).^2 + P0(2).^2) * sqrt(P1(1).^2 + P1(2).^2))) / pi * 180;

b = P0(1)*P1(2) - P0(2)*P1(1);

theta = theta * b / sqrt(b.^2);

%{
if (P0(1)*P1(2) - P0(2)*P1(1)) < 0
    theta = -theta;
end
%}
end

