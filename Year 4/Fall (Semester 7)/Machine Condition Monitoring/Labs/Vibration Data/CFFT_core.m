%    
%   CFFT_core.m  version 1.5    November 3, 2012
%   By Tom Irvine  
%
function[Y]=CFFT_core(amp_seg,mmm,~,mr_choice,h_choice) 
%
clear mag_seg;
clear Y;
clear z;
clear H;
%
mu=mean(amp_seg);
if(mr_choice==1)
   amp_seg=amp_seg-mu;
%  amp_seg=detrend(amp_seg);
end
%
if(h_choice==2)
%   disp(' Hanning window '); 
    alpha=linspace(0,2*pi,mmm);
    H=0.5*(1-cos(alpha));
    ae=sqrt(8./3.);
%
    sz=size(H);
    if(sz(2)>sz(1))
        H=H';
    end
%    
    amp_seg=ae*amp_seg.*H;
end
%
%disp(' ')
%disp(' begin FFT ')
%disp(' ')
%
Y = fft(amp_seg,mmm);
Y = Y/mmm;
%
Y=fix_size(Y);