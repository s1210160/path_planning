close all;
clear all;

h = animatedline('Color', 'k', 'LineStyle', '-', 'LineWidth', 2.0);

robot.x = 10
robot.y = 10
robot.theta = 0
a = 30;
while(true)
    
    if 9.9 < robot.x && robot.x <= 10.1
        if 9.9 < robot.y && robot.y <= 10.1
        a = -a;
        end
    end
   [turn, straight, V, omega] = control(a, 0, 0, 0.06 )
   a
   V
    robot.theta = robot.theta + omega * 2;
    robot.x = robot.x + V * cos(robot.theta * pi / 180);
    robot.y = robot.y + V * sin(robot.theta * pi / 180);
    
    addpoints(h, robot.x, robot.y);
    drawnow;
end