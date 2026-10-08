function varargout = vibrationdata_sdof_Force(varargin)
% VIBRATIONDATA_SDOF_FORCE MATLAB code for vibrationdata_sdof_Force.fig
%      VIBRATIONDATA_SDOF_FORCE, by itself, creates a new VIBRATIONDATA_SDOF_FORCE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SDOF_FORCE returns the handle to a new VIBRATIONDATA_SDOF_FORCE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SDOF_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SDOF_FORCE.M with the given input arguments.
%
%      VIBRATIONDATA_SDOF_FORCE('Property','Value',...) creates a new VIBRATIONDATA_SDOF_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_sdof_Force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_sdof_Force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_sdof_Force

% Last Modified by GUIDE v2.5 05-Jan-2015 12:25:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_sdof_Force_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_sdof_Force_OutputFcn, ...
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


% --- Executes just before vibrationdata_sdof_Force is made visible.
function vibrationdata_sdof_Force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_sdof_Force (see VARARGIN)

% Choose default command line output for vibrationdata_sdof_Force
handles.output = hObject;

set(handles.text_mass,'String','Enter Mass (lbm)');
set(handles.listbox_force_unit,'Value',1);
set(handles.listbox_method,'Value',1);

set(handles.edit_Q,'String','10');

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');

set(handles.edit_results,'Enable','off');

set(handles.pushbutton_statistics,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_sdof_Force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_sdof_Force_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
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

n=get(handles.listbox_output_type,'Value');

if(n==1)
    data=getappdata(0,'accel');   
end
if(n==2)
    data=getappdata(0,'velox');
end
if(n==3)
    data=getappdata(0,'displ');
end
if(n==4)
    data=getappdata(0,'trans_force'); 
end

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

set(handles.pushbutton_statistics,'Visible','on');

h = msgbox('Save Complete'); 

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


% --- Executes on selection change in listbox_output_type.
function listbox_output_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_type


% --- Executes during object creation, after setting all properties.
function listbox_output_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(hObject,'Value');

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
    
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');

   set(handles.edit_input_array,'enable','off')
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
end

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method


% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n_force_mass_unit=get(handles.listbox_force_unit,'Value');

set(handles.edit_results,'Enable','on');

k=get(handles.listbox_method,'Value');

 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

t=THM(:,1);
f=double(THM(:,2));

n=length(f);

dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);
sr=1/dt;

mass=str2num(get(handles.edit_mass,'String'));
Q=str2num(get(handles.edit_Q,'String'));
fn=str2num(get(handles.edit_fn,'String'));

damp=1/(2*Q);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[accel,velox,displ,trans_force]=...
               arbit_force_function(t,f,dt,mass,fn,damp,n_force_mass_unit);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(n_force_mass_unit==1)
    string1=sprintf(' Displacement (inch) '); 
    string5=sprintf('\n\n Velocity (in/sec) ');
    string9=sprintf('\n\n Acceleration (G) ');
    string13=sprintf('\n\n Transmitted Force (lbf) ');
else
    string1=sprintf(' Displacement (mm) '); 
    string5=sprintf('\n\n Velocity (m/sec) ');
    string9=sprintf('\n\n Acceleration (G) ');
    string13=sprintf('\n\n Transmitted Force (N) ');    
end

drms=sqrt((std(displ(:,2)))^2+(mean(displ(:,2)))^2);
vrms=sqrt((std(velox(:,2)))^2+(mean(velox(:,2)))^2);
arms=sqrt((std(accel(:,2)))^2+(mean(accel(:,2)))^2);
tfrms=sqrt((std(trans_force(:,2)))^2+(mean(trans_force(:,2)))^2);

string2=sprintf('\n Max= %7.4g',max(displ(:,2)));
string3=sprintf('\n Min= %7.4g',min(displ(:,2)));
string4=sprintf('\n RMS= %7.4g',drms);    

string6=sprintf('\n Max= %7.4g',max(velox(:,2)));
string7=sprintf('\n Min= %7.4g',min(velox(:,2)));
string8=sprintf('\n RMS= %7.4g',vrms);

string10=sprintf('\n Max= %7.4g',max(accel(:,2)));
string11=sprintf('\n Min= %7.4g',min(accel(:,2)));
string12=sprintf('\n RMS= %7.4g',arms);

string14=sprintf('\n Max= %7.4g',max(trans_force(:,2)));
string15=sprintf('\n Min= %7.4g',min(trans_force(:,2)));
string16=sprintf('\n RMS= %7.4g',tfrms);
    
string_big=string1;
string_big=strcat(string_big,string2);
string_big=strcat(string_big,string3);
string_big=strcat(string_big,string4);
string_big=strcat(string_big,string5);
string_big=strcat(string_big,string6);
string_big=strcat(string_big,string7);
string_big=strcat(string_big,string8);
string_big=strcat(string_big,string9);
string_big=strcat(string_big,string10);
string_big=strcat(string_big,string11);
string_big=strcat(string_big,string12);
string_big=strcat(string_big,string13);
string_big=strcat(string_big,string14);
string_big=strcat(string_big,string15);
string_big=strcat(string_big,string16);

set(handles.edit_results,'String',string_big);

setappdata(0,'accel',accel);   
setappdata(0,'velox',velox); 
setappdata(0,'displ',displ);   
setappdata(0,'trans_force',trans_force); 

set(handles.pushbutton_save,'Enable','on');
set(handles.edit_output_array,'Enable','on');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_sdof_Force)

% --- Executes on selection change in listbox_force_unit.
function listbox_force_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force_unit

n=get(hObject,'Value');

if(n==1)
    set(handles.text_mass,'String','Enter Mass (lbm)');
else
    set(handles.text_mass,'String','Enter Mass (kg)');    
end


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



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_statistics.
function pushbutton_statistics_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_statistics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= vibrationdata_statistics;

set(handles.s,'Visible','on');     
