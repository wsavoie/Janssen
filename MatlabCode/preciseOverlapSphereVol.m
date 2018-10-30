r=0.5;
%http://mathworld.wolfram.com/Sphere-SphereIntersection.html
%volume of overlap for spheres at a distance 1 radius away from eachother

v=5/12*pi*(r)^3; %overlap volume
V=4/3*pi*r^3-v;%non-overlap volume
VV=V-v;%non overlap volume for a double overlapped volume

%area version
% h=2*r^2*acos(1/2)-1/2*sqrt(3*r^4);%overlap area
% H=pi*r^2-h;%non-overlap part
% HH=pi*r^2-2*H;%double overlapped sphere

n=28;%num of circs
V=2*V+(n-1)*v+(n-2)*VV
