function [ V, omega, rice_effect ] = control( angle, noiseL, noiseR, r, B )
%UNTITLED6 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

if 10 * pi / 180 < angle
    omegaL = 20 * pi / 180 + noiseL;
    omegaR = 80 * pi / 180 + noiseR;
    'l';
    
elseif angle < -10 * pi / 180
    omegaL = 80 * pi / 180 + noiseL;
    omegaR = 20 * pi / 180 + noiseR;
    'r';
    
else
    omegaL = 100 * pi / 180 + noiseL;
    omegaR = 100 * pi / 180 + noiseR;
    'f';
    
end



V_L = r * omegaL;
V_R = r * omegaR;
omega = (V_R - V_L) / B;
V = (V_R + V_L) / 2;

% �����ׂ̌v�Z
%rice_effect = sqrt((omegaL - omegaR).^2);
rice_effect = abs(omegaL - omegaR);

