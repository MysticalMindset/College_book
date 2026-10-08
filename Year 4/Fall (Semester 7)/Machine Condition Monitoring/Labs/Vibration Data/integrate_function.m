%
%  integrate_function.m  ver 1.2  October 16, 2018
%
%  by Tom Irvine
%
function[v]=integrate_function(y,dt)
%
v=dt*cumtrapz(y);

v=fix_size(v);