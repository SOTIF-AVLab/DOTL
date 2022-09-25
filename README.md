# Digitalization of Traffic law
## Introduction
Safety is the primary issue facing the commercialization of autonomous vehicles,traffic laws are a powerful means of ensuring vehicle safety and important evidence for the traceability of accidents. However, the ambiguity of language laws for human drivers and the complexity of dynamic and static multi-constraint coupling scenarios bring severe challenges to compliance research and are the key problems hindering the safe development of autonomous driving. This research intends to start with the research on the systematic digitalization of traffic laws, explore the influence filed of vehicle behaviors, select the reasonable compliance judgment thresholds, and then research the real-time compliance monitoring methods.

<div align=center>
<img src="Doc/architecture.png" width = 800>
</div> 

## Relevant research contents

1) We classified and refined 25 regulations related to driving in the regulations for the implementation of the road traffic safety law of the people's Republic of China, explored the semantic logic and constraint types of road regulations, defined atomic propositions, and built a multi-level trigger domain digital description model of regulations by building MTL formulas;
2) Build a real-time monitoring model of vehicle compliance based on the constraints of digital road regulations;
3) Based on the Chinese data set, the impact field of vehicle behavior with Chinese characteristics is explored, the compliance judgment threshold selection strategy is given, and the rationality and consistency of compliance monitoring and decision-making are verified.

<div align=center>
<img src="Doc/click image.png" width = 800>
</div> 

## Demo and instructions
We provide the monitoring program code of highway and intersection related rules written in MATLAB. At the same time, we also provide a visualization program of the relevant data set, so that the compliance monitoring results of vehicles in the data set can be replayed.

A demo video of the monitoring visualization of highway dataset can be viewed on [Youtube](https://youtu.be/s39px3G_MT8) or [BiliBili](https://www.bilibili.com/video/BV1JV4y1u7AW/?vd_source=682b18deece45270539ce306454dc47f).

A demo video of the monitoring visualization of intersection dataset can be viewed on [Youtube](https://www.bilibili.com/video/BV1QB4y1E7KZ/?vd_source=682b18deece45270539ce306454dc47f) or [BiliBili](https://www.bilibili.com/video/BV1QB4y1E7KZ/?vd_source=682b18deece45270539ce306454dc47f).

<div align=center>
<img src="Doc/video.jpg" width = 600>
</div> 

<div align=center>
<img src="Doc/Video_intersection.jpg" width = 600>
</div> 

### Step 1.Download source code
For monitoring program and visualization of highway see [Highway_Vis_tool](https://github.com/SOTIF-AVLab/Digitalization-of-regulations/tree/main/Highway_Vis_tool).

For monitoring program and visualization of intersection see [Intersection_Vis_tool](https://github.com/SOTIF-AVLab/Digitalization-of-regulations/tree/main/Intersection_Vis_tool).

### Step 2.Set monitoring object
#### 2.1 Highway_Vis_tool
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
#### 2.2 Intersection_Vis_tool
Main program is Intersection_Vis_tool/VIsMain.py. When running the file, user needs to input the Ego id. This id will be set as ego vehicle. 
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

## Acknowledgements
Our highway visualization code is built upon the public code of visualization program of [HighD-dataset](https://github.com/RobertKrajewski/highD-dataset). The dataset we use is derived from DJI's open-source dataset——AD4CHE(Aerial Dataset for China Congested Highway and Expressway).

For intersection, the dataset we use is [SinD-dataset](https://github.com/SOTIF-AVLab/SinD). Our intersection visualization code is built upon the public code of visualization program of SinD-dataset.

## Organization
<img src="Doc/logo.png" width = 350>

- School of Vehicle and Mobility, Tsinghua University
- Tsinghua Intelligent Vehicle Design and Safety Research Institute
- Safety Of The Intended Functionality（SOTIF） Research Team
