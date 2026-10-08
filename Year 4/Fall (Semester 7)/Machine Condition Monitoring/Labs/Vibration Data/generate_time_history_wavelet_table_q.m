%
%  generate_time_history_wavelet_table_q.m  ver 1.1  by Tom Irvine
%
function[accel]=generate_time_history_wavelet_table_q(f,amp,NHS,td,t,...
                                         wavelet_low,wavelet_up,alpha,beta)


nt=length(t);

last_wavelet=length(f);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 
accel=zeros(nt,1);
%    
for i=1:last_wavelet      
%
        sa=zeros(nt,1);
        sb=zeros(nt,1);
%
        ia=wavelet_low(i);
        ib=wavelet_up(i);
        
%
        if(ib>nt)
            out1=sprintf(' error:  ia=%d ib=%d nt=%d  ',ia,ib,nt);
            disp(out1);
        end
%
        sa(ia:ib)=sin( alpha(i)*( t(ia:ib)-td(i) ) );        
        sb(ia:ib)=sin(  beta(i)*( t(ia:ib)-td(i) ) );
        sc=amp(i)*sa.*sb;
%
        accel(ia:ib)=accel(ia:ib)+sc(ia:ib);
%
end