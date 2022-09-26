# Highway_Vis_tool
The monitoring program and visual program of highway are both written in MATLAB. These programs are written based on the format definition of DJI's AD4CHE dataset. You can select one of the dataset, and choose an ID in this dataset as ego vehicle. Then, the visual program will reproduce relevant scenes and display the monitoring results in real time.

## Code instruction
Main program is Highway_Vis_tool/startVisualization.m. Before running it, set the "videoString" and "selectid". This selectid will be set as ego vehicle.

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
