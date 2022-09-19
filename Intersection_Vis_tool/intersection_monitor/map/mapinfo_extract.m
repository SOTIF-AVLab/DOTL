clc;clear
mapdata = xml2struct('mapfile_relink_raw');

%节点信息提取，需要的信息包括每个节点的id及对应的横纵坐标
a = size(mapdata.osm.node);
for i = 1:a(2)
    map.node.nodeid(i) = str2double(mapdata.osm.node{1,i}.Attributes.id);
    map.node.nodelat(i) = str2double(mapdata.osm.node{1,i}.Attributes.lat);
    map.node.nodelon(i) = str2double(mapdata.osm.node{1,i}.Attributes.lon);
    [map.node.nodelon(i),map.node.nodelat(i)] = lat_lon2utm(map.node.nodelat(i),map.node.nodelon(i));
end

%连接线信息提取，需要的信息包括每条连接线的id，每条连接线中包含的节点id，连接线的类型名称（字符串）
b = size(mapdata.osm.way);
for i = 1:b(2)
    map.way.wayid(1,i) = str2double(mapdata.osm.way{1,i}.Attributes.id);
    c = size(mapdata.osm.way{1,i}.nd);
    d = size(mapdata.osm.way{1,i}.tag);
    for j = 1:c(2)
        map.way.inwayids(j,i) = str2double(mapdata.osm.way{1,i}.nd{1,j}.Attributes.ref);
    end
    if d(2) == 1
        map.way.waytype(1,i) = {mapdata.osm.way{1,i}.tag.Attributes.v};
    else
        map.way.waytype(1,i) = {mapdata.osm.way{1,i}.tag{1,d(2)}.Attributes.v};
        if strcmp(char(map.way.waytype(1,i)),'zebra_marking')
            sub1 = {mapdata.osm.way{1,i}.tag{1,1}.Attributes.v};
            sub2 = {mapdata.osm.way{1,i}.tag{1,2}.Attributes.v};
            map.way.waytype(1,i) = {[char(map.way.waytype(1,i)) '_' char(sub1) '_' char(sub2)]};
        end
    end
end

%路段信息提取，需要的信息包括每个路段的id，组成路段左、右连接线的id，路段的名称（字符串）
e = size(mapdata.osm.relation);
for i = 1:e(2)
    map.relation.relationid(i) = str2double(mapdata.osm.relation{1,i}.Attributes.id);
    map.relation.leftwayid(i) = str2double(mapdata.osm.relation{1,i}.member{1,1}.Attributes.ref);
    map.relation.rightwayid(i) = str2double(mapdata.osm.relation{1,i}.member{1,2}.Attributes.ref);
    f = size(mapdata.osm.relation{1,i}.tag);
    if f(2) == 6
        map.relation.relationname(1,i) = {mapdata.osm.relation{1,i}.tag{1,2}.Attributes.v};
    else
        map.relation.relationname(1,i) = {mapdata.osm.relation{1,i}.tag{1,1}.Attributes.v};
    end
end
