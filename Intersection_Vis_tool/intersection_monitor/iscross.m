function [y,X,Y] = iscross(P1,P2,Q1,Q2)   %判断两线段是否相交,并输出交点坐标（不相交时为NaN）
P1 = [P1,0];%将二维坐标转换为z=0的三维坐标，以使用cross函数
P2 = [P2,0];
Q1 = [Q1,0];
Q2 = [Q2,0];
%第一次叉积
P1P2 = P2 - P1; P1Q1 = Q1 - P1; P1Q2 = Q2 - P1;
a1 = cross(P1Q1,P1P2); b1 = cross(P1Q2,P1P2);
y1 = -1 * min(sign(sign(dot(a1,b1))-1),0);
%第二次叉积
Q1Q2 = Q2 - Q1; Q1P1 = P1 - Q1; Q1P2 = P2 - Q1;
a2 = cross(Q1P1,Q1Q2); b2 = cross(Q1P2,Q1Q2);
y2 = -1 * min(sign(sign(dot(a2,b2))-1),0);
%两次叉积结果都为1，则两线段相交
y = y1 * y2;

if y==1
    if (P1(1)==P2(1))
        X=P1(1);
        k2=(Q2(2)-Q1(2))/(Q2(1)-Q1(1));
        b2=Q1(2)-k2*Q1(1);
        Y=k2*X+b2;
    elseif (Q1(1)==Q2(1))
        X=Q1(1);
        k1=(P2(2)-P1(2))/(P2(1)-P1(1));
        b1=P1(2)-k1*P1(1);
        Y=k1*X+b1;
    else
        k1=(P2(2)-P1(2))/(P2(1)-P1(1));
        k2=(Q2(2)-Q1(2))/(Q2(1)-Q1(1));
        b1=P1(2)-k1*P1(1);
        b2=Q1(2)-k2*Q1(1);
        X=(b2-b1)/(k1-k2);
        Y=k1*X+b1;
    end
else
    X=NaN;
    Y=NaN;
end
end