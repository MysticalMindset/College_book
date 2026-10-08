%
%  acoustic_plate_plots.m ver 1.0  by Tom Irvine
%
function[fig_num]=acoustic_plate_plots(fig_num,x,y,iu,f,HM,HM_stress_xx,HM_stress_yy,HM_stress_xy,HM_stress_vM)
%
figure(fig_num);
fig_num=fig_num+1;
plot(f,HM);  
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');

if(iu==1)
    out1=sprintf('Displacement Frequency Response Function at x=%g y=%g inch ',x,y);
    ylabel('[Displacement/Pressure] (in/psi) ');
else
    out1=sprintf('Displacement Frequency Response Function at x=%g y=%g meters ',x,y);
    ylabel('[Displacement/Pressure] (m/Pa) ');    
end

title(out1);
xlabel('Frequency (Hz)');
grid on;
disp(' ');
%
%%%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HM_stress_xx,f,HM_stress_yy);  
    legend ('stress xx','stress yy');  
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Stress Frequency Response Function at x=%g y=%g inch ',x,y);        
        ylabel('[Stress/Pressure] (psi/psi) ');
    else
        out1=sprintf('Stress Frequency Response Function at x=%g y=%g meters ',x,y);        
        ylabel('[Stress/Pressure] (Pa/Pa) ');        
    end
    title(out1);    
    xlabel('Frequency (Hz)');
    grid on;
    disp(' ');
%%%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HM_stress_xy);  
    legend ('stress xy');  
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');    
    if(iu==1)
        out1=sprintf('Stress Frequency Response Function at x=%g y=%g inch',x,y);        
        ylabel('[Stress/Pressure] (psi/psi) ');
    else
        out1=sprintf('Stress Frequency Response Function at x=%g y=%g meters',x,y);        
        ylabel('[Stress/Pressure] (Pa/Pa) ');        
    end
    title(out1);
    xlabel('Frequency (Hz)');
    grid on;
%%%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HM_stress_vM);  
    legend ('von Mises');  
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Stress Frequency Response Function at x=%g y=%g inch',x,y);        
        ylabel('[Stress/Pressure] (psi/psi) ');
    else
        out1=sprintf('Stress Frequency Response Function at x=%g y=%g meters',x,y);           
        ylabel('[Stress/Pressure] (Pa/Pa) ');        
    end
    title(out1);    
    xlabel('Frequency (Hz)');
    grid on;
%%%