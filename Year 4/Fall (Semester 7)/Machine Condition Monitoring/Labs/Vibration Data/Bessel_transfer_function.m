%
%  Bessel_transfer_function.m  ver 1.0  November 12, 2012
%
function[fig_num]=Bessel_transfer_function(fig_num,fc,scale)
%
fmin=fc/100;
if(fmin>1.)
    fmin=1;
end
fmax=5*fc;
%
i=1;
f(i)=fmin;
i=2;
while(1)
    f(i)=f(i-1)*2^(1/48);
    if(f(i)>fmax)
        break;
    else
        i=i+1;
    end
end
%
nf=length(f);
H=zeros(nf,1);
%
for i=1:nf
    s=(1i)*(scale*f(i)/fc);
    H(i)=3/(s^2+3*s+3);
end
%
H_phase=(180/pi)*atan2(imag(H),real(H)); 
%
figure(fig_num);
fig_num=fig_num+1;
%
f1=0;
f2=max(f);
%
subplot(3,1,1);
plot(f,H_phase);
out1=sprintf('Bessel Filter Transfer Function, fc=%8.4g Hz',fc);
title(out1);
grid on;
ylabel('Phase (deg)');
axis([f1,f2,-180,0]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','lin','ytick',[-180,-90,0]);
%
subplot(3,1,[2 3]);
plot(f,abs(H));
grid on;
xlabel('Frequency(Hz)');
ylabel('Magnitude');
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
         'YScale','lin','ytick',[0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1]);
axis([f1,f2,0,1]);