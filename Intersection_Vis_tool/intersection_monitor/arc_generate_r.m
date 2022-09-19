function [x,y] = arc_generate_r(x1,y1,x2,y2)
% x1 = Cross.road1.lane1.Position(1,1);  %x1,y1为入口点坐标
% y1 = Cross.road1.lane1.Position(2,1);
% x2 = Cross.road2.lane_1.Position(1,2);  %x2,y2为出口点坐标
% y2 = Cross.road2.lane_1.Position(2,2);
% syms a b   %simulink不支持syms
% [x,y] = solve((x1-a)^2+(y1-b)^2==1,(x2-a)^2+(y2-b)^2==1);
% for i = 1:2
% m=cross([x2-x1,y2-y1,0],[x(i)-x1 y(i)-y1 0]);
% if m(3)>0
%     c = [x(i),y(i)];
% end
% c = double(c);
% end

m = min(abs(x2-x1),abs(y2-y1));
r = ((x2-x1)^2+(y2-y1)^2)/2/m;   %圆弧半径
C1 = (x2^2-x1^2+y2^2-y1^2)/2/(x2-x1);
C2 = (y2-y1)/(x2-x1);
A = (C2^2+1);
B = (2*x1*C2-2*C1*C2-2*y1);
C = x1^2-2*x1*C1+C1^2+y1^2-r^2;
b = zeros(1,2);
b(1) = (-B+sqrt(B*B-4*A*C))/(2*A);
b(2) = (-B-sqrt(B*B-4*A*C))/(2*A);
a = C1-C2*b;
for i = 1:2
    M = cross([x2-x1,y2-y1,0],[a(i)-x1,b(i)-y1,0]);
%     if M(3)>0    %左转圆弧圆心
%         c_left = [a(i),b(i)];
%         alpha1 = atan2(y1-b(i),x1-a(i));
%         alpha2 = atan2(y2-b(i),x2-a(i));
%         break
%     else
%         c_left = [0,0];
%         alpha1 = 0;
%         alpha2 = 0;
%     end
    if M(3)<0    %右转圆弧圆心
        c_right = [a(i),b(i)];
        alpha1 = atan2(y1-b(i),x1-a(i));
        alpha2 = atan2(y2-b(i),x2-a(i));
        break
    else
        c_right = [0,0];
        alpha1 = 0;
        alpha2 = 0;
    end
end

%生成两点之间的轨迹曲线
t = linspace(min(alpha1,alpha2),max(alpha1,alpha2),20);
% x = (cos(t))*r+c_left(1);
% y = (sin(t))*r+c_left(2);
x = (cos(t))*r+c_right(1);
y = (sin(t))*r+c_right(2);