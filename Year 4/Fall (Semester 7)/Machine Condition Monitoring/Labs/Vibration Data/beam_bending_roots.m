%
%  beam_bending_roots.m  ver 1.0  by Tom Irvine
%

function[root]=beam_bending_roots(LBC,RBC)

n=8;

root=zeros(n,1);

if((LBC==1 && RBC==1)||((LBC==3 && RBC==3))) % fixed-fixed or free-free
    root(1)=4.73004;
    root(2)=7.8532;
    root(3)=10.9956;
    root(4)=14.13717;
    root(5)=17.27876;    
    root(6)=13*pi/2; 
    root(7)=15*pi/2;
    root(8)=17*pi/2;     
end
if((LBC==1 && RBC==2) || (LBC==2 && RBC==1)) % fixed-pinned
    root(1)=3.9266;
    root(2)=7.0686;
    root(3)=10.2102;
    root(4)=13.3518;
    root(5)=16.4934;  
    root(6)=6.25*pi; 
    root(7)=7.25*pi;
    root(8)=8.25*pi;      
end
if((LBC==1 && RBC==3) || (LBC==3 && RBC==1)) % fixed-free
    root(1)=1.87510;
    root(2)=4.69409;
    root(3)=7.85476;
    root(4)=10.99554;
    root(5)=9*pi/2;
    root(6)=11*pi/2;
    root(7)=13*pi/2;
    root(8)=15*pi/2;    
end
if(LBC==2 && RBC==2) % pinned-pinned
    for i=1:n
        root(i)=i*pi;
    end
end