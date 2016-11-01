function [x,y] = MakeCircle(center, r)
%DRAWCIRCLE draw circle centered at center=[x,y] with radius r
for i=1:1000
    x(i) = r*cos(i) + center(1);
    y(i) = r*sin(i) + center(2);
end