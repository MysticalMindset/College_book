%
%  track_changes.m ver 1.0  by Tom Irvine
%
function[ngw]=track_changes(nem,num,ea)

%  Track changes
%
ijk=nem+1;
ngw=zeros(num,1);
ngw(1:nem)=ea;
for i=1:num
    iflag=0;
    for nv=1:nem
      if(i==ea(nv))
          iflag=1;
      end
    end
    if(iflag==0)
        ngw(ijk)=i;
        ijk=ijk+1;
    end
end