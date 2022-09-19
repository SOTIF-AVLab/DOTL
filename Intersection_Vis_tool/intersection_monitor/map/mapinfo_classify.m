relationname=char(map.relation.relationname);
wayname = char(map.way.waytype);
for i = 1:62
    if all(relationname(i,1:4) ==  'E_en')  %东方向驶出路口
        index_leftid = find(map.way.wayid == map.relation.leftwayid(i));  %确定该relation的左侧way的id位置
        leftwayids = map.way.inwayids(:,index_leftid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id1_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(1)));
        P_id1_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(1)));
        %该way的另一端点id及其对应的坐标
        P_id2_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))));
        P_id2_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))));
        if P_id1_lon < P_id2_lon  %判断前后关系
            P_lf_lat = P_id2_lat;
            P_lf_lon = P_id2_lon;
            P_lr_lat = P_id1_lat;
            P_lr_lon = P_id1_lon;
        else
            P_lf_lat = P_id1_lat;
            P_lf_lon = P_id1_lon;
            P_lr_lat = P_id2_lat;
            P_lr_lon = P_id2_lon;
        end
        index_rightid = find(map.way.wayid == map.relation.rightwayid(i));  %确定该relation的右侧way的id位置
        rightwayids = map.way.inwayids(:,index_rightid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id3_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(1)));
        P_id3_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(1)));
        %该way的另一端点id及其对应的坐标
        P_id4_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))));
        P_id4_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))));
        if P_id3_lon < P_id4_lon  %判断前后关系
            P_rf_lat = P_id4_lat;
            P_rf_lon = P_id4_lon;
            P_rr_lat = P_id3_lat;
            P_rr_lon = P_id3_lon;
        else
            P_rf_lat = P_id3_lat;
            P_rf_lon = P_id3_lon;
            P_rr_lat = P_id4_lat;
            P_rr_lon = P_id4_lon;
        end
        j = str2double(relationname(i,6));  %确定该方向进入方向车道id
        if j == 1
            Cross.road1.lane_1.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,0,0];
        elseif j == 2
            Cross.road1.lane_2.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,0,0];
        elseif j == 3
            Cross.road1.lane_3.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,0,0];
        end
    end
    
    if all(relationname(i,1:4) ==  'E_ex')&&(relationname(i,7) ==  ' ')  %东方向驶入路口
        index_leftid = find(map.way.wayid == map.relation.leftwayid(i));  %确定该relation的左侧way的id位置
        leftwayids = map.way.inwayids(:,index_leftid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id1_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(1)));
        P_id1_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(1)))-2.26;
        %该way的另一端点id及其对应的坐标
        P_id2_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))));
        P_id2_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))))-2.26;
        if P_id1_lon > P_id2_lon  %判断前后关系
            P_lf_lat = P_id2_lat;
            P_lf_lon = P_id2_lon;
            P_lr_lat = P_id1_lat;
            P_lr_lon = P_id1_lon;
        else
            P_lf_lat = P_id1_lat;
            P_lf_lon = P_id1_lon;
            P_lr_lat = P_id2_lat;
            P_lr_lon = P_id2_lon;
        end
        index_rightid = find(map.way.wayid == map.relation.rightwayid(i));  %确定该relation的右侧way的id位置
        rightwayids = map.way.inwayids(:,index_rightid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id3_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(1)));
        P_id3_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(1)))-2.26;
        %该way的另一端点id及其对应的坐标
        P_id4_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))));
        P_id4_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))))-2.26;
        if P_id3_lon > P_id4_lon  %判断前后关系
            P_rf_lat = P_id4_lat;
            P_rf_lon = P_id4_lon;
            P_rr_lat = P_id3_lat;
            P_rr_lon = P_id3_lon;
        else
            P_rf_lat = P_id3_lat;
            P_rf_lon = P_id3_lon;
            P_rr_lat = P_id4_lat;
            P_rr_lon = P_id4_lon;
        end
        j = str2double(relationname(i,6));  %确定该方向进入方向车道id
        if j == 1
            Cross.road1.lane1.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,1,1,0];
        elseif j == 2
            Cross.road1.lane2.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,1,1];
        elseif j == 3
            Cross.road1.lane3.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,1,1];
        end
    end
    
    if all(relationname(i,1:4) ==  'N_en')  %北方向驶出路口
        index_leftid = find(map.way.wayid == map.relation.leftwayid(i));  %确定该relation的左侧way的id位置
        leftwayids = map.way.inwayids(:,index_leftid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id1_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(1)));
        P_id1_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(1)));
        %该way的另一端点id及其对应的坐标
        P_id2_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))));
        P_id2_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))));
        if P_id1_lat < P_id2_lat  %判断前后关系
            P_lf_lat = P_id2_lat;
            P_lf_lon = P_id2_lon;
            P_lr_lat = P_id1_lat;
            P_lr_lon = P_id1_lon;
        else
            P_lf_lat = P_id1_lat;
            P_lf_lon = P_id1_lon;
            P_lr_lat = P_id2_lat;
            P_lr_lon = P_id2_lon;
        end
        index_rightid = find(map.way.wayid == map.relation.rightwayid(i));  %确定该relation的右侧way的id位置
        rightwayids = map.way.inwayids(:,index_rightid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id3_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(1)));
        P_id3_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(1)));
        %该way的另一端点id及其对应的坐标
        P_id4_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))));
        P_id4_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))));
        if P_id3_lat < P_id4_lat  %判断前后关系
            P_rf_lat = P_id4_lat;
            P_rf_lon = P_id4_lon;
            P_rr_lat = P_id3_lat;
            P_rr_lon = P_id3_lon;
        else
            P_rf_lat = P_id3_lat;
            P_rf_lon = P_id3_lon;
            P_rr_lat = P_id4_lat;
            P_rr_lon = P_id4_lon;
        end
        j = str2double(relationname(i,6));  %确定该方向进入方向车道id
        if j == 1
            Cross.road2.lane_1.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,0,0];
        elseif j == 2
            Cross.road2.lane_2.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,0,0];
        end
    end
    
    if all(relationname(i,1:4) ==  'N_ex')&&(relationname(i,7) ==  ' ')  %北方向驶入路口
        index_leftid = find(map.way.wayid == map.relation.leftwayid(i));  %确定该relation的左侧way的id位置
        leftwayids = map.way.inwayids(:,index_leftid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id1_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(1)))-2.13;
        P_id1_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(1)));
        %该way的另一端点id及其对应的坐标
        P_id2_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))))-2.13;
        P_id2_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))));
        if P_id1_lat > P_id2_lat  %判断前后关系
            P_lf_lat = P_id2_lat;
            P_lf_lon = P_id2_lon;
            P_lr_lat = P_id1_lat;
            P_lr_lon = P_id1_lon;
        else
            P_lf_lat = P_id1_lat;
            P_lf_lon = P_id1_lon;
            P_lr_lat = P_id2_lat;
            P_lr_lon = P_id2_lon;
        end
        index_rightid = find(map.way.wayid == map.relation.rightwayid(i));  %确定该relation的右侧way的id位置
        rightwayids = map.way.inwayids(:,index_rightid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id3_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(1)))-2.13;
        P_id3_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(1)));
        %该way的另一端点id及其对应的坐标
        P_id4_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))))-2.13;
        P_id4_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))));
        if P_id3_lat > P_id4_lat  %判断前后关系
            P_rf_lat = P_id4_lat;
            P_rf_lon = P_id4_lon;
            P_rr_lat = P_id3_lat;
            P_rr_lon = P_id3_lon;
        else
            P_rf_lat = P_id3_lat;
            P_rf_lon = P_id3_lon;
            P_rr_lat = P_id4_lat;
            P_rr_lon = P_id4_lon;
        end
        j = str2double(relationname(i,6));  %确定该方向进入方向车道id
        if j == 1
            Cross.road2.lane1.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,1,1,1];
        elseif j == 2
            Cross.road2.lane2.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,1,1];
        end
    end
    
    if all(relationname(i,1:4) ==  'W_en')  %西方向驶出路口
        index_leftid = find(map.way.wayid == map.relation.leftwayid(i));  %确定该relation的左侧way的id位置
        leftwayids = map.way.inwayids(:,index_leftid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id1_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(1)));
        P_id1_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(1)));
        %该way的另一端点id及其对应的坐标
        P_id2_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))));
        P_id2_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))));
        if P_id1_lon > P_id2_lon  %判断前后关系
            P_lf_lat = P_id2_lat;
            P_lf_lon = P_id2_lon;
            P_lr_lat = P_id1_lat;
            P_lr_lon = P_id1_lon;
        else
            P_lf_lat = P_id1_lat;
            P_lf_lon = P_id1_lon;
            P_lr_lat = P_id2_lat;
            P_lr_lon = P_id2_lon;
        end
        index_rightid = find(map.way.wayid == map.relation.rightwayid(i));  %确定该relation的右侧way的id位置
        rightwayids = map.way.inwayids(:,index_rightid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id3_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(1)));
        P_id3_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(1)));
        %该way的另一端点id及其对应的坐标
        P_id4_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))));
        P_id4_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))));
        if P_id3_lon > P_id4_lon  %判断前后关系
            P_rf_lat = P_id4_lat;
            P_rf_lon = P_id4_lon;
            P_rr_lat = P_id3_lat;
            P_rr_lon = P_id3_lon;
        else
            P_rf_lat = P_id3_lat;
            P_rf_lon = P_id3_lon;
            P_rr_lat = P_id4_lat;
            P_rr_lon = P_id4_lon;
        end
        j = str2double(relationname(i,6));  %确定该方向进入方向车道id
        if j == 1
            Cross.road3.lane_1.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,0,0];
        elseif j == 2
            Cross.road3.lane_2.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,0,0];
        elseif j == 3
            Cross.road3.lane_3.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,0,0];
        end
    end
    
    if all(relationname(i,1:4) ==  'W_ex')&&(relationname(i,7) ==  ' ')  %西方向驶入路口
        index_leftid = find(map.way.wayid == map.relation.leftwayid(i));  %确定该relation的左侧way的id位置
        leftwayids = map.way.inwayids(:,index_leftid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id1_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(1)));
        P_id1_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(1)))+2.72;
        %该way的另一端点id及其对应的坐标
        P_id2_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))));
        P_id2_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))))+2.72;
        if P_id1_lon < P_id2_lon  %判断前后关系
            P_lf_lat = P_id2_lat;
            P_lf_lon = P_id2_lon;
            P_lr_lat = P_id1_lat;
            P_lr_lon = P_id1_lon;
        else
            P_lf_lat = P_id1_lat;
            P_lf_lon = P_id1_lon;
            P_lr_lat = P_id2_lat;
            P_lr_lon = P_id2_lon;
        end
        index_rightid = find(map.way.wayid == map.relation.rightwayid(i));  %确定该relation的右侧way的id位置
        rightwayids = map.way.inwayids(:,index_rightid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id3_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(1)));
        P_id3_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(1)))+2.72;
        %该way的另一端点id及其对应的坐标
        P_id4_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))));
        P_id4_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))))+2.72;
        if P_id3_lon < P_id4_lon  %判断前后关系
            P_rf_lat = P_id4_lat;
            P_rf_lon = P_id4_lon;
            P_rr_lat = P_id3_lat;
            P_rr_lon = P_id3_lon;
        else
            P_rf_lat = P_id3_lat;
            P_rf_lon = P_id3_lon;
            P_rr_lat = P_id4_lat;
            P_rr_lon = P_id4_lon;
        end
        j = str2double(relationname(i,6));  %确定该方向进入方向车道id
        if j == 1
            Cross.road3.lane1.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,1,1,0];
        elseif j == 2
            Cross.road3.lane2.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,1,1];
        elseif j == 3
            Cross.road3.lane3.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,1,1];
        end
    end
    
    if all(relationname(i,1:4) ==  'S_en')  %南方向驶出路口
        index_leftid = find(map.way.wayid == map.relation.leftwayid(i));  %确定该relation的左侧way的id位置
        leftwayids = map.way.inwayids(:,index_leftid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id1_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(1)));
        P_id1_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(1)));
        %该way的另一端点id及其对应的坐标
        P_id2_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))));
        P_id2_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))));
        if P_id1_lat > P_id2_lat  %判断前后关系
            P_lf_lat = P_id2_lat;
            P_lf_lon = P_id2_lon;
            P_lr_lat = P_id1_lat;
            P_lr_lon = P_id1_lon;
        else
            P_lf_lat = P_id1_lat;
            P_lf_lon = P_id1_lon;
            P_lr_lat = P_id2_lat;
            P_lr_lon = P_id2_lon;
        end
        index_rightid = find(map.way.wayid == map.relation.rightwayid(i));  %确定该relation的右侧way的id位置
        rightwayids = map.way.inwayids(:,index_rightid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id3_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(1)));
        P_id3_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(1)));
        %该way的另一端点id及其对应的坐标
        P_id4_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))));
        P_id4_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))));
        if P_id3_lat > P_id4_lat  %判断前后关系
            P_rf_lat = P_id4_lat;
            P_rf_lon = P_id4_lon;
            P_rr_lat = P_id3_lat;
            P_rr_lon = P_id3_lon;
        else
            P_rf_lat = P_id3_lat;
            P_rf_lon = P_id3_lon;
            P_rr_lat = P_id4_lat;
            P_rr_lon = P_id4_lon;
        end
        j = str2double(relationname(i,6));  %确定该方向进入方向车道id
        if j == 1
            Cross.road4.lane_1.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,0,0];
        elseif j == 2
            Cross.road4.lane_2.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,0,0];
        end
    end
    
    if all(relationname(i,1:4) ==  'S_ex')&&(relationname(i,7) ==  ' ')  %南方向驶入路口
        index_leftid = find(map.way.wayid == map.relation.leftwayid(i));  %确定该relation的左侧way的id位置
        leftwayids = map.way.inwayids(:,index_leftid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id1_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(1)))+2.08;
        P_id1_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(1)));
        %该way的另一端点id及其对应的坐标
        P_id2_lat = map.node.nodelat(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))))+2.08;
        P_id2_lon = map.node.nodelon(find(map.node.nodeid == leftwayids(sum(leftwayids~=0))));
        if P_id1_lat < P_id2_lat  %判断前后关系
            P_lf_lat = P_id2_lat;
            P_lf_lon = P_id2_lon;
            P_lr_lat = P_id1_lat;
            P_lr_lon = P_id1_lon;
        else
            P_lf_lat = P_id1_lat;
            P_lf_lon = P_id1_lon;
            P_lr_lat = P_id2_lat;
            P_lr_lon = P_id2_lon;
        end
        index_rightid = find(map.way.wayid == map.relation.rightwayid(i));  %确定该relation的右侧way的id位置
        rightwayids = map.way.inwayids(:,index_rightid);  %提取该way包含的所有node的id
        %该way的端点id及其对应的坐标
        P_id3_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(1)))+2.08;
        P_id3_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(1)));
        %该way的另一端点id及其对应的坐标
        P_id4_lat = map.node.nodelat(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))))+2.08;
        P_id4_lon = map.node.nodelon(find(map.node.nodeid == rightwayids(sum(rightwayids~=0))));
        if P_id3_lat < P_id4_lat  %判断前后关系
            P_rf_lat = P_id4_lat;
            P_rf_lon = P_id4_lon;
            P_rr_lat = P_id3_lat;
            P_rr_lon = P_id3_lon;
        else
            P_rf_lat = P_id3_lat;
            P_rf_lon = P_id3_lon;
            P_rr_lat = P_id4_lat;
            P_rr_lon = P_id4_lon;
        end
        j = str2double(relationname(i,6));  %确定该方向进入方向车道id
        if j == 1
            Cross.road4.lane1.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,1,1,1];
        elseif j == 2
            Cross.road4.lane2.Position = [P_lf_lon,P_lf_lat,P_lr_lon,P_lr_lat,P_rf_lon,P_rf_lat,P_rr_lon,P_rr_lat,0,1,1];
        end
    end
