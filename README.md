# Digitalization of regulations
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

A demo video of the monitoring visualization of highway dataset can be viewed [here](https://youtu.be/H9QSGqioYww).

### Step 1.Download source code
For monitoring program and visualization of highway see [Highway_Vis_tool](https://github.com/SOTIF-AVLab/Digitalization-of-regulations/tree/main/Highway_Vis_tool).

For monitoring program and visualization of intersection see [Intersection_Vis_tool](https://github.com/SOTIF-AVLab/Digitalization-of-regulations/tree/main/Intersection_Vis_tool).

### Step 2.Set monitoring object
#### 2.1 Highway_Vis_tool
Main program is Highway_Vis_tool/startVisualization.m. Before running it, set the "videoString" and "selectid". This selectid will be set ego vehicle.

#### 2.2 Intersection_Vis_tool
Operation instructions of intersection visual monitoring program...

## Acknowledgements
描述一下高速的可视化程序是基于HighD数据集的可视化程序；给个HighD数据集的github链接；十字路口的可视化程序是基于SinD数据集的可视化程序，连接到SinD数据集的github链接。

## Organization
<img src="Doc/logo.png" width = 350>

- School of Vehicle and Mobility, Tsinghua University
- Tsinghua Intelligent Vehicle Design and Safety Research Institute
- Safety Of The Intended Functionality（SOTIF） Research Team
