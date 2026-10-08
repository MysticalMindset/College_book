function varargout = modal_frf_ensemble(varargin)
% MODAL_FRF_ENSEMBLE MATLAB code for modal_frf_ensemble.fig
%      MODAL_FRF_ENSEMBLE, by itself, creates a new MODAL_FRF_ENSEMBLE or raises the existing
%      singleton*.
%
%      H = MODAL_FRF_ENSEMBLE returns the handle to a new MODAL_FRF_ENSEMBLE or the handle to
%      the existing singleton*.
%
%      MODAL_FRF_ENSEMBLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODAL_FRF_ENSEMBLE.M with the given input arguments.
%
%      MODAL_FRF_ENSEMBLE('Property','Value',...) creates a new MODAL_FRF_ENSEMBLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modal_frf_ensemble_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modal_frf_ensemble_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modal_frf_ensemble

% Last Modified by GUIDE v2.5 03-Jul-2013 09:35:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modal_frf_ensemble_OpeningFcn, ...
                   'gui_OutputFcn',  @modal_frf_ensemble_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before modal_frf_ensemble is made visible.
function modal_frf_ensemble_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modal_frf_ensemble (see VARARGIN)

% Choose default command line output for modal_frf_ensemble
handles.output = hObject;

set(handles.listbox_save,'Value',1);
set(handles.listbox_type,'Value',1);

set(handles.edit_ylabel_input,'String','G');

set(handles.pushbutton_calculate,'Enable','off');

set(handles.listbox_numrows,'Enable','off');
set(handles.listbox_numrows,'Visible','off');
set(handles.text_select_option,'Visible','off');

set(handles.uitable_advise,'Visible','off');

set(handles.pushbutton_save,'Enable','off');

set(handles.pushbutton_view_options,'Enable','on');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes modal_frf_ensemble wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = modal_frf_ensemble_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * ');
disp(' ');


THM=getappdata(0,'THM_C');

t=THM(:,1);
a=THM(:,2);
b=THM(:,3);

pp=get(handles.listbox_mean_removal,'Value');

if(pp==1)
    a=a-mean(a);
    b=b-mean(b);
end    

i=get(handles.listbox_force_unit,'Value');

if(i==1)
  YF='Force (lbf)';
  FU='lbf';
else
  YF='Force (N)';
  FU='N';
end

i=get(handles.listbox_type,'Value');

if(i==1)
  YR1='Acceleration';
end
if(i==2)
  YR1='Velocity';
end
if(i==3)
  YR1='Displacement';
end

YU=get(handles.edit_ylabel_input,'String');

YR2=sprintf(' (%s)',YU);

YR=strcat(YR1,YR2);


figure(1);
plot(t,a);
grid on;
xlabel('Time(sec)');
ylabel(YF);
title('Force Signal');

figure(2);
plot(t,b);
grid on;
xlabel('Time(sec)');
ylabel(YR);
title('Response Signal');


A=a;
B=b;

num=length(t);
dt=(t(num)-t(1))/(num-1);

dur=num*dt;

n=num;

%%
YS=get(handles.edit_ylabel_input,'String');
m=get(handles.listbox_type,'Value');

k = strfind(YS,'/');

out2=sprintf('%s/Force (%s/%s)',YR1,YU,FU);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

advise_data=getappdata(0,'advise_data');

q=get(handles.listbox_numrows,'Value');

NW=advise_data(q,1);  % Number of Segments

