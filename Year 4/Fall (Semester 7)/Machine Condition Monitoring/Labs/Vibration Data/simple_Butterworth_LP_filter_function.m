% 
%    Butterworth_LP_filter_function.m 
%    ver 2.3   November 13, 2012 
%    by Tom Irvine  Email: tomirvine@aol.com 
% 
%    Butterworth filter, sixth-order, infinite impulse response,
%    cascade with refiltering option for phase correction               
%
function[y]=simple_Butterworth_LP_filter_function(y,dt,f)
%
fh=f;

n=length(y);
ns = n; 
%
%
iband=1;
%
fl=0.;
%
%% fh=input(' Enter lowpass frequency (Hz) ');      
f=fh;
%
iphase=2;  % No refiltering for phase correction
%
iflag=1;
%
%****** calculate coefficients *******
%
if(iflag ~= 999 && iband ~=3)
%
    [a,b,iflag] = simple_filter_coefficients(f,dt,iband,iflag);
%    
end
%
if(iflag < 900 )
%
    if(iband == 1 || iband ==2)  % lowpass or highpass
%		 
         if(iphase==1)   % refiltering
			[y]=simple_apply_filter(y,iphase,ns,a,b);
			[y]=simple_apply_filter(y,iphase,ns,a,b); 
	      else
			[y]=simple_apply_filter(y,iphase,ns,a,b);	
          end
%     
    end
%
 
%
else
    disp(' ')
    disp('  Abnormal termination.  No output file generated. ');
end