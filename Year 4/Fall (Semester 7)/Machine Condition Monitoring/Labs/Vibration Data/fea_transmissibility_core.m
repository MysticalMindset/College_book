
% fea_transmissibility_core.m  ver 1.1 by Tom Irvine

function[f,acc,rd]=fea_transmissibility_core(f,nff,nem,ModeShapes,MST,...
                             Mwd,damp,omegan,TT,ngw,TZ_tracking_array,node,num_modes)

np=length(f);
 
omega=2*pi*f;
om2=omega.^2;

omn2=omegan.^2;

N=zeros(nff,1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  

%
y=ones(nem,1);


A=-MST*Mwd*y;
%
acc=zeros(np,1);
rd=zeros(np,1);


nffx=min([nff length(damp) length(omegan) length(om2) num_modes]);


for k=1:np  % for each excitation frequency
    
    for i=1:nffx  % dof
        N(i)=A(i)/(omn2(i)-om2(k) + (1i)*2*damp(i)*omegan(i)*omega(k));
    end
    
    Ud=zeros(nem,1); 
    for i=1:nem  % convert acceleration input to displacement
        Ud(i)=1/(-om2(k));
    end
%

    Uw=ModeShapes*N;   
    
%    size(ModeShapes)
%    size(N)
%    size(Uw)
    

    Udw=[Ud; Uw];

%
    U=TT*Udw;    
    
    nu=length(U);
    
    Ur=zeros(nu,1);
    
    for i=1:nu
       Ur(ngw(i))=U(i);   
    end    
    
    
    ij=TZ_tracking_array(node);
    acc(k)=om2(k)*abs(Ur(ij));
    
    rd(k)=abs(Ur(ij)-Ud(1));
 
end

f=fix_size(f);
acc=fix_size(acc);
rd=fix_size(rd);