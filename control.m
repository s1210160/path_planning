function [ V, omega, rice_effect ] = control( angle, noiseL, noiseR, r, B )
%UNTITLED6 この関数の概要をここに記述
%   詳細説明をここに記述

if angle > 10
    omegaL = 20 + noiseL;
    omegaR = 80 + noiseR;
    'l';
    
elseif angle < -10
    omegaL = 80 + noiseL;
    omegaR = 20 + noiseR;
    'r';
    
else
    omegaL = 100 + noiseL;
    omegaR = 100 + noiseR;
    'f';
    
end

V_L = r * omegaL * pi / 180;
V_R = r * omegaR * pi / 180;
omega = (V_R - V_L) / B;
V = (V_R + V_L) / 2;

% 環境負荷の計算
rice_effect = sqrt((omegaL - omegaR).^2);

