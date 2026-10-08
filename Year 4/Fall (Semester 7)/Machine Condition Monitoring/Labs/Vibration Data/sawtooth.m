
% sawtooth.m   ver 1.0  by Tom Irvine

function[y]=sawtooth_function(arg,xmax)

tpi=2*pi;

n=length(arg);

y=zeros(n,1);

for i=1:n
    
   a=arg(i); 
    
   while(1)
       if(a<=tpi)
            break;
       else
            a=a-tpi;
       end
   end    
   
   if(a<=0)
       a=a+tpi;
   end
   
    
   if(a<=pi)
       y(i)=(a/pi);
   else
       a=a-pi;
       y(i)=1-(a/pi);
   end
end

y=y-max(y)/2;
