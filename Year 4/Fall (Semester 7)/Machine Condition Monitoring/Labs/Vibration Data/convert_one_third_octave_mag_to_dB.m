%
%  convert_one_third_octave_mag_to_dB.m  ver 1.0  October 18, 2012
%
function[splevel,oaspl]=...
                      convert_one_third_octave_mag_to_dB(band_rms,ref)
%
imax=length(band_rms);
%
splevel=zeros(imax,1);
%
ms=0.;
%
for j=1:imax
        if(band_rms(j)>1.0e-12)
            ms=ms+(band_rms(j))^2;
            splevel(j)=20*log10(band_rms(j)/ref);
        end
end 
%
ms=sqrt(ms);
%
oaspl = 20*log10(ms/ref);