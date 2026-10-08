%
%  trim_acoustic_SPL.m  ver 1.0  October 19, 2012
%
function[pf,pspl,oaspl]=trim_acoustic_SPL(fc,splevel,ref)
%
k=1;
%
ms=0; 
%
imax=length(splevel);
%
    for i=1:imax
        if(splevel(i)>0.0001 && fc(i)>9)
            pf(k)=fc(i);
            pspl(k)=splevel(i);
%
            bs=ref*10^(pspl(k)/20);
            ms=ms+bs^2;
%
            k=k+1;
        end
    end
%
ms=sqrt(ms);
oaspl = 20*log10(ms/ref);