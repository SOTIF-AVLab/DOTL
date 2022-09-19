# Intersection Vis Tool


We provide a Matlab program to monitor the violation status of traffic participants and a Python program to visualize the monitoring results. 

## Python package Installation
The package required for the program to run is shown in the `requirements.txt` file, and you can install them by：`pip3 install -r requirements.txt`  
This Track Visualizer is tested with Python 3.6 and 3.8 but is very probably compatible with newer or slightly older releases.  
In addition to this, we recommend installing the [lanelet2](https://github.com/fzi-forschungszentrum-informatik/Lanelet2) module, which provides a convenient HD map API, and allows better visualization and ease of use of map information.  

## Usage
* copy/download the SIND dataset into the right place
  * copy/download the track files into the folder `data`, keep one folder per record, as in your download
  * your folder structure should look like in [File-Directory.md](https://github.com/SOTIF-AVLab/SinD/blob/main/doc/File-Directory.md)
* to visualize the data
  * run Demo.m under the folder of intersection_visualizer. This generate the monitoring result of specific traffic participant.
  * run Mat2CSV.m under the folder of utils to generate corresponding .CSV file that contains the results of traffic violation. The main vis-tool will use this .CSV to plot the violation track. 
  * run `./VisMain.py <data_path (default= ../Data)> <record_name (default= 8_02_1)>` from this folder directory to visualize the recorded data. 

## Module Description
### `Demo.m`
This module allows user to select the id and type ("car", "motorcycle") of ego vehicle. Afterward, user could run this file to get the violation status of the ego vehicle. 

### `rule_intersection.slx`
This module is the main violation monitoring program built in Simulink. Users could examine the selected traffic participants' violation status, including stop-line, right-of-way, virtual-lane following, etc. 

### `DataReader.py`
This module allows to read either the tracks, static track info, traffic light states and recording meta info by respective function, and by calling `read_tracks_all(path)` to read a total recording info. 

### `VisMain.py`
This module uses the `intersection_visualizer.py` to create a gui to playback the provided recordings. In the visualization, traffic participants (vehicles and pedestrians) are presented as rectangular boxes. By clicking a rectangular box with the mouse, multiple graphs showing the changes of the parameters corresponding to the motion state of the traffic participants can pop up. 
The script has many different parameters, which are listed and explained in the `VisMain.py` file itself. The most 
important parameter is the `recording_name`, which specifies the recording to be loaded. 

<div align=center>
<img src="https://github.com/SOTIF-AVLab/Digitalization-of-regulations/tree/main/Intersection_Vis_tool/doc/Visualization.jpg" width =200><img src="https://github.com/SOTIF-AVLab/SinD/blob/main/doc/motion-parameters.jpg" width = 800>  
</div>  