end

for i = 1:100
    if all(wayname(i,1:9) ==  'stop_line')  %停止线  14 46 56 61
        stoplineids = map.way.inwayids(:,i);  %提取该way包含的所有node的id
        s1_lat = map.node.nodelat(find(map.node.nodeid == stoplineids(1)));
        s1_lon = map.node.nodelon(find(map.node.nodeid == stoplineids(1)));
        s3_lat = map.node.nodelat(find(map.node.nodeid == stoplineids(sum(stoplineids~=0))));
        s3_lon = map.node.nodelon(find(map.node.nodeid == stoplineids(sum(stoplineids~=0))));
        s2_lat = 0.5 * (s1_lat + s3_lat);
        s2_lon = 0.5 * (s1_lon + s3_lon);
        if s2_lon<20 && s2_lon>16   %南边停止线
            Cross.road4.stopline.Position = [s1_lon,s1_lat,s2_lon,s2_lat,s3_lon,s3_lat];
        elseif s2_lon>20 %东边停止线
            Cross.road1.stopline.Position = [s1_lon,s1_lat,s2_lon,s2_lat,s3_lon,s3_lat];
        elseif s2_lon<0  %西边停止线
            Cross.road3.stopline.Position = [s1_lon,s1_lat,s2_lon,s2_lat,s3_lon,s3_lat];
        elseif s2_lon>5 && s2_lon<10 %北边停止线
            Cross.road2.stopline.Position = [s1_lon,s1_lat,s2_lon,s2_lat,s3_lon,s3_lat];
        end
    end
    
    if all(wayname(i,1:13) ==  'zebra_marking')
        zebraids = map.way.inwayids(:,i);  %提取该way包含的所有node的id
        z1_lat = map.node.nodelat(find(map.node.nodeid == zebraids(1)));
        z1_lon = map.node.nodelon(find(map.node.nodeid == zebraids(1)));
        z3_lat = map.node.nodelat(find(map.node.nodeid == zebraids(sum(zebraids~=0))));
        z3_lon = map.node.nodelon(find(map.node.nodeid == zebraids(sum(zebraids~=0))));
        z2_lat = 0.5 * (z1_lat + z3_lat);
        z2_lon = 0.5 * (z1_lon + z3_lon);
        if all(wayname(i,15:22) ==  'E_inside')
            if z1_lat<z3_lat
                Cross.road1.zebra_marking.Position2 = [z1_lon,z1_lat,z2_lon,z2_lat,z3_lon,z3_lat];
            else
                Cross.road1.zebra_marking.Position2 = [z3_lon,z3_lat,z2_lon,z2_lat,z1_lon,z1_lat];
            end
        elseif all(wayname(i,15:22) ==  'N_inside')
            if z1_lon>z3_lon
                Cross.road2.zebra_marking.Position2 = [z1_lon,z1_lat,z2_lon,z2_lat,z3_lon,z3_lat];
            else
                Cross.road2.zebra_marking.Position2 = [z3_lon,z3_lat,z2_lon,z2_lat,z1_lon,z1_lat];
            end
        elseif all(wayname(i,15:22) ==  'W_inside')
            if z1_lat>z3_lat
                Cross.road3.zebra_marking.Position2 = [z1_lon,z1_lat,z2_lon,z2_lat,z3_lon,z3_lat];
            else
                Cross.road3.zebra_marking.Position2 = [z3_lon,z3_lat,z2_lon,z2_lat,z1_lon,z1_lat];
            end
        elseif all(wayname(i,15:22) ==  'S_inside')
            if z1_lon<z3_lon
                Cross.road4.zebra_marking.Position2 = [z1_lon,z1_lat,z2_lon,z2_lat,z3_lon,z3_lat];
            else
                Cross.road4.zebra_marking.Position2 = [z3_lon,z3_lat,z2_lon,z2_lat,z1_lon,z1_lat];
            end
        end
        if all(wayname(i,15:23) ==  'E_outside')
            if z1_lat<z3_lat
                Cross.road1.zebra_marking.Position1 = [z1_lon,z1_lat,z2_lon,z2_lat,z3_lon,z3_lat];
            else
                Cross.road1.zebra_marking.Position1 = [z3_lon,z3_lat,z2_lon,z2_lat,z1_lon,z1_lat];
            end
        elseif all(wayname(i,15:23) ==  'N_outside')
            if z1_lon>z3_lon
                Cross.road2.zebra_marking.Position1 = [z1_lon,z1_lat,z2_lon,z2_lat,z3_lon,z3_lat];
            else
                Cross.road2.zebra_marking.Position1 = [z3_lon,z3_lat,z2_lon,z2_lat,z1_lon,z1_lat];
            end
        elseif all(wayname(i,15:23) ==  'W_outside')
            if z1_lat>z3_lat
                Cross.road3.zebra_marking.Position1 = [z1_lon,z1_lat,z2_lon,z2_lat,z3_lon,z3_lat];
            else
                Cross.road3.zebra_marking.Position1 = [z3_lon,z3_lat,z2_lon,z2_lat,z1_lon,z1_lat];
            end
        elseif all(wayname(i,15:23) ==  'S_outside')
            if z1_lon<z3_lon
                Cross.road4.zebra_marking.Position1 = [z1_lon,z1_lat,z2_lon,z2_lat,z3_lon,z3_lat];
            else
                Cross.road4.zebra_marking.Position1 = [z3_lon,z3_lat,z2_lon,z2_lat,z1_lon,z1_lat];
            end
        end
    end
        
