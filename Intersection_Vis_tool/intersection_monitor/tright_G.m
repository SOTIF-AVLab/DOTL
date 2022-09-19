function [u2,u3,u4] = tright_G(u1)
%u1 = [4,1,0,0...];
load('Cross')
m2 = [u1(1)+1,u1(1)-3];
flag = m2>0 & m2<5;
m2 = m2(flag);
R2 = num2str(m2);
R2 = ['road',R2];
L2 = num2str(u1(2));
L2 = ['lane_',L2];
u2 = Cross.(R2).(L2).Position;

m3 = [u1(1)+2,u1(1)-2];
flag = m3>0 & m3<5;
m3 = m3(flag);
R3 = num2str(m3);
R3 = ['road',R3];
num = (length(fieldnames(Cross.(R3)))-2)/2;
N=0;
for i = 1:num
    if Cross.(R3).(['lane',num2str(i)]).Position(9)==1
        N = N+1;
    else
        break
    end
end
u3 = Cross.(R3).(['lane',num2str(1)]).Position;
u4 = Cross.(R3).(['lane',num2str(N)]).Position;
