function [Ego,Tgt]=DataTransUniqe(recording,Data,EgoID)
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

EgoFlag=Data.id==EgoID;
frame=Data.frame(EgoFlag); %获取对应的自车ID所在的帧

if ~isempty(frame)  %如果frame非空
    % 通过循环按照帧序依次读取数据，合成总线数据
    ID=0;
    for idx=1:(max(frame)-min(frame))  %从最小帧到最大帧，由于不会跳变，一般都是连续的。
        id=Data.id(Data.frame==frame(idx)&~EgoFlag);  %当前帧且不为自车的数据
        ID=unique([id;ID]);                  %获取所有帧涉及到的他车ID
    end
    ID(1)=[];%去掉第一个是0的他车ID
    for idx=1:(max(frame)-min(frame))  %从最小帧到最大帧，由于不会跳变，一般都是连续的。
        % 依照帧序获取自车数据
        %         fprintf('%d\n',idx);
        Ego.Mass(idx,1)=0;
        Ego.Length(idx,1)=Data.width(Data.frame==frame(idx)&EgoFlag); % 当前帧且为自车的数据
        Ego.Width(idx,1)=Data.height(Data.frame==frame(idx)&EgoFlag);
        Ego.a(idx,1)=0;  %simulink中不可以出现NaN
        Ego.b(idx,1)=0;
        Ego.EgoX(idx,1)=Data.x((Data.frame==frame(idx)&EgoFlag));
%        Ego.EgoX(idx,1) = Ego.EgoX(idx,1) + 0.5 * Ego.Length(idx,1);
        Ego.EgoY(idx,1)=Data.y((Data.frame==frame(idx)&EgoFlag));
