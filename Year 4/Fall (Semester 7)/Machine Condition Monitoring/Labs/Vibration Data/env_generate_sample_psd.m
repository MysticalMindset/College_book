%
%   env_generate_sample_psd.m  ver 1.6   by Tom Irvine
%
%   used by:  vibrationdata_envelope_psd.m
%             vibrationdata_envelope_fds.m
%             vibrationdata_envelope_fds_batch.m 
%
%
function[f_sam,apsd_sam]=...
    env_generate_sample_psd(n_ref,nbreak,npb,f_ref,ik,slopec,initial,final,f1,f2)
%    
iflag=99;
%
f_sam=zeros(nbreak,1);
apsd_sam=zeros(nbreak,1);
%
% generate some random numbers for frequency
%

if(npb<=10)

    while(1)
    
        g=zeros(nbreak,1);
    
        for i=1:nbreak
%		  
            index = round( n_ref*rand());
            if(index >= n_ref)
                index=n_ref-1;
            end    
            if(index <= 1)
                index=2;
            end
        
            g(i)=index;
            f_sam(i)=f_ref(index);
            

        
        end    
%    
        if(length(g)==length(unique(g)))
            break;
        end    
    end    

%
    f_sam(1)=f1;
    f_sam(nbreak)=f2;
    f_sam=sort(f_sam);

else
    f_sam=f_ref;
end

%%%%%
%%%%%
%
% generate some random numbers for amplitude
%
	   for i=1:nbreak
		    apsd_sam(i)=rand();
       end
%	   
	   amin=1.0e-12;
%
	   for i=1:nbreak
%	 
	      if(apsd_sam(i) < amin)
                apsd_sam(i)=amin;
          end  
	      if(apsd_sam(i) > (1/amin))
              apsd_sam(i)=(1/amin);
          end    
       end
%%
%%
% absolute slopes are limited to slopec
%
for i=1:(nbreak-1)
    fr=f_sam(i+1)/f_sam(i);
    sss=0.;
    sss=log(apsd_sam(i+1)/apsd_sam(i))/log(fr);
    if(sss > slopec)
        apsd_sam(i+1)=apsd_sam(i)*(fr^slopec);
    end
    if(sss < -slopec)
        apsd_sam(i+1)=apsd_sam(i)*(fr^(-slopec));
    end
end
if(initial==1 && apsd_sam(1) > apsd_sam(1))
    apsd_sam(1)=apsd_sam(1);
end
if(final==1 && apsd_sam(nbreak) > apsd_sam(nbreak-1))
    apsd_sam(nbreak)=apsd_sam(nbreak-1);
end
%
f_sam(1)=f1;
f_sam(nbreak)=f2;
%
%% out1=sprintf(' Phase 1, Trial %ld, PSD Coordinates  ',ik);
%% disp(out1);
%
%%%%%%%%
%
    if(nbreak==3 && npb==3)
        apsd_sam(3)=apsd_sam(2);
    end
%
    if(nbreak==4 && npb==5)
        apsd_sam(3)=apsd_sam(2);
 %       
        if(apsd_sam(1)>apsd_sam(2))
            apsd_sam(1)=rand()*apsd_sam(2);
        end        
        if(apsd_sam(4)>apsd_sam(3))
            apsd_sam(4)=rand()*apsd_sam(3);
        end
%        
    end
%
%%%%%%%%%
%
%% for i=1:nbreak
%%    out1=sprintf(' %8.2f \t %8.4g ',f_sam(i),apsd_sam(i));
%%    disp(out1);
%% end    
