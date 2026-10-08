%
%  FRF_plots_two.m  ver 1.0  by Tom Irvine
%

function[fig_num]=FRF_plots_two(ff,frf_m,frf_p,frf_real,frf_imag,ntype,t_string,f1,f2,fig_num)

[xtt,xTT,iflag]=xtick_label(f1,f2);

figure(fig_num);
fig_num=fig_num+1;
%
subplot(3,1,1);
plot(ff,frf_p);
title(t_string);
grid on;
ylabel('Phase (deg)');
ylim([-180,180]);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    f1=min(xtt);
    f2=max(xtt);    
end

xlim([f1 f2]);

if(ntype==1)

    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','ytick',[-180,-90,0,90,180]);            
else
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-180,-90,0,90,180]);      
end

%
if(max(frf_p)<=0.)
%
    ylim([-180,0]);
                
    if(ntype==1)

        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','ytick',[-180,-90,0]);            
    else
        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-180,-90,0]);      
    end                
                
end  
%
if(min(frf_p)>=-90. && max(frf_p)<90.)
%
    ylim([-90,90]);

    if(ntype==1)

        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','ytick',[-90,0,90]);            
    else
        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-90,0,90]);      
    end  
    
    
end 
%
if(min(frf_p)>=0.)
%
    ylim([0,180]);
                
    if(ntype==1)

        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
                    'YScale','lin','ytick',[0,90,180]);            
    else
        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[0,90,180]);      
    end                  
                
end 
%

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    f1=min(xtt);
    f2=max(xtt);    
end

xlim([f1 f2]);



subplot(3,1,[2 3]);
plot(ff,frf_m);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    f1=min(xtt);
    f2=max(xtt);
end

xlim([f1 f2]);


grid on;
xlabel('Frequency(Hz)');
ylabel('Magnitude');

if(ntype==1)

    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
         'YScale','log');     
else
    
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','log'); 
end         
     
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
%
subplot(2,1,1);
plot(ff,frf_real);
grid on;

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    f1=min(xtt);
    f2=max(xtt);    
end



xlim([f1 f2]);

ylabel('Real');
title(t_string);

if(ntype==1)

    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
         'YScale','lin');
     
else
    
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','lin');    
end
     
%
subplot(2,1,2);
plot(ff,frf_imag);
grid on;


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    f1=min(xtt);
    f2=max(xtt);    
end

xlim([f1 f2]);

xlabel('Frequency (Hz)');
ylabel('Imaginary');

if(ntype==1)

    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin',...
         'YScale','lin');

else
    
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','lin');    
end