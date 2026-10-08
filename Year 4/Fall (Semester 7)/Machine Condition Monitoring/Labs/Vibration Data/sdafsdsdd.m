clear t;
clear y;

  stab=[1      6.1455      9.9349      0.3372  
  2      0.8377     27.5966      2.3660  
  3      0.5681     35.1416     -1.4199  
  4      0.2199     23.2844     -1.1745  ];

A=stab(:,2);
freq=stab(:,3);
phase=stab(:,4);

sz=size(stab);

N=sz(1);

sr=10000;
dt=1/sr;
dur1=0.0975;

tpi=2*pi;


hds1=0.030;
hds2=0.030*0.08;


total_dur=2*dur1+hds1+hds2;

nt1=round(dur1/dt);

nt2=round(hds1/dt);

nt3=round(hds2/dt);

ntt=2*nt1+nt2+nt3;

t=zeros(ntt,1);
y=zeros(ntt,1);


for j=1:ntt
    t(j)=(j-1)*dt;
end

for j=1:nt1

    for i=1:N
        y(j)=y(j)+A(i)*sin(tpi*freq(i)*t(j)+phase(i));
    end

end

y(1:nt1)=y(1:nt1)-y(1);

ia=nt1+1;
ib=ia+nt2;

for j=ia:ib
    y(j)=30*(j-ia)/(ib-ia);
end

ia=ib+1;
ib=ia+nt3;

for j=ia:ib
    y(j)=30*(1-(j-ia)/(ib-ia));
end

ia=ib+1;
ib=ntt;

kv=nt1-1;

for j=ia:ib
    try
        y(j)=y(kv);
        kv=kv-1;
    end
end

% y(1:nt1)=y(1:nt1)
y(ia:ib)=1.15*y(ia:ib);

y(end)=0;


figure(990);
plot(t,y);
grid on;

tsaw_model=[t y];