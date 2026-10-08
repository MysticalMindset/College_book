
% extract_function.m  ver 1.0  by Tom Irvine

function [TT,x,dt,n]=extract_function(THM,ts,te)


if(ts>te)
    warndlg('Start time > end time');
end

t=double(THM(:,1));
y=double(THM(:,2));

n=length(y);

tmi=THM(1,1);
tmx=THM(n,1);
dt=(tmx-tmi)/n;

%
if(te>tmx)
    te=tmx;
end
if(ts<tmi)
    ts=tmi;
end
%

%
n1=1+ceil((ts-tmi)/dt);
n2=floor((te-tmi)/dt);
%
if(n1<1)
    n1=1;
end
%
if(n2>n)
    n2=n;
end
%
if(n1>n2)
    n2=n1;
end
%
x=y(n1:n2)';
TT=t(n1:n2)';
%

x=fix_size(x);
TT=fix_size(TT);



n=length(TT);