%
%   env_generate_sample_psd2.m  ver 1.5   by Tom Irvine
%
%   used by:  vibrationdata_envelope_psd.m
%             vibrationdata_envelope_fds.m
%             vibrationdata_envelope_fds_batch.m
%
function[f_sam,apsd_sam]=...
    env_generate_sample_psd2(n_ref,nbreak,npb,f_ref,xf,xapsd,slopec,initial,final,ik,f1,f2)
%  
    while(1)
%
        if( rand()>0.2)
            bbb=(rand())^3.;
        else
            bbb=0.1*rand();
        end
%
        aaa=1.-bbb/2.;
%  
        for(i=1:(nbreak-1))
            f_sam(i)=xf(i)*(aaa+bbb*rand());    
        end
        
%        f_sam=round(f_sam);
        
        if(length(f_sam)==length(unique(f_sam)))
            break;
        end
        
    end
%   
% sort the frequencies
%
    f_sam=sort(f_sam);  
          
    f_sam(1)=f1;
    f_sam(nbreak)=f2; 
    
    
    if(  length(unique(f_sam))<nbreak)
       f_sam=xf; 
    end    
    
    
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% check frequencies for adequate spacing
%		  
    ialarm = 0;
    fnum = (f_ref(n_ref)-f_ref(1))/200.;
%
    for i=1:(nbreak-1)
%
        if (  abs(f_sam(i+1) - f_sam(i) ) < fnum )
            ialarm = 1;
            break;
        end
    end
%    
    if(ialarm == 1 )
%
        df=(f_ref(n_ref)-f_ref(1))/(n_ref-1);
%    
        for i=2:nbreak
            f_sam(i)=f_sam(i-1)+df;
        end
    end
    f_sam(nbreak)=f_ref(n_ref);
    f_sam=sort(f_sam);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
       % generate some random number for amplitude
%
        apsd_sam=zeros(nbreak,1);

        for i=1:nbreak
            
            aaa=0.5*rand();
%
            if(rand()>0.5)
                aaa=-aaa;
            end
        
            bbb=10^(aaa/10);
%       
            apsd_sam(i)=xapsd(i)*bbb;
%
            if(apsd_sam(i)>2000.)
%           
                out1=sprintf(' Error: %ld  %8.4g  %8.4g \n',i,apsd_sam(i),xapsd(i));
                disp(out1);
%               
                exit(1);
%
            end
        end
%
    % add constraint
%
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
f_sam=sort(f_sam);
%
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
    end
%
%%%%%%%%%

if(  length(unique(f_sam))<nbreak)
    f_sam=xf; 
end

%% out1=sprintf('\n Phase 2, Trial %ld, PSD Coordinates \n',ik);
%% disp(out1);

%
%% for i=1:nbreak
%%     out1=sprintf(' %8.2f \t %8.4g ',f_sam(i),apsd_sam(i));
%%     disp(out1);
%% end    