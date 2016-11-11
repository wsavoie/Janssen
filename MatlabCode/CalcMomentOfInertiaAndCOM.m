function [ momI,com ] = CalcMomentOfInertiaAndCOM( pos, masses )
%CALCMOMENTOFINERTIAANDCOM calculates the moment of inertia
%and center of mass of the particle given position of all particles and
%masses of all particles
%momI=[IXX,IYY,IZZ,IXY,IXZ,IYZ]
%com= [Xc,Yc,Zc]

%moment of inertia calculation
t=zeros(size(pos,1),6); %temp var for each of 6 directions\
x=pos(:,1); y=pos(:,2); z=pos(:,3);
for i=1:size(pos,1)
   t(i,1)=(y(i)^2+z(i)^2)*masses(i); %XX
   t(i,2)=(x(i)^2+z(i)^2)*masses(i); %YY
   t(i,3)=(x(i)^2+y(i)^2)*masses(i); %ZZ
   t(i,4)=-x(i)*y(i)*masses(i); %XY
   t(i,5)=-x(i)*z(i)*masses(i); %XZ
   t(i,6)=-y(i)*z(i)*masses(i); %YZ
end
momI=sum(t,1);

%center of mass calculation
R=zeros(size(pos,1),3);
for j=1:size(pos,1)
    R(j,:)=masses(j)*pos(j,:);
end
mtotal=sum(masses);
com=sum(R,1)/mtotal;

com=round(com,6);
momI=round(momI,6);