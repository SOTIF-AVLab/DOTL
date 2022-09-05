clc; clear;

%Set up videoString to select datasets to visualize
%Set up selectid to select this id as Ego vehicle

% Name of the video
videoString = "44";
%选择车辆的ID
selectID = 15150; 

% Define path of background image. Can be empty.%读取背景图
%backgroundImagePath = sprintf('data/%s_highway.jpg', videoString);
backgroundImagePath = sprintf('data/DJI_00%s/%s_backgroundpics.jpg',videoString, videoString);
% backgroundImagePath = "";
%读取车道图
ImagePath = sprintf('data/DJI_00%s/%s_laneWidthColorAndID.png',videoString, videoString);

% Read tracks by using tracks file and static tracks file.
%tracksFilename = sprintf('data/%s_tracks.csv', videoString);
tracksFilename = sprintf('data/DJI_00%s/%s_tracks.csv',videoString, videoString);
%tracksStaticFilename = sprintf('data/%s_tracksMeta.csv', videoString);
tracksStaticFilename = sprintf('data/DJI_00%s/%s_tracksMeta.csv',videoString, videoString);
[tracks,selectid] = readInTracksCsv(tracksFilename, tracksStaticFilename,selectID);
% Read video meta data from video meta file
%videoMetaFilename = sprintf('data/%s_recordingMeta.csv', videoString);
videoMetaFilename = sprintf('data/DJI_00%s/%s_recordingMeta.csv',videoString, videoString);
videoMeta = readInVideoCsv(videoMetaFilename);

% The visualization needs the tracks, the videoMeta data and the
% backgroundImagePath (which can be empty). 
argumentsInput.tracks = tracks;
argumentsInput.videoMeta = videoMeta;
argumentsInput.backgroundImagePath = backgroundImagePath;

argumentsInput.selectid = selectid;

% Plot variables initialization. These are the default values. Please use
% them or modify them for your own purpose.
argumentsInput.removingList = [];
argumentsInput.trackWidth = 408; % Width of the video frame
argumentsInput.laneThickness = 5.3; % thickness of the lane markings
argumentsInput.laneColor = [1 1 1]; % color of the lane markings (white)
argumentsInput.currentFrame = tracks(selectid).initialFrame; % Starting frame
argumentsInput.minimumFrame = tracks(selectid).initialFrame; % Minimum frame that exists (1)
argumentsInput.maximumFrame = tracks(selectid).finalFrame-1; % Maximum frame
argumentsInput.playRate = 1; % The play rate (going "playRate" steps forward)
argumentsInput.stop = false; % Boolean for 
argumentsInput.streetColor = [0.6 0.6 0.6]; % The street color 
argumentsInput.boundingBoxColor = [1 0 0]; % The color of the bounding box
argumentsInput.plotTextAnnotation = true; % Whether the text annotations shall be plotted
argumentsInput.plotTrackingLine = true; % Whether the tracking line shall be plotted

argumentsInput.geoParams.meterPerPixel = 0.10106;
argumentsInput.geoParams.kmhPerPixelFrame = 9.0954;

%跑监测程序
[monitor_flag,monitor_simout] = simulate(tracksFilename,videoMetaFilename,ImagePath,selectid);
argumentsInput.monitor_flag = monitor_flag;
argumentsInput.monitor_simout = monitor_simout;

% Start the visualization
trackVisualization(argumentsInput);