function varargout = vibrationdata_cpsd_ensemble(varargin)
% VIBRATIONDATA_CPSD_ENSEMBLE MATLAB code for vibrationdata_cpsd_ensemble.fig
%      VIBRATIONDATA_CPSD_ENSEMBLE, by itself, creates a new VIBRATIONDATA_CPSD_ENSEMBLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_CPSD_ENSEMBLE returns the handle to a new VIBRATIONDATA_CPSD_ENSEMBLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_CPSD_ENSEMBLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_CPSD_ENSEMBLE.M with the given input arguments.
%
%      VIBRATIONDATA_CPSD_ENSEMBLE('Property','Value',...) creates a new VIBRATIONDATA_CPSD_ENSEMBLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_cpsd_ensemble_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_cpsd_ensemble_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_cpsd_ensemble

% Last Modified by GUIDE v2.5 01-Jul-2013 17:44:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_cpsd_ensemble_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_cpsd_ensemble_OutputFcn, ...
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


% --- Executes just before vibrationdata_cpsd_ensemble is made visible.
function vibrationdata_cpsd_ensemble_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_cpsd_ensemble (see VARARGIN)

% Choose default command line output for vibrationdata_cpsd_ensemble
handles.output = hObject;

set(handles.listbox_type,'Value',1);
set(handles.edit_ylabel_input,'String','G');

set(handles.pushbutton_calculate,'Enable','off');

set(handles.listbox_numrows,'Enable','off');
set(handles.listbox_numrows,'Visible','off');
set(handles.text_select_option,'Visible','off');

set(handles.uitable_advise,'Visible','off');

set(handles.pushbutton_save,'Enable','off');

set(handles.pushbutton_view_options,'Enable','on');

set(handles.edit_fmax,'String','');
set(handles.edit_fmin,'String','');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_cpsd_ensemble wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_cpsd_ensemble_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

THM=getappdata(0,'THM_C');

t=THM(:,1);
a=THM(:,2);
b=THM(:,3);

pp=get(handles.listbox_mean_removal,'Value');

if(pp==1)
    a=a-mean(a);
    b=b-mean(b);
end    

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

if(m==1)
    out2=sprintf('Accel (%s^2/Hz)',YS);
    if( k>=1)
      out2=sprintf('Accel ((%s)^2/Hz)',YS);        
    end
end
if(m==2)
    out2=sprintf('Vel ((%s)^2/Hz)',YS);
    if( k>=1)
      out2=sprintf('Vel ((%s)^2/Hz)',YS);        
    end    
end
if(m==3)
    out2=sprintf('Disp (%s^2/Hz)',YS);
end
if(m==4)
    out2=sprintf('Force (%s^2/Hz)',YS);
end
if(m==5)
    out2=sprintf('Pressure (%s^2/Hz)',YS);
    if( k>=1)
      out2=sprintf('Pressure ((%s)^2/Hz)',YS);        
    end     
end
if(m==6)
    out2=sprintf('(%s^2/Hz)',YS);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

advise_data=getappdata(0,'advise_data');

q=get(handles.listbox_numrows,'Value');

NW=advise_data(q,1);  % Number of Segments

mmm = 2^fix(log(n/NW)/log(2));
%
df=1./(mmm*dt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
%
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
    end
%
    den=df*(2*NW-1);
    CPSD=CPSD/den;
    PSD_A=PSD_A/den;
    PSD_B=PSD_B/den; 
%
    CPSD_mag=abs(CPSD);
    CPSD_phase=(180/pi)*atan2(imag(CPSD),real(CPSD));
%
    COH=zeros(mH,1);
    for i=1:mH
        COH(i)=CPSD_mag(i)^2/( PSD_A(i)*PSD_B(i) );
    end    
%
    fmax=(mH-1)*df;
    freq=linspace(0,fmax,mH);
 %   
    clear sum;
    ms=sum(CPSD_mag);
%
    rms=sqrt(ms*df);
%
    disp(' ');
    out4 = sprintf(' Overall RMS = %10.3g ',rms);
    out5 = sprintf(' Three Sigma = %10.3g ',3*rms);
    disp(out4)
    disp(out5)
    disp(' ');
%
    CPSD_m(1)=CPSD_mag(1);
    CPSD_m(2:mH)=2*CPSD_mag(2:mH);
%
    rms=sqrt(df*sum(CPSD_m));
%
    CPSD_p=CPSD_phase(1:mH);
%

ff=freq;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=3;

   t_string=sprintf('Cross Power Spectral Density %6.3g %sRMS Overall ',rms,YS);
%
    figure(fig_num);
    fig_num=fig_num+1;
%
    subplot(3,1,1);
    plot(ff,CPSD_p);
    title(t_string);
    grid on;
    ylabel('Phase (deg)');
    axis([fmin,fmax,-180,180]);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','ytick',[-180,-90,0,90,180]);
%
    subplot(3,1,[2 3]);
    plot(ff,CPSD_m);
    grid on;
    xlabel('Frequency(Hz)');
    ylabel(out2);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','log');
%
    ymax=10^(ceil(log10(max(CPSD_m))));
    ymin=10^(floor(log10(min(CPSD_m))));
%
    if(ymin<ymax/10000)
        ymin=ymax/10000;
    end
%
    axis([fmin,fmax,ymin,ymax]);    
%
    ff=fix_size(ff);
    CPSD_m=fix_size(CPSD_m);
    CPSD_p=fix_size(CPSD_p);
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
    axis([fmin,fmax,ymin,ymax]); 
%

    [xmax,fmax]=find_max([ff CPSD_m]);
%
    out5 = sprintf('\n Peak occurs at %10.5g Hz ',fmax);
    disp(out5)
%

cpsd=[ff CPSD_m CPSD_p];
setappdata(0,'Cross_PSD',cpsd);

set(handles.pushbutton_save,'Enable','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_cpsd_ensemble);


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


cpsd=getappdata(0,'Cross_PSD');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, cpsd);

h = msgbox('Save Complete.  Format: freq, magnitude, phase'); 


% --- Executes on button press in pushbutton_view_options.
function pushbutton_view_processing_options_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
