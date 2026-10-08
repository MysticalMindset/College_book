%
%  overall_dB.m  ver 1.0  January 6, 2016
%
function[oadB]=overall_dB(dB)
%
sum=0.;
%
M=length(dB);
%
for i=1:M

    ms = (10.^(dB(i)/10));
    sum=sum+ms;
    
end
%
oadB=10.*log10(sum);
