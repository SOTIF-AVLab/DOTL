function [u2,u3,u4] = gostright(u1)
%u1 = [4,1,0,0...];
load('Cross')
%目标车道
m2 = [u1(1)+2,u1(1)-2];
flag = m2>0 & m2<5;
m2 = m2(flag);
R2 = num2str(m2);
R2 = ['road',R2];
L2 = num2str(u1(2));
L2 = ['lane_',L2];
u2 = Cross.(R2).(L2).Position;

if u1(2)==1
    u3 = u2;
else
    L3 = num2str(u1(2)-1);
    L3 = ['lane_',L3];
    u3 = Cross.(R2).(L3).Position;
end

if u1(2)<(length(fieldnames(Cross.(R2)))-2)/2
    L4 = num2str(u1(2)+1);
    L4 = ['lane_',L4];
    u4 = Cross.(R2).(L4).Position;
else
    u4 = u2;
end