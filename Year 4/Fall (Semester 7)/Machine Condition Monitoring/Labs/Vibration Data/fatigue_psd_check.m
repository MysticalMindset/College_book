%
%   fatigue_psd_check.m  ver 1.0  by Tom Irvine
%
function[f,a,s,rms,df,THM,fi,ai]=fatigue_psd_check(THM,scf)
%
if(THM(1,1)<1.0e-04)
    THM(1,:)=[];
end
 
f=THM(:,1);
a=THM(:,2);
%
if(f(1)<0.001)
    f(1)=0.001;
end   

a=a*scf^2;

%
[s,rms]=calculate_PSD_slopes(f,a);

df=f(1)/20;


[fi,ai]=interpolate_PSD(f,a,s,df);