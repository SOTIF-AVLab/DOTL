function [u2,u3,u4,u5,u6,u7,u8] = tright(u1)
%u1 = [4,1,0,0...];
load('Cross')
%目标车道
m2 = [u1(1)+1,u1(1)-3];
flag = m2>0 & m2<5;
m2 = m2(flag);
R2 = num2str(m2);
R2 = ['road',R2];
L2 = num2str(u1(2));
L2 = ['lane_',L2];
u2 = Cross.(R2).(L2).Position;

%对向直行车道
m3 = [u1(1)+3,u1(1)-1];
flag = m3>0 & m3<5;
m3 = m3(flag);
R3 = num2str(m3);
R3 = ['road',R3];
num = (length(fieldnames(Cross.(R3)))-2)/2;
u3 = Cross.(R3).(['lane',num2str(u1(2))]).Position;
u4 = Cross.(R3).(['lane',num2str(num)]).Position;
u5 = Cross.(R2).(['lane_',num2str(u1(2))]).Position;
u6 = Cross.(R2).(['lane_',num2str(num)]).Position;

%目标车道右侧车道
u7 = Cross.(R2).lane_1.Position;
if u1(2)<(length(fieldnames(Cross.(R2)))-2)/2
    L4 = num2str(u1(2)+1);
    L4 = ['lane_',L4];
    u8 = Cross.(R2).(L4).Position;
else
    u8 = u2;
end