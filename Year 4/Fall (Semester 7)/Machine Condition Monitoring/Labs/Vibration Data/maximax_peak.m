%
%  maximax_peak.m  ver 1.0  by Tom Irvine
%

function[ps]=maximax_peak(fn,T)

arg=fn*T;

c=sqrt(2*log(arg));
ps=c + 0.5772/c;    