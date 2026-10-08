%
%  oaspl_function.m  ver 1.0  by Tom Irvine
%
function[oadb]=oaspl_function(dB)

suma=0.;
%
M=length(dB);
%
for i=1:M
%
    ms = (10.^(dB(i)/10));
    suma=suma+ms;
end
%
oadb=10.*log10(suma);