clear

Filename="D:\OneDrive - Imperial College London\Imperial college london-Kevi023XPS\Year_Three\TsinghuaUniverisitySelfDriving\法规数字化\intersection\dataset\8_2_1\Veh_smoothed_tracks.csv";
filename=char(Filename);
recordingfile=[filename(1:end-23) 'recoding_metas.csv']; % 记录信息文件地址
recording=readtable(recordingfile);   %读取记录信息
pedestrainfile = char("D:\OneDrive - Imperial College London\Imperial college london-Kevi023XPS\Year_Three\TsinghuaUniverisitySelfDriving\法规数字化\intersection\dataset\8_2_1\Ped_smoothed_tracks.csv");
Peddata = readtable(pedestrainfile);  % 读取行人数据集
lightfile = [filename(1:end-23) 'TrafficLight_8_02_1.csv']; % 记录红绿灯信息文件地址
lightinfo = readtable(lightfile);
Data=readtable(Filename);  % 读取数据集
%%
mdl='rule_intersection';
load_system(mdl);

load('Cross.mat')
load('Crossbus.mat')
in = Simulink.SimulationInput(mdl);
mdl='rule_intersection';
in=Simulink.SimulationInput(mdl); %max(Data.id)
in=in.setVariable('road1',road1);
in=in.setVariable('road2',road2);
in=in.setVariable('road3',road3);
in=in.setVariable('road4',road4);
in=in.setVariable('CROSS',CROSS);
in=in.setVariable('EGObus',EGObus);
in=in.setVariable('TGTbus',TGTbus);
in=in.setVariable('Light',Light);
in=in.setVariable('Pedbus',Pedbus);
in=in.setVariable('Cross.road4.lane_1.Position',Cross.road4.lane_1.Position);
%%
I = unique(Data.track_id(strcmp(Data.agent_type, 'car')&Data.vx~=0));
[EGO,TGT,LIGHT,PED]=DataTransUnique(recording,Data,I(20),lightinfo,Peddata);    
in = in.setVariable('EGO', EGO);
in = in.setVariable('TGT', TGT);
in = in.setVariable('LIGHT', LIGHT);
in = in.setVariable('PED', PED);
in=in.setModelParameter('StopTime',num2str(seconds(EGO.length.Time(end))));

for idx=1:7  %按照他车数量修改BUS中的维度
    in.Variables(1,7).Value.Elements(idx).Dimensions=[length(in.Variables(1,12).Value.TgtX.TgtX(1,:)) 1];
end
for idx=1:4  %按照他车数量修改BUS中的维度
    in.Variables(1,9).Value.Elements(idx).Dimensions=[length(in.Variables(1,14).Value.PX.PX(1,:)) 1];
end
disp('该ID持续时间为：')
disp(EGO.length.Time(end))

%%

monitor_simout=sim(in);
