function [pos]=createStaple(d,l,w,t,deg,overlap)
%CREATESTAPLE
%d=diameter
%l=length in spheres
%w=width in spheres 0 = only staple spine
%t= [theta1,theta2]
%deg = specification of t in degrees or radians
%overlap= between 0 and 1, percentage of overlap between spheres
% clear all;
% d = 1; %diameter in lammps, spheres are defined by diameter
r=d/2;


ol=1-overlap;

% w=4; %center barb width
% l=2; %outer barb lengths defined as first circle not in center barb

%given a point in phase space make staple

% t=[90,90]*pi/180;

if deg
    t=t*pi/180;
end

t(1)=-t(1)+pi; %create offset so that coord system is same for smarticles
%create all staples such that their first point (0,0)
%is at bottom left, so we stay in positive quadrant 
% where x is (0,0)
%   o     o
%   o     o
%   X o o o

%no need to set the z dimension, assume staples are always planar
pos=zeros(2*l+w,3);

%make spine of staple
for i=1:w
    pos(i,1)= (i-1)*d*ol;
    pos(i,2)= 0;
end

%current index counter
c=w+1;
for i=[0 1]
    for j=1:l
        pos(c,1)=ol*d*(i*(w-1)+j*cos(t(i+1))); %x pos
        pos(c,2)=j*sin(t(i+1))*d*ol;
        c=c+1;
    end
end

%round to 8 places
pos=round(pos,8);

axis equal
hold on;
for i=1:size(pos,1)
    figure(123);
    hold on;
    mark='k';    
    if(i>w)
        mark='r';
    end
    [x,y]=makeCircle([pos(i,:)],r);
    plot(x,y,mark)
  
%     plot(x,y)
end

figure(234);
hold on;
plot(pos(:,1),pos(:,2),'o');