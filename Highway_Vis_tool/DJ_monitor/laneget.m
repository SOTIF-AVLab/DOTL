function [X,Y]=laneget(Filename)
%% 从图片中获取车道线坐标

% Filename='C:\Users\Eyre_\OneDrive\桌面\法规专项\程序\监测\44\DJI_0044\44_laneWidthColorAndID.png';
A= imread(Filename);
% B= imread('C:\Users\Eyre_\OneDrive\桌面\法规专项\程序\监测\44\DJI_0044\44_laneWidthColorAndID.png');
A=sum(A,3);
a=A~=0;
e=a(2:end,:)-a(1:end-1,:);
b=repmat((2:size(A,1))',1,size(A,2));
c=[zeros(1,size(A,2));e.*b];
LineNumber=sum(unique(c(:,10))<=0);
% 1 pixel = 0.0375 m
X=(1:size(A,2))*0.0375;
Y=zeros(LineNumber,size(A,2));
for idx=1:LineNumber
    if idx<LineNumber
        d=-min(c);
    else
        d=c(c~=0)';
    end
    Y(idx,:)=d.*0.0375;
    c(min(d)-1:max(d)+1,:)=0;
end
end





