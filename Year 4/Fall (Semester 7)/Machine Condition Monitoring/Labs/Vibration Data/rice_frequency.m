%
disp(' ');
disp(' rice_frequency.m  ver 1.1  October 11, 2018 ');
disp(' ');
disp(' by Tom Irvine ');
disp(' ');
disp(' This script calculates statistics for a time history including ');
disp(' the Rice characteristic frequency. ');
disp(' ');
disp(' The input file must have two columns:  time(sec) & amp ');
disp(' ');
%
disp(' Select file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
disp('   3=Excel file ');
file_choice = input('');
%
if(file_choice==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THM = fscanf(fid,'%g %g',[2 inf]);
        THM=THM';
end
if(file_choice==2)
        FS = input(' Enter the matrix name:  ','s');
        THM=evalin('caller',FS);
end
if(file_choice==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        THM = xlsread(xfile);
%         
end    
%
    amp=double(THM(:,2));
    tim=double(THM(:,1));
    n = length(amp);
%disp(' mean values ')

    mx=max(amp);
    mi=min(amp);
    
    [mu,sd,rms,sk,kt]=kurtosis_stats(amp);
    
%1
    disp(' ')
    disp(' Time Stats ')
    tmx=max(tim);
    tmi=min(tim);
    duration=(tmx-tmi);
% 
    out3 = sprintf('   start  = %g sec    end = %g sec   duration = %g sec  ',tmi,tmx,duration);
    disp(out3)
%
    dt=duration/(n-1);
    out5 = sprintf('\n number of samples = %d  ',n);
    disp(out5)
%
    clear t;
    t=tim;
    disp(' ')
    disp(' Time Step ');
    clear difft;
    difft=diff(t);
    dtmin=min(difft);
    dtmax=max(difft);
%
    out4 = sprintf(' dtmin  = %8.4g sec  ',dtmin);
    out5 = sprintf(' dt     = %8.4g sec  ',dt);
    out6 = sprintf(' dtmax  = %8.4g sec  ',dtmax);
    disp(out4)
    disp(out5)
    disp(out6)
%
    disp(' ')
    disp(' Sample Rate ');
    out4 = sprintf(' srmin  = %8.4g samples/sec  ',1/dtmax);
    out5 = sprintf(' sr     = %8.4g samples/sec  ',1/dt);
    out6 = sprintf(' srmax  = %8.4g samples/sec  ',1/dtmin);
    disp(out4)
    disp(out5)
    disp(out6)
    clear t;
%
    disp(' ')
    disp(' Amplitude Stats ')
     out0 = sprintf(' number of points = %d ',n);
    out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
    out2a = sprintf(' max  = %9.4g  at  = %8.4g sec             ',mx,tt_max);
    out2b = sprintf(' min  = %9.4g  at  = %8.4g sec            \n',mi,tt_min);
    disp(out0);
    disp(out1);
    disp(out2a);
    disp(out2b);
%
    amax=abs(mx);
    amin=abs(mi);
    if(amax<amin)
        amax=amin;
    end
    crest=amax/rms;
    out4 = sprintf(' crest factor = %8.4g ',crest);
    out5 = sprintf(' skewness = %8.4g  kurtosis  = %8.4g ',sk,kt);
    disp(out4);
    disp(out5);
%
    nzc=0;
    pzc=0;
    for i=1:n-1
%
       if(amp(i) <=0 && amp(i+1) > 0)
           pzc=pzc+1;
       end
%       
       if(amp(i) >=0 && amp(i+1) < 0)
           nzc=nzc+1;      
       end 
    end
%
    out6=sprintf('\n positive zero crossings = %d \n negative zero crossings = %d \n',pzc,nzc);
    disp(out6);    
    %
    j=1;
%
    clear np;
    clear pp;
    clear abs;
    clear pa;
%
    np=0;
    pp=0;
%
%  do not initialize pa with zeros because do not know final size
%
    for i=2:(n-1)
        if( amp(i)>=amp(i-1) && amp(i)>=amp(i+1) && amp(i)>0 )
            pa(j)=abs(amp(i));
            j=j+1;
            pp=pp+1;
        end
        if( amp(i)<=amp(i-1) && amp(i)<=amp(i+1)&& amp(i)<0 )
            pa(j)=abs(amp(i));
            j=j+1;
            np=np+1;
        end
    end
%
    out9 =sprintf(' number of positive peaks = %d \n number of negative peaks = %d ',pp,np);
    disp(out9);
    out10 =sprintf(' total peaks = %d ',pp+np);
    disp(out10);  
%
    rr=(pzc+nzc)/(pp+np);
    out1=sprintf('\n zero crossings/peaks = %8.4g ',rr);
    disp(out1);
%
    [v]=differentiate_function(amp,dt);
    rf=(std(v)/std(amp))/(2*pi);
%
    out1=sprintf('\n Rice Characteristic Frequency = %8.4g Hz ',rf);
    disp(out1);
%
    disp(' ')
    fig_num=1;
%
    figure(fig_num);
    fig_num=fig_num+1;        
    plot(tim,amp)
    xlabel(' Time (sec)');
    zoom on;
    grid on;
%
    disp(' Plot histogram? ')
    choice = input(' 1=yes 2=no ');
%
    if(choice == 1)
%
        [fig_num]=plot_histogram(amp,'Amplitude',fig_num);
%   
        disp(' ')
        disp(' Plot cumulative histogram? ')
            cum_choice = input(' 1=yes 2=no '); 
% 
            if(cum_choice==1)
                disp(' ');
                disp(' Enter the number of bars ');
                nbar=input(' ');
                [nnn,xout]=hist(amp,nbar);
                c_elements = cumsum(nnn);
                fig_num=fig_num+1;
                figure(fig_num);
                bar(xout,c_elements);
                title(' Cumulative Histogram ');
                ylabel(' Counts ');
                xlabel('Amplitude');
                grid on;
            end
%
    end
%
    disp(' ')
    disp(' Plot absolute value peak distribution? ')
    choice = input(' 1=yes 2=no ');
%
    if(choice==1)
        [~]=...
        plot_peak_histogram(pa,'Histogram of Absolute Values of Peaks',fig_num);
    end