%        Ego.EgoY(idx,1) = Ego.EgoY(idx,1) + 0.5 * Ego.Width(idx,1);
        Ego.EgoVx(idx,1)=Data.xVelocity((Data.frame==frame(idx)&EgoFlag));
        Ego.EgoVy(idx,1)=Data.yVelocity((Data.frame==frame(idx)&EgoFlag));
        Ego.EgoTheta(idx,1)=0;
        Ego.EgoAccX(idx,1)=0;
        Ego.EgoAccY(idx,1)=0;
        % 他车
        Tgt.ID(idx,:)=ID;
        tgtid=Data.id(Data.frame==frame(idx)&~EgoFlag); %获取当前帧的id
        idflag=repmat(tgtid,1,length(ID))==repmat(ID',length(tgtid),1);%构建ID等长的列，id等长的行的标记矩阵；
        Tgt.ID(idx,:)=Data.id(Data.frame==frame(idx)&~EgoFlag)'*idflag;
        Tgt.TgtX(idx,:)=Data.x(Data.frame==frame(idx)&~EgoFlag)'*idflag;
        Tgt.TgtY(idx,:)=Data.y(Data.frame==frame(idx)&~EgoFlag)'*idflag;
        Tgt.TgtVx(idx,:)=Data.xVelocity(Data.frame==frame(idx)&~EgoFlag)'*idflag;
        Tgt.TgtVy(idx,:)=Data.yVelocity(Data.frame==frame(idx)&~EgoFlag)'*idflag;
        Tgt.Theta(idx,:)=zeros(1,length(ID));
        Tgt.Length(idx,:)=Data.width(Data.frame==frame(idx)&~EgoFlag)'*idflag;
        Tgt.Width(idx,:)=Data.height(Data.frame==frame(idx)&~EgoFlag)'*idflag;
        Tgt.TgtAccX(idx,:)=zeros(1,length(ID));
        Tgt.TgtAccY(idx,:)=zeros(1,length(ID));
        Tgt.TgtX(idx,:) = Tgt.TgtX(idx,:) + 0.5 * Tgt.Length(idx,:);
        Tgt.TgtY(idx,:) = Tgt.TgtY(idx,:) + 0.5 * Tgt.Width(idx,:);
        
    end
    % 转化为timetable
    Ego.Mass=timetable(Ego.Mass,'SampleRate',recording.frameRate);
    Ego.Width=timetable(Ego.Width,'SampleRate',recording.frameRate);
    Ego.Length=timetable(Ego.Length,'SampleRate',recording.frameRate);
    Ego.a=timetable(Ego.a,'SampleRate',recording.frameRate);
    Ego.b=timetable(Ego.b,'SampleRate',recording.frameRate);
    Ego.EgoX=timetable(Ego.EgoX,'SampleRate',recording.frameRate);
    Ego.EgoY=timetable(Ego.EgoY,'SampleRate',recording.frameRate);
    Ego.EgoVx=timetable(Ego.EgoVx,'SampleRate',recording.frameRate);
    Ego.EgoVy=timetable(Ego.EgoVy,'SampleRate',recording.frameRate);
    Ego.EgoTheta=timetable(Ego.EgoTheta,'SampleRate',recording.frameRate);
    Ego.EgoAccX=timetable(Ego.EgoAccX,'SampleRate',recording.frameRate);
    Ego.EgoAccY=timetable(Ego.EgoAccY,'SampleRate',recording.frameRate);
    % 修改变量名
    Ego.Mass.Properties.VariableNames = {'Mass'};
    Ego.Width.Properties.VariableNames = {'Width'};
    Ego.Length.Properties.VariableNames = {'Length'};
    Ego.a.Properties.VariableNames = {'a'};
    Ego.b.Properties.VariableNames = {'b'};
    Ego.EgoX.Properties.VariableNames = {'EgoX'};
    Ego.EgoY.Properties.VariableNames = {'EgoY'};
    Ego.EgoVx.Properties.VariableNames = {'EgoVx'};
    Ego.EgoVy.Properties.VariableNames = {'EgoVy'};
    Ego.EgoTheta.Properties.VariableNames = {'EgoTheta'};
    Ego.EgoAccX.Properties.VariableNames = {'EgoAccX'};
    Ego.EgoAccY.Properties.VariableNames = {'EgoAccY'};
    % 他车
    Tgt.ID=timetable(Tgt.ID,'SampleRate',recording.frameRate);
    Tgt.TgtX=timetable(Tgt.TgtX,'SampleRate',recording.frameRate);
    Tgt.TgtY=timetable(Tgt.TgtY,'SampleRate',recording.frameRate);
    Tgt.TgtVx=timetable(Tgt.TgtVx,'SampleRate',recording.frameRate);
    Tgt.TgtVy=timetable(Tgt.TgtVy,'SampleRate',recording.frameRate);
    Tgt.Theta=timetable(Tgt.Theta,'SampleRate',recording.frameRate);
    Tgt.Width=timetable(Tgt.Width,'SampleRate',recording.frameRate);
    Tgt.Length=timetable(Tgt.Length,'SampleRate',recording.frameRate);
    Tgt.TgtAccX=timetable(Tgt.TgtAccX,'SampleRate',recording.frameRate);
    Tgt.TgtAccY=timetable(Tgt.TgtAccY,'SampleRate',recording.frameRate);
    Tgt.ID.Properties.VariableNames = {'ID'};
    Tgt.TgtX.Properties.VariableNames = {'TgtX'};
    Tgt.TgtY.Properties.VariableNames = {'TgtY'};
    Tgt.TgtVx.Properties.VariableNames = {'TgtVx'};
    Tgt.TgtVy.Properties.VariableNames = {'TgtVy'};
    Tgt.Theta.Properties.VariableNames = {'Theta'};
    Tgt.Width.Properties.VariableNames = {'Width'};
    Tgt.Length.Properties.VariableNames = {'Length'};
    Tgt.TgtAccX.Properties.VariableNames = {'TgtAccX'};
    Tgt.TgtAccY.Properties.VariableNames = {'TgtAccY'};
else
    fprintf('未找到对应ID的车辆，当前数据集最大的车辆ID为%d\n',max(Data.id))
end


