end
% Cross.road1.region(1,:) = [Cross.road1.lane_3.Position(1,4),Cross.road1.lane3.Position(1,3),Cross.road1.lane3.Position(1,4),Cross.road1.lane_3.Position(1,3)];
% Cross.road1.region(2,:) = [Cross.road1.lane_3.Position(2,4),Cross.road1.lane3.Position(2,3),Cross.road1.lane3.Position(2,4),Cross.road1.lane_3.Position(2,3)];
% Cross.road2.region(1,:) = [Cross.road2.lane_2.Position(1,4),Cross.road2.lane2.Position(1,3),Cross.road2.lane2.Position(1,4),Cross.road2.lane_2.Position(1,3)];
% Cross.road2.region(2,:) = [Cross.road2.lane_2.Position(2,4),Cross.road2.lane2.Position(2,3),Cross.road2.lane2.Position(2,4),Cross.road2.lane_2.Position(2,3)];
% Cross.road3.region(2,:) = [Cross.road3.lane_3.Position(2,4),Cross.road3.lane3.Position(2,3),Cross.road3.lane3.Position(2,4),Cross.road3.lane_3.Position(2,3)];
% Cross.road3.region(2,:) = [Cross.road3.lane_3.Position(2,4),Cross.road3.lane3.Position(2,3),Cross.road3.lane3.Position(2,4),Cross.road3.lane_3.Position(2,3)];
% Cross.road4.region(1,:) = [Cross.road4.lane_2.Position(1,4),Cross.road4.lane2.Position(1,3),Cross.road4.lane2.Position(1,4),Cross.road4.lane_2.Position(1,3)];
% Cross.road4.region(2,:) = [Cross.road4.lane_2.Position(2,4),Cross.road4.lane2.Position(2,3),Cross.road4.lane2.Position(2,4),Cross.road4.lane_2.Position(2,3)];