mmm = 2^fix(log(n/NW)/log(2));
%
df=1./(mmm*dt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sfmin=get(handles.edit_fmin,'String');
sfmax=get(handles.edit_fmax,'String');


if isempty(sfmin)
    string=sprintf('%8.4g',df);
    set(handles.edit_fmin,'String',string); 
    sfmin=get(handles.edit_fmin,'String');    
end

if isempty(sfmax)
    sr=1/dt;
    nyf=sr/2;
    string=sprintf('%8.4g',nyf);
    set(handles.edit_fmax,'String',string);
    sfmax=get(handles.edit_fmax,'String');    
end

fmin=str2num(sfmin);
fmax=str2num(sfmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mr_choice=get(handles.listbox_mean_removal,'Value');

h_choice =get(handles.listbox_window,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  mH=((mmm/2)-1);
%
    full=zeros(mH,1);
    mag_seg=zeros(mH,1);
%
    nov=0;
%
    clear amp_seg_A;
    clear amp_seg_B;
%
    CPSD=zeros(mmm,1); 
    PSD_A=zeros(mmm,1); 
    PSD_B=zeros(mmm,1);
    H1=zeros(mmm,1);
    H2=zeros(mmm,1);
%
    H1_length=mmm;
    
    for ijk=1:(2*NW-1)
%
        amp_seg_A=zeros(mmm,1);
        amp_seg_A(1:mmm)=A((1+ nov):(mmm+ nov));  
%
        amp_seg_B=zeros(mmm,1);
        amp_seg_B(1:mmm)=B((1+ nov):(mmm+ nov));  
%
        nov=nov+fix(mmm/2);
%
        [complex_FFT_A]=CFFT_core(amp_seg_A,mmm,mH,mr_choice,h_choice);
        [complex_FFT_B]=CFFT_core(amp_seg_B,mmm,mH,mr_choice,h_choice);        
%
        CPSD=CPSD+(conj(complex_FFT_A)).*complex_FFT_B/df;   % two-sided
        PSD_A=PSD_A+(conj(complex_FFT_A)).*complex_FFT_A/df;
        PSD_B=PSD_B+(conj(complex_FFT_B)).*complex_FFT_B/df;
%
        GFX=(conj(complex_FFT_A)).*complex_FFT_B;
        GXF=(conj(complex_FFT_B)).*complex_FFT_A;
%        
        GFF=(conj(complex_FFT_A)).*complex_FFT_A;
        GXX=(conj(complex_FFT_B)).*complex_FFT_B;
%
%%%%%%%%%%%%%%%

        for i=1:H1_length
            
            if(isnan(GFF(i))==1 ||  isinf(GFF(i))==1 || isnan(GFX(i))==1 ||  isinf(GFX(i))==1)
            else
                H1L=GFX(i)./GFF(i);
                
                if(abs(H1L)<1.0e+80)
                    H1(i)=H1(i)+H1L;
                end    
            end
                
            if(isnan(GXF(i))==1 ||  isinf(GXF(i))==1 || isnan(GXX(i))==1 ||  isinf(GXX(i))==1)
            else
                H2L=GXX(i)./GXF(i);
                
                if(abs(H2L)<1.0e+80)
                    H2(i)=H2(i)+H2L;
                end                   
            end           
            
        end
            
%%%%%%%%%%%%%%%
%
%%        H1L=GFX./GFF;
%%        H2L=GXX./GXF;
%
%%        H1=H1+H1L;
%%        H2=H2+H2L;
%
    end
%
    den=df*(2*NW-1);
    CPSD=CPSD/den;
    PSD_A=PSD_A/den;
    PSD_B=PSD_B/den;
    H1=H1/den;
    H2=H2/den;  
%
    
    for ijk=1:H1_length
        if(isnan(H1(ijk))==1 ||  isinf(H1(ijk))==1)
            out1=sprintf('1   %d  %g ',ijk,H1(ijk));
            disp(out1);            
            H1(ijk)=0+0i;
        end
        if(isnan(H2(ijk))==1 ||  isinf(H2(ijk))==1)
            out1=sprintf('2   %d  %g ',ijk,H2(ijk));
            disp(out1);            
            H2(ijk)=0+0i;
        end 
        
        if(abs(H1(ijk))<1.0e+80)
        else
            out1=sprintf('3   %d  %g ',ijk,H1(ijk));
            disp(out1);            
            H1(ijk)=0+0i;
        end
        if(abs(H2(ijk))<1.0e+80)
        else
            out1=sprintf('4   %d  %g ',ijk,H2(ijk));
            disp(out1);            
            H2(ijk)=0+0i;
        end       
                      
    end
    
    H1_mag=abs(H1);
    H2_mag=abs(H2); 

  

    H1_phase=(180/pi)*atan2(imag(H1),real(H1));
    H2_phase=(180/pi)*atan2(imag(H2),real(H2));     
    
%
    CPSD_mag=abs(CPSD);
    CPSD_phase=(180/pi)*atan2(imag(CPSD),real(CPSD));  
%
    fffmax=(mH-1)*df;
    freq=linspace(0,fffmax,mH);
%
    CPSD_m(1)=CPSD_mag(1);
    CPSD_m(2:mH)=2*CPSD_mag(2:mH);
    CPSD_p=CPSD_phase(1:mH);
%
    H1_m(1)=H1_mag(1);
    H1_m(2:mH)=2*H1_mag(2:mH);
    H1_p=H1_phase(1:mH);
%
    H2_m(1)=H2_mag(1);
    H2_m(2:mH)=2*H2_mag(2:mH);
    H2_p=H2_phase(1:mH);
%
    COH=zeros(mH,1);
    H1_real=zeros(mH,1);
    H1_imag=zeros(mH,1);
    H2_real=zeros(mH,1);
    H2_imag=zeros(mH,1);
%    
    for i=1:mH
%        
        COH(i)=CPSD_mag(i)^2/( PSD_A(i)*PSD_B(i) );
%
        H1_real(i)=real(H1(i));
        H1_imag(i)=imag(H1(i)); 
        H2_real(i)=real(H2(i));
        H2_imag(i)=imag(H2(i));   
%
    end   
%

ff=freq;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    ff=fix_size(ff);
    
    H1_m=fix_size(H1_m);
    H1_p=fix_size(H1_p);
    H1_real=fix_size(H1_real);
    H1_imag=fix_size(H1_imag);

    H2_m=fix_size(H2_m);
    H2_p=fix_size(H2_p);
    H2_real=fix_size(H2_real);
    H2_imag=fix_size(H2_imag);

    
tmp = abs(ff-fmin);
[c,idx1] = min(tmp);     

tmp = abs(ff-fmax);
[c,idx2] = min(tmp);


[xtt,xTT,iflag]=xtick_label(fmin,fmax);    

if(iflag==1)
    fmin=min(xtt);
    fmax=max(xtt);             
end



fig_num=3;
%
   t_string=sprintf('H1 Frequency Response Function ');
%
    figure(fig_num);
    fig_num=fig_num+1;
%
    subplot(3,1,1);
    plot(ff,H1_p);
    
    title(t_string);
    grid on;
    ylabel('Phase (deg)');      
    
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end
    axis([fmin,fmax,-180,180]);
        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','ytick',[-180,-90,0,90,180]);    
%
    subplot(3,1,[2 3]);
    plot(ff,H1_m);
    grid on;
    xlabel('Frequency(Hz)');
    ylabel(out2);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','log');
%
    ymax=10^(ceil(log10(max(H1_m(idx1:idx2)))));
    ymin=10^(floor(log10(min(H1_m(idx1:idx2)))));
%
    if(ymin<ymax/10000)
        ymin=ymax/10000;
    end
%
    
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end
    axis([fmin,fmax,ymin,ymax]);    
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   t_string=sprintf('H2 Frequency Response Function ');
%
    figure(fig_num);
    fig_num=fig_num+1;
%
    subplot(3,1,1);
    plot(ff,H2_p);
    title(t_string);
    grid on;
    ylabel('Phase (deg)');

    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end    
    axis([fmin,fmax,-180,180]);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','ytick',[-180,-90,0,90,180]);
%
    subplot(3,1,[2 3]);
    plot(ff,H2_m);
    grid on;
    xlabel('Frequency(Hz)');
    ylabel(out2);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','log');
%
    ymax=10^(ceil(log10(max(H2_m(idx1:idx2)))));
    ymin=10^(floor(log10(min(H2_m(idx1:idx2)))));
%
    if(ymin<ymax/10000)
        ymin=ymax/10000;
    end
%
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end
    axis([fmin,fmax,ymin,ymax]);    
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    figure(fig_num);
    fig_num=fig_num+1;
    
    plot(freq,COH);
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','lin');
    xlabel('Frequency(Hz)'); 
    ylabel('(\gamma_x_y)^2'); 
    title('Coherence');   
    ymin=0.;
    ymax=1.;
    
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end    
    axis([fmin,fmax,ymin,ymax]); 
%

    [xmax,ffmax]=find_max([ff(idx1:idx2) H1_m(idx1:idx2)]);
%
    out5 = sprintf('\n H1 Peak occurs at %10.5g Hz within plot limits',ffmax);
    disp(out5)
%

%%

H1_m_store=[ff H1_m];
setappdata(0,'H1_m_store',H1_m_store);

H1_mp_store=[ff H1_m H1_p];
setappdata(0,'H1_mp_store',H1_mp_store);

H1_complex_store=[ff H1_real H1_imag];
setappdata(0,'H1_complex_store',H1_complex_store);

%%%

H2_m_store=[ff H2_m];
setappdata(0,'H2_m_store',H2_m_store);

H2_mp_store=[ff H2_m H2_p];
setappdata(0,'H2_mp_store',H2_mp_store);

H2_complex_store=[ff H2_real H2_imag];
setappdata(0,'H2_complex_store',H2_complex_store);

%%%

COH_store=[ff COH];
setappdata(0,'COH_store',COH_store);


set(handles.pushbutton_save,'Enable','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(modal_frf_ensemble);

% --- Executes on button press in pushbutton_view_options.
function pushbutton_view_options_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.listbox_numrows,'Visible','on');
set(handles.listbox_numrows,'Enable','on');
set(handles.text_select_option,'Visible','on');

set(handles.uitable_advise,'Visible','on');
set(handles.uitable_advise,'Enable','on');


THM=getappdata(0,'THM_C');

t=THM(:,1);
a=THM(:,2);
b=THM(:,3);

num=length(t);
dt=(t(num)-t(1))/(num-1);

dur=num*dt;

n=num;

%%%%%%%%

NC=0;
for i=1:1000
%    
    nmp = 2^(i-1);
%   
    if(nmp <= n )
        ss(i) = 2^(i-1);
        seg(i) =n/ss(i);
        i_seg(i) = fix(seg(i));
        NC=NC+1;
    else
        break;
    end
end

disp(' ')
out4 = sprintf(' Number of   Samples per   Time per        df               ');
out5 = sprintf(' Segments     Segment      Segment(sec)   (Hz)     dof     ');
%
disp(out4)
disp(out5)
%
k=1;
for i=1:NC
    j=NC+1-i;
    if j>0
        if( i_seg(j)>0 )
%           str = int2str(i_seg(j));
            tseg=dt*ss(j);
            ddf=1./tseg;
            out4 = sprintf(' %8d  %8d    %11.5f    %9.4f   %d',i_seg(j),ss(j),tseg,ddf,2*i_seg(j));
            disp(out4)
            data(k,:)=[i_seg(j),ss(j),tseg,ddf,2*i_seg(j)];
            k=k+1;
        end
    end
    if(i==12)
        break;
    end
end
%

max_num_rows=k-1;

for i=1:max_num_rows
    handles.number(i)=i;
end

set(handles.listbox_numrows,'String',handles.number);

cn={'No. of Segments ','Samples/Segments','Time/Segment (sec)','df (Hz)','dof'};

set(handles.uitable_advise,'Data',data,'ColumnWidth','auto','ColumnName',cn);

setappdata(0,'advise_data',data);

set(handles.pushbutton_calculate,'Enable','on');

%%%%%%%%


function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'H1_m_store');
end
if(n==2)
    data=getappdata(0,'H1_mp_store');
end    
if(n==3)
    data=getappdata(0,'H1_complex_store');
end
if(n==4)
    data=getappdata(0,'H2_m_store');
end
if(n==5)
    data=getappdata(0,'H2_mp_store');
end
if(n==6)
    data=getappdata(0,'H2_complex_store');
end
if(n==7)
    data=getappdata(0,'COH_store');
end

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete');

% --- Executes on selection change in listbox_numrows.
function listbox_numrows_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_numrows contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_numrows


% --- Executes during object creation, after setting all properties.
function listbox_numrows_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_mean_removal.
function listbox_mean_removal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mean_removal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mean_removal


% --- Executes during object creation, after setting all properties.
function listbox_mean_removal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_window.
function listbox_window_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_window contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_window


% --- Executes during object creation, after setting all properties.
function listbox_window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_input_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_input as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_input as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_force_unit.
function listbox_force_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force_unit


% --- Executes during object creation, after setting all properties.
function listbox_force_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_force_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
