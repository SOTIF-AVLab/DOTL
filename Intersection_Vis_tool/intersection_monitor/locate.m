%遍历struct，通过区域判断输出自车所在的路口及车道，及车道区域相应的坐标
function [road,lane,p] = locate(X,Y)
%X = 16; Y = -5;
u = load('Cross');
fileds = fieldnames(u.Cross);
road = zeros(1);
lane = zeros(1);
for i=1:length(fileds)
    m = fileds{i};
    name1 = u.Cross.(m);
    Name1 = fieldnames(name1);
    for j = 1:length(Name1)-2
        key = Name1{j};
        p = u.Cross.(m).(key).Position;
        if inpolygon(X,Y,[p(1),p(3),p(7),p(5),p(1)],[p(2),p(4),p(8),p(6),p(2)])
            y = 1;
            break
        else
            y = 0;
        end
    end    
    if y == 1
        road = str2double(m(end));
        lane = sign(double(key(end-1))-100)*str2double(key(end));   % double('_')==95; double('e')==101
        break
    else
        road = 0;
        lane = 0;
        p = zeros(1,11);
    end
end
end