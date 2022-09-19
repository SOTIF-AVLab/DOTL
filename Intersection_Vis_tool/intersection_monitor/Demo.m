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
load('Cross.mat')
load('Crossbus.mat')
%%
tic
I = unique(Data.track_id(strcmp(Data.agent_type, 'car')&Data.vx~=0));
[EGO,TGT,LIGHT,PED]=DataTransUnique(recording,Data,I(20),lightinfo,Peddata);    
for idx=1:7  %按照他车数量修改BUS中的维度
    TGTbus.Elements(idx).Dimensions=[length(TGT.TgtX.TgtX(1,:)) 1];
end
for idx=1:4  %按照他车数量修改BUS中的维度
    Pedbus.Elements(idx).Dimensions=[length(PED.PX.PX(1,:)) 1];
end
toc
disp('该ID持续时间为：')
disp(EGO.length.Time(end))

%%

%simout=parsim(in);



