%
%    ws_gen_time.m  ver 2.0  February 22, 2013
%
function[wavelet,th] = ws_gen_time(nhs,amp,omegaf,upper,nt,dt,td,igen,nv,wavelet,nspec)  
%        
        for(i=1:nspec)
            if( (nhs(igen,i)) < 3 )
                  nhs(igen,i)=3;
            end
        end
%
        for(i=1:nspec)
            if(  omegaf(i) <= 0 || omegaf(i) > 1.0e+20 )    
                out1=sprintf(' gt error: i=%ld  omegaf= %9.4g \n',i,omegaf(i));
                disp(out1);
            end
        end
%
%%        for(i=1:nspec)
%%            if(  abs(amp(igen,i))<1.0e-20 )
%%                out1=sprintf(' gt error: i=%ld  amp= %9.4g \n ',i,amp(igen,i));
%%                disp(out1);
%%            end
%%        end
%
        for(i=1:nspec)
            if(  abs(upper(i))<1.0e-20 )
%         
                out1=sprintf(' error: i=%ld  upper= %9.4g \n ',i,upper(i));
                disp(out1);
                input(' ctrl-C ');
%
            end
        end
%
        if(nv==1)
%
            for(j=1:nt) 
%  
                t=dt*(j-1);
%
                for(i=1:nspec)
%
                    if(  omegaf(i) <= 0)    
                        out1=sprintf(' ref 1: omegaf error \n ');
                        disp(out1);
                    end
 
                    wavelet(i,j)=0.;
                    tt=t-td(igen,i);
                    ta= omegaf(i)*tt;
  
                    if( t>=td(igen,i) && tt <= upper(i) )
%
                        wavelet(i,j)=(sin(ta/(nhs(igen,i)) )*sin(ta));
%
                        if(  omegaf(i) <= 0)
                            out1=sprintf( ' ref 2: omegaf error ');
                            disp(out1);
                        end
%                  
                        if( abs(wavelet(i,j)) > 1.0e+10)
%                        
                            out1=sprintf(' wavelet error: i=%ld  j=%ld %9.4g\n',i,j,wavelet(i,j));
                            disp(out1);
%
                        end 
                    end 
                end   
            end
        end
%
%
%%%          clear big;
%%%          abc=amp(igen,:);
%%%          size(abc)
%%%          size(wavelet);
%%%          big=abc*wavelet;
%
%%      for(j=1:nt)
%%         th(j)=sum(amp(igen,:)*wavelet(:,j));
%%      end
%
      www=zeros(nspec,nt);
      for(k=1:nspec)
          www(k,:)=amp(igen,k)*wavelet(k,:);
      end
      th=zeros(nt,1);
      th=sum(www);
%%%          size(big)
%%%          clear th;
%%%          th=sum(big);
%%%          size(th)
%%%          uuu=input(' ');
%
       if(std(th)<1.0e-20)
           out1=sprintf('\n std(th) error \n');
           disp(out1);
           aaa=input(' control-C ');
       end
  end