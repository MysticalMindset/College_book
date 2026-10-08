
%  fds_ylabel.m  ver 1.0  by Tom Irvine


function[y_label,t_string]=fds_ylabel(Q,bex,nmetric,iu)


if(nmetric==1)
    t_string=sprintf('Acceleration Fatigue Damage Spectra  Q=%g b=%g ',Q,bex);
    if(iu==1)
        y_label=sprintf('Damage (G^{ %g})',bex);
    else
        y_label=sprintf('Damage ((m/sec^2)^{ %g})',bex);        
    end
else
    t_string=sprintf('Pseudo Velocity Fatigue Damage Spectra  Q=%g b=%g ',Q,bex);   
    if(iu==1)
        y_label=sprintf('Damage (ips^{ %g})',bex);
    else
        y_label=sprintf('Damage ((m/sec)^{ %g})',bex);        
    end    
end   
