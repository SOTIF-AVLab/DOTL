# Intersection_Vis_Tool
We provide a Matlab program to monitor the violation status of vehicle in intersection, and a Python program to visualize the monitoring results. These programs are written based on the format definition of SinD dataset. You can select one of the dataset, and choose an ID in this dataset as ego vehicle. Then, the visual program will reproduce relevant scenes and display the monitoring results in real time.

## Code instruction
The structure of Intersection_Vis_tool is as follows. Main program of monitor is `Demo.m`. user needs to input the Ego id. This id will be set as ego vehicle. Main program of visualization is `VisMain.py`. The data folder contains sample datasets that you can try. 
```
 |- Data
 |- doc
 |- intersection_monitor
    |- rule_intersection.slx
    |- Demo.m
 |- utils
    |- _init_.py
    |- DataReader.py
    |- dict_utils.py
    |- map_vis_lanelet2.py
    |- map_vis_without_lanelet.py
    |- Mat2CSV.m
 |- intersection_visualizer.py
 |- VisMain.py
 |- format.md
 |- LICENSE
 |- requirements.txt 
```

## Operating Instruction

### Python package Installation
The package required for the program to run is shown in the `requirements.txt` file, and you can install them by：`pip3 install -r requirements.txt`  
This Track Visualizer is tested with Python 3.6 and 3.8 but is very probably compatible with newer or slightly older releases.  
In addition to this, we recommend installing the [lanelet2](https://github.com/fzi-forschungszentrum-informatik/Lanelet2) module, which provides a convenient HD map API, and allows better visualization and ease of use of map information.  

### Usage
* copy/download the SIND dataset into the right place
  * copy/download the track files into the folder `data`, keep one folder per record, as in your download
  * your folder structure should look like in [File-Directory.md](https://github.com/SOTIF-AVLab/SinD/blob/main/doc/File-Directory.md)
* to visualize the data
  * run Demo.m under the folder of intersection_visualizer. This generate the monitoring result of specific traffic participant.
  * run Mat2CSV.m under the folder of utils to generate corresponding .CSV file that contains the results of traffic violation. The main vis-tool will use this .CSV to plot the violation track. 
  * run `./VisMain.py <data_path (default= ../Data)> <record_name (default= 8_02_1)>` from this folder directory to visualize the recorded data. 

### `Demo.m`
This module allows user to select the dataset, and then to select the id and type ("car", "motorcycle") of ego vehicle. Afterward, user could run this file to get the violation status of the ego vehicle. 

### `DataReader.py`
This module allows to read either the tracks, static track info, traffic light states and recording meta info by respective function, and by calling `read_tracks_all(path)` to read a total recording info. 

### `VisMain.py`
This module uses the `intersection_visualizer.py` to create a gui to playback the provided recordings. In the visualization, traffic participants (vehicles and pedestrians) are presented as rectangular boxes. By clicking a rectangular box with the mouse, multiple graphs showing the changes of the parameters corresponding to the motion state of the traffic participants can pop up. 
The script has many different parameters, which are listed and explained in the `VisMain.py` file itself. The most 
important parameter is the `recording_name`, which specifies the recording to be loaded. 

<div align=center>
<img src="https://github.com/SOTIF-AVLab/DOTL/blob/main/Intersection_Vis_tool/doc/Visualization.jpg" width =800>
</div>

<div align=center>
<img src="https://github.com/SOTIF-AVLab/SinD/blob/main/doc/motion-parameters.jpg" width = 800>  
</div>
