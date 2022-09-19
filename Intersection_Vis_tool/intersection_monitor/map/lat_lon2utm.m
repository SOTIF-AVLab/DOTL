function[UTME,UTMN]=lat_lon2utm(lat_shuru,lon_shuru)
%地理经纬度坐标转换为UTM坐标

%输入经纬度
lat0=39.06604898759;
lon0=117.26330908943;  %参考原点经纬度
lat=lat_shuru; %纬度
lon=lon_shuru; %经度
%%     %%unit：m
a=6378.137; 
e=0.0818192;
k0=0.9996;
E0=500;
N0=0;
Zonenum=fix(lon/6)+31;
Zonenum0=fix(lon0/6)+31;
lamda1=(Zonenum-1)*6-180+3; %degree
lamda0=(Zonenum0-1)*6-180+3; %degree
lamda1=lamda1*pi/180; %radian
lamda0=lamda0*pi/180; %radian
phi=lat*pi/180;
phi0=lat0*pi/180;
lamda=lon*pi/180;%radian
lamda2=lon0*pi/180;%radian

v=1/sqrt(1-e^2*(sin(phi0)^2));
A=(lamda2-lamda0)*cos(phi0);
T=tan(phi0)*tan(phi0);
C=e^2*cos(phi0)*cos(phi0)/(1-e^2);
s=(1-e^2/4-3*e^4/64-5*e^6/256)*phi0-(3*e^2/8+3*e^4/32+45*e^6/1024)*sin(2*phi0)+(15*e^4/256+45*e^6/1024)*sin(4*phi0)-35*e^6/3072*sin(6*phi0);
UTME0=(E0+k0*a*v*(A+(1-T+C)*A^3/6+(5-18*T+T^2)*A^5/120));
UTMN0=(N0+k0*a*(s+v*tan(phi0)*(A^2/2+(5-T+9*C+4*C^2)*A^4/24+(61-58*T+T^2)*A^6/720)));

v=1/sqrt(1-e^2*(sin(phi)^2));
A=(lamda-lamda1)*cos(phi);
T=tan(phi)*tan(phi);
C=e^2*cos(phi)*cos(phi)/(1-e^2);
s=(1-e^2/4-3*e^4/64-5*e^6/256)*phi-(3*e^2/8+3*e^4/32+45*e^6/1024)*sin(2*phi)+(15*e^4/256+45*e^6/1024)*sin(4*phi)-35*e^6/3072*sin(6*phi);
UTME=(E0+k0*a*v*(A+(1-T+C)*A^3/6+(5-18*T+T^2)*A^5/120)-UTME0)*1000;
UTMN=(N0+k0*a*(s+v*tan(phi)*(A^2/2+(5-T+9*C+4*C^2)*A^4/24+(61-58*T+T^2)*A^6/720))-UTMN0)*1000;


