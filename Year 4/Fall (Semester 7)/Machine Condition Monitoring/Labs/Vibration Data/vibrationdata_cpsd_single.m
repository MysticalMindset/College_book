function varargout = vibrationdata_cpsd_single(varargin)
% VIBRATIONDATA_CPSD_SINGLE MATLAB code for vibrationdata_cpsd_single.fig
%      VIBRATIONDATA_CPSD_SINGLE, by itself, creates a new VIBRATIONDATA_CPSD_SINGLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_CPSD_SINGLE returns the handle to a new VIBRATIONDATA_CPSD_SINGLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_CPSD_SINGLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_CPSD_SINGLE.M with the given input arguments.
%
%      VIBRATIONDATA_CPSD_SINGLE('Property','Value',...) creates a new VIBRATIONDATA_CPSD_SINGLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_cpsd_single_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_cpsd_single_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_cpsd_single

% Last Modified by GUIDE v2.5 01-Jul-2013 13:13:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_cpsd_single_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_cpsd_single_OutputFcn, ...
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


% --- Executes just before vibrationdata_cpsd_single is made visible.
function vibrationdata_cpsd_single_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_cpsd_single (see VARARGIN)

% Choose default command line output for vibrationdata_cpsd_single
handles.output = hObject;

set(handles.listbox_type,'Value',1);
set(handles.edit_ylabel_input,'String','G');

set(handles.pushbutton_save,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_cpsd_single wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_cpsd_single_OutputFcn(hObject, eventdata, handles) 
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

df=1/(n*dt);


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

fig_num=3;

%%

    nhalf=floor(n/2);
%
    [zA,zzA,A_real,A_imag,~,~,~]     =fourier_core(n,nhalf,df,A);
    [zB,zzB,B_real,B_imag,ms,freq,ff]=fourier_core(n,nhalf,df,B);
%
    A_complex=complex(A_real,A_imag);
    B_complex=complex(B_real,B_imag);    
%
    CPSD=conj(A_complex).*B_complex/df;   % two-sided
%  
    CPSD_mag=abs(CPSD);
%   
    CPSD_phase=(180/pi)*atan2(imag(CPSD),real(CPSD));    
%    
    CPSD_m(1)=CPSD_mag(1);
    CPSD_m(2:nhalf)=2*CPSD_mag(2:nhalf);
%
    rms=sqrt(df*sum(CPSD_m));
%
    CPSD_p=CPSD_phase(1:nhalf);
%
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
    [xmax,fmax]=find_max([ff CPSD_m]);
%
    out5 = sprintf('\n Peak occurs at %10.5g Hz ',fmax);
    disp(out5)
%


%%
cpsd=[ff CPSD_m CPSD_p];


setappdata(0,'Cross_PSD',cpsd);

set(handles.pushbutton_save,'Enable','on');

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_cpsd_single);



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
