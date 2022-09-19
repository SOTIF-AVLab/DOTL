function [Ego,Tgt,light,Ped]=DataTransUnique(recording,Data,EgoID,lightinfo,Peddata)
%% 读取HighD数据集，并将指定的EgoID的车辆作为自车，其周车辆为他车，输出Ego和TargetVehicle
%{
其中，
Filename为highD数据集中tracks.csv文件的绝对路径；
EgoID为该数据集中作为自车的指定的车辆ID。
示例：
Filename="U:\highD-dataset-v1.0\data\01_tracks.csv"
EgoID=1;

Ego和Tgt为输出的struct，按照所给的excel中的总线定义定义的各层变量，
各变量为依据数据集采样频率计算的timetable数组。
其中他车的最低层变量为在各采样时刻（time）当前所有他车数据的数组，其中每一列为一辆车
ID为0的列不存在车，后续对应的数据不应计算在内

20220228，于文浩
修改了他车数据排列，将输出的数据定义为所涉及的帧的所有ID，不存在的数据为0

%}

EgoFlag=Data.track_id==EgoID;
motorflag=~strcmp(Data.agent_type, 'bicycle');
frame=Data.frame_id(EgoFlag); %获取对应的自车ID所在的帧
EgoX = Data.x(EgoFlag);
EgoY = Data.y(EgoFlag);
if ~isempty(frame)  %如果frame非空
    % 通过循环按照帧序依次读取数据，合成总线数据
    ID=0;
    PID=0;
    for idx=1:(max(frame)-min(frame))  %从最小帧到最大帧，由于不会跳变，一般都是连续的。
        id=Data.track_id(Data.frame_id==frame(idx)&~EgoFlag);  %当前帧且不为自车的数据
        ID=unique([id;ID]);                  %获取所有帧涉及到的他车ID
        pid = Peddata.track_id(Peddata.frame_id==frame(idx));
        for i = 1:length(pid)
            kk = cell2mat(pid(i));
            Pid(i) = str2num(kk(:,2:end));
        end
        PID = unique([Pid';PID]);
    end
    ID(1)=[];%去掉第一个是0的他车ID
    PID(1)=[];
    [road_start,~,~] = locate(EgoX(1),EgoY(1));
    [road_end,~,~] = locate(EgoX(end),EgoY(end));
    m1 = [road_start+2,road_start-2];
    m2 = [road_start+1,road_start-3];
    m3 = [road_start+3,road_start-1];
    flag1 = m1>0 & m1<5;
    flag2 = m2>0 & m2<5;
    flag3 = m3>0 & m3<5;
    m1 = m1(flag1);
    m2 = m2(flag2);
    m3 = m3(flag3);
    if road_start == 0
        decision = 0;
    elseif road_end == m1  %决策直行
        decision = 1;
    elseif road_end == m2  %决策右转
        decision = 2;
    elseif road_end == m3  %决策左转
        decision = 3;
    else
        decision = 0;
    end
    for idx=1:(max(frame)-min(frame))  %从最小帧到最大帧，由于不会跳变，一般都是连续的。
        % 依照帧序获取自车数据
        %         fprintf('%d\n',idx);
        Ego.length(idx,1)=Data.length(Data.frame_id==frame(idx)&EgoFlag); % 当前帧且为自车的数据
        Ego.width(idx,1)=Data.width(Data.frame_id==frame(idx)&EgoFlag);
        Ego.EgoX(idx,1)=Data.x((Data.frame_id==frame(idx)&EgoFlag));
        Ego.EgoY(idx,1)=Data.y((Data.frame_id==frame(idx)&EgoFlag));
        Ego.Egovx(idx,1)=Data.vx((Data.frame_id==frame(idx)&EgoFlag));
        Ego.Egovy(idx,1)=Data.vy((Data.frame_id==frame(idx)&EgoFlag));
        Ego.Egotheta(idx,1)=Data.yaw_rad((Data.frame_id==frame(idx)&EgoFlag));
        Ego.Decision(idx,1)=decision;
        % 他车
%        Tgt.ID(idx,:)=ID;
        tgtid=Data.track_id(Data.frame_id==frame(idx)&~EgoFlag&motorflag); %获取当前帧的id
        idflag=repmat(tgtid,1,length(ID))==repmat(ID',length(tgtid),1);%构建ID等长的列，id等长的行的标记矩阵；
%        Tgt.ID(idx,:)=Data.track_id(Data.frame_id==frame(idx)&~EgoFlag)'*idflag;
        Tgt.TgtX(idx,:)=Data.x(Data.frame_id==frame(idx)&~EgoFlag&motorflag)'*idflag;
        Tgt.TgtY(idx,:)=Data.y(Data.frame_id==frame(idx)&~EgoFlag&motorflag)'*idflag;
        Tgt.Tgtvx(idx,:)=Data.vx(Data.frame_id==frame(idx)&~EgoFlag&motorflag)'*idflag;
        Tgt.Tgtvy(idx,:)=Data.vy(Data.frame_id==frame(idx)&~EgoFlag&motorflag)'*idflag;
        Tgt.Tgttheta(idx,:)=Data.yaw_rad(Data.frame_id==frame(idx)&~EgoFlag&motorflag)'*idflag;
        Tgt.length(idx,:)=Data.length(Data.frame_id==frame(idx)&~EgoFlag&motorflag)'*idflag;
        Tgt.width(idx,:)=Data.width(Data.frame_id==frame(idx)&~EgoFlag&motorflag)'*idflag;
        %红绿灯
        light.light1(idx,:)=lightinfo.TrafficLight2(find(lightinfo.RawFrameID/3<=frame(idx), 1, 'last' ));
        light.light2(idx,:)=lightinfo.TrafficLight1(find(lightinfo.RawFrameID/3<=frame(idx), 1, 'last' ));
        light.light3(idx,:)=lightinfo.TrafficLight2(find(lightinfo.RawFrameID/3<=frame(idx), 1, 'last' ));
        light.light4(idx,:)=lightinfo.TrafficLight1(find(lightinfo.RawFrameID/3<=frame(idx), 1, 'last' ));
        %行人
        pedid=Peddata.track_id(Peddata.frame_id==frame(idx)); %获取当前帧的id
        Pedid = zeros(length(pedid),1);
        for i = 1:length(pedid)
            kk = cell2mat(pedid(i));
            Pedid(i) = str2num(kk(:,2:end));
        end
        pedid = unique(Pedid);
        pedidflag=repmat(pedid,1,length(PID))==repmat(PID',length(pedid),1);%构建ID等长的列，id等长的行的标记矩阵；
        Ped.PX(idx,:)=Peddata.x(Peddata.frame_id==frame(idx))'*pedidflag;
        Ped.PY(idx,:)=Peddata.y(Peddata.frame_id==frame(idx))'*pedidflag;
        Ped.Pvx(idx,:)=Peddata.vx(Peddata.frame_id==frame(idx))'*pedidflag;
        Ped.Pvy(idx,:)=Peddata.vy(Peddata.frame_id==frame(idx))'*pedidflag;
    end
    % 转化为timetable
    frameRate = round(recording.RawFrameRate)/3;
    Ego.width=timetable(Ego.width,'SampleRate',frameRate);
    Ego.length=timetable(Ego.length,'SampleRate',frameRate);
    Ego.EgoX=timetable(Ego.EgoX,'SampleRate',frameRate);
    Ego.EgoY=timetable(Ego.EgoY,'SampleRate',frameRate);
    Ego.Egovx=timetable(Ego.Egovx,'SampleRate',frameRate);
    Ego.Egovy=timetable(Ego.Egovy,'SampleRate',frameRate);
    Ego.Egotheta=timetable(Ego.Egotheta,'SampleRate',frameRate);
    Ego.Decision=timetable(Ego.Decision,'SampleRate',frameRate);
    % 修改变量名
    Ego.width.Properties.VariableNames = {'width'};
    Ego.length.Properties.VariableNames = {'length'};
    Ego.EgoX.Properties.VariableNames = {'EgoX'};
    Ego.EgoY.Properties.VariableNames = {'EgoY'};
    Ego.Egovx.Properties.VariableNames = {'Egovx'};
    Ego.Egovy.Properties.VariableNames = {'Egovy'};
    Ego.Egotheta.Properties.VariableNames = {'Egotheta'};
    Ego.Decision.Properties.VariableNames = {'Decision'};
    % 他车
    Tgt.TgtX=timetable(Tgt.TgtX,'SampleRate',frameRate);
    Tgt.TgtY=timetable(Tgt.TgtY,'SampleRate',frameRate);
    Tgt.Tgtvx=timetable(Tgt.Tgtvx,'SampleRate',frameRate);
    Tgt.Tgtvy=timetable(Tgt.Tgtvy,'SampleRate',frameRate);
    Tgt.Tgttheta=timetable(Tgt.Tgttheta,'SampleRate',frameRate);
    Tgt.width=timetable(Tgt.width,'SampleRate',frameRate);
    Tgt.length=timetable(Tgt.length,'SampleRate',frameRate);
    Tgt.TgtX.Properties.VariableNames = {'TgtX'};
    Tgt.TgtY.Properties.VariableNames = {'TgtY'};
    Tgt.Tgtvx.Properties.VariableNames = {'Tgtvx'};
    Tgt.Tgtvy.Properties.VariableNames = {'Tgtvy'};
    Tgt.Tgttheta.Properties.VariableNames = {'Tgttheta'};
    Tgt.width.Properties.VariableNames = {'width'};
    Tgt.length.Properties.VariableNames = {'length'};
    
    light.light1=timetable(light.light1,'SampleRate',frameRate);
    light.light2=timetable(light.light2,'SampleRate',frameRate);
    light.light3=timetable(light.light3,'SampleRate',frameRate);
    light.light4=timetable(light.light4,'SampleRate',frameRate);
    light.light1.Properties.VariableNames = {'light1'};
    light.light2.Properties.VariableNames = {'light2'};
    light.light3.Properties.VariableNames = {'light3'};
    light.light4.Properties.VariableNames = {'light4'};
    
    Ped.PX=timetable(Ped.PX,'SampleRate',frameRate);
    Ped.PY=timetable(Ped.PY,'SampleRate',frameRate);
    Ped.Pvx=timetable(Ped.Pvx,'SampleRate',frameRate);
    Ped.Pvy=timetable(Ped.Pvy,'SampleRate',frameRate);
    Ped.PX.Properties.VariableNames = {'PX'};
    Ped.PY.Properties.VariableNames = {'PY'};
    Ped.Pvx.Properties.VariableNames = {'Pvx'};
    Ped.Pvy.Properties.VariableNames = {'Pvy'};
else
    fprintf('未找到对应ID的车辆，当前数据集最大的车辆ID为%d\n',max(Data.track_id))
end


















