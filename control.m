function [ turn, straight, V, omega ] = control( angle, noiseL, noiseR, r, B )
%UNTITLED6 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q

if angle > 10
    turn = 1;
    straight = 0;
    omegaL = -10 + noiseL;
    omegaR = 20 + noiseR;
    'l'
    
elseif angle < -10
    turn = 1;
    straight = 0;
    omegaL = 20 + noiseL;
    omegaR = -10 + noiseR;
    'r'
    
else
    turn = 0;
    straight = 1;
    omegaL = 10 + noiseL;
    omegaR = 10 + noiseR;
    'f'
    
end

V_L = r * omegaL;
V_R = r * omegaR;
omega = (V_R - V_L) / B;
V = (V_L + V_R) / 2;