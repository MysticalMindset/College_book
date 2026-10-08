
%  cross_correlation_function.m   ver 1.0  by Tom Irvine

function[xc,xmax,tmax]=cross_correlation_function(a,b,num,dt)

        clear t;
        p=2*num-1;
        ac1 = fft(b,p) .* conj(fft(a,p));
        ac1=real(ifft(ac1));
        ac1=ac1/num;
        ac1=fix_size(ac1);
        mm=floor(length(ac1)/2);
        ac2 = ac1(1:mm);
        ac2r=flipud(ac2);
        ac2r(mm)=[];
        ac3=[ ac2r ; ac2];
%
        nn=length(ac3);
        t=linspace(0,(nn-1)*dt,nn);
        t=t-t(nn)/2;        
        [~,I] = min(abs(t));
        t(I)=0;
        t=fix_size(t);
        xc=[t,ac3]; 
%%%

    clear C;
    clear I;
    clear xcc;
    xcc=[xc(:,1) abs(xc(:,2))];
    [C,I]=max(xcc);
    xmax=xcc(I(2),2);
    tmax=abs(xc(I(2),1));