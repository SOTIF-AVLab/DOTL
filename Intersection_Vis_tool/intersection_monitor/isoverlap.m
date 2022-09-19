%输入两个矩形的坐标，判断两个是否重叠
%R1，R2 包含了两个矩形的坐标
%R1：[x1, y1, x2, y2]
%x1 y1是一个点的坐标
%x2 y2是斜对角点的坐标
function y = isoverlap(R1, R2)
W1 = abs(R1(3) - R1(1));
W2 = abs(R2(3) - R2(1));
L1 = abs(R1(4) - R1(2));
L2 = abs(R2(4) - R2(2));

C1 = [(R1(1) + R1(3))/2, (R1(2) + R1(4))/2];
C2 = [(R2(1) + R2(3))/2, (R2(2) + R2(4))/2];


if (    (abs(C1(1) - C2(1))) <= abs((W1/2 + W2/2)) && ...
        (abs(C1(2) - C2(2))) <= abs((L1/2 + L2/2))        ) 
    y = 1;
else
    y = 0;
end
end

