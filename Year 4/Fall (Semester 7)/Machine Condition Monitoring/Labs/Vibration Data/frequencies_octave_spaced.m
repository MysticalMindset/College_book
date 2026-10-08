
% frequencies_octave_spaced.m  ver 1.0 by Tom Irvine

function[freq,omega,np]=frequencies_octave_spaced(fmin,fmax,N)

tpi=2*pi;
%
noct=log(fmax/fmin)/log(2);
np=floor(noct*N);
%
freq=zeros(np,1);
%
R=2^(1/N);
%
freq(1)=fmin;
for i=2:np
    freq(i)=freq(i-1)*R;
end
freq(np)=fmax;
%
omega=tpi*freq;
