# Highway_Vis_tool
The monitoring program and visual program of highway are both written in MATLAB. These programs are written based on the format definition of DJI's AD4CHE dataset. You can select one of the dataset, and choose an ID in this dataset as ego vehicle. Then, the visual program will reproduce relevant scenes and display the monitoring results in real time.

## Code instruction
The structure of Highway_Vis_tool is as follows. Main program is `startVisualization.m`. You can select dataset and vehicle ID from here. The data folder contains sample datasets that you can try. The DJ_monitor folder contains monitoring program to monitor the ID you select. The utils and visualization folder contains Callback functions used by visual program.

```
 |- startVisualization.m
 |- data
 |- DJ_monitor
    |- simulate.m
    |- rule_DJ.slx
    |- DataTransUnique.m
    |- laneget.m
    |- EgoBUS.mat
    |- TgtBUS.mat
 |- utils
    |- plotHighway.m
    |- plotTracksO.m
    |- plotTracksOnImage.m
    |- readInTracksCsv.m
    |- readInVideoCsv.m
 |- visualization
    |- trackVisualization.fig
    |- trackVisualization.m
 |- initialize.m
```

## Operating Instruction
Ensure that all files and folders are located in the working path. Before running it, open the `startVisualization.m`, set the "videoString" and "selectid".

```
% Name of the video, for example, DJI_0044 is "44";
videoString = "44";
%Select the ID of vehicle. You can consult the `xx_track.csv` file to find the vehicle ID contained in the dataset.
selectID = 15150; 
```

Then, run the `startVisualization.m`, and you can get the visual interface.

<div align=center>
<img src="https://github.com/SOTIF-AVLab/DOTL/blob/main/Doc/video.jpg" width = 600>
</div> 
