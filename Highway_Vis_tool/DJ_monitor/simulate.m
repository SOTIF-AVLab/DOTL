function [monitor_flag,monitor_simout] = simulate(Filename,recordingfile,ImagePath,selectid)

recording=readtable(recordingfile);   %读取记录信息
Data=readtable(Filename);  % 读取数据集
[LaneX,LaneY]=laneget(ImagePath);
y = zeros(10,4);
for i = 1:10
y(i,:) = polyfit(LaneX, LaneY(i,:), 3);
end
%%
I = unique(Data.id);

I = I(selectid);

mdl='rule_DJ';
load_system(mdl);
% inI=Simulink.SimulationInput(mdl);
% simout(max(Data.id))=Simulink.SimulationOutput;
load('EgoBUS.mat')
load('TgtBUS.mat')
in=Simulink.SimulationInput(mdl); %max(Data.id)
in=in.setVariable('EgoBUS',EgoBUS);
in=in.setVariable('TgtBUS',TgtBUS);
%%
[EGO,TGT]=DataTransUnique(recording,Data,I);
in=in.setVariable('EGO',EGO);
in=in.setVariable('TGT',TGT);
in=in.setVariable('y',y);
in=in.setModelParameter('StopTime',num2str(seconds(TGT.ID.Time(end))));
%%
for idx=1:11  %按照他车数量修改BUS中的维度
    in.Variables(1,2).Value.Elements(idx).Dimensions=[length(in.Variables(1,4).Value.ID.ID(1,:)) 1];
end
%%
monitor_simout=sim(in);
%% 计算违规区间
monitor_flag = sum(monitor_simout.monitor_result.Data,2)~=0;
