function varargout = sdof_free_vibration(varargin)
% SDOF_FREE_VIBRATION MATLAB code for sdof_free_vibration.fig
%      SDOF_FREE_VIBRATION, by itself, creates a new SDOF_FREE_VIBRATION or raises the existing
%      singleton*.
%
%      H = SDOF_FREE_VIBRATION returns the handle to a new SDOF_FREE_VIBRATION or the handle to
%      the existing singleton*.
%
%      SDOF_FREE_VIBRATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SDOF_FREE_VIBRATION.M with the given input arguments.
%
%      SDOF_FREE_VIBRATION('Property','Value',...) creates a new SDOF_FREE_VIBRATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sdof_free_vibration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sdof_free_vibration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sdof_free_vibration

% Last Modified by GUIDE v2.5 09-Jul-2015 16:50:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sdof_free_vibration_OpeningFcn, ...
                   'gui_OutputFcn',  @sdof_free_vibration_OutputFcn, ...
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


% --- Executes just before sdof_free_vibration is made visible.
function sdof_free_vibration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sdof_free_vibration (see VARARGIN)

% Choose default command line output for sdof_free_vibration
handles.output = hObject;

change_unit_method(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sdof_free_vibration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sdof_free_vibration_OutputFcn(hObject, eventdata, handles) 
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
fig_num=1;

iunit=get(handles.listbox_unit,'Value');


d0=str2num(get(handles.edit_id,'String'));
v0=str2num(get(handles.edit_iv,'String'));

if(iunit>=2)
    d0=d0/1000;
    v0=v0/100;
end

damp=(1/100)*str2num(get(handles.edit_damp,'String'));

if(damp>1)
    warndlg('Damping must be <= 100%% ');
    return;
end


nc=str2num(get(handles.edit_nc,'String'));

m=get(handles.listbox_method,'Value');

if(m==1)
    fn=str2num(get(handles.edit_fn,'String'));
    out1=sprintf(' fn=%g Hz',fn);
else
    
   mass=str2num(get(handles.edit_mass,'String'));    
   stiffness=str2num(get(handles.edit_stiffness,'String')); 
   
   if(iunit==1)
        mass=mass/386;
   else
        stiffness=stiffness*1000;
   end    
   
   fn=sqrt(stiffness/mass)/(2*pi);
   out1=sprintf(' fn=%8.4g Hz',fn);
end
disp(out1);

T=1/fn;

sr=64*fn;
dt=1/sr;

nt=ceil(nc*T/dt);


omegan=2*pi*fn;
omegan2=omegan^2;
omegad=sqrt(1-damp^2)*omegan;
domegan=damp*omegan;

t=zeros(nt,1);
a=zeros(nt,1);
v=zeros(nt,1);
d=zeros(nt,1);

R=( v0 + (domegan*d0))/omegad;

for i=1:nt
   t(i)=(i-1)*dt;
   
    eee=exp(-domegan*t(i));
   
   cwdt=cos(omegad*t(i));
   swdt=sin(omegad*t(i));
   
   if(damp<1)
   
        d(i)= eee*(d0*cwdt+R*swdt);
        v(i)= -domegan*d(i)+omegad*eee*(-d0*swdt+R*cwdt);
        a(i)= -omegan2*d(i)-2*domegan*v(i);
   
   else
        d(i)= eee*(d0+(v0+omegan*d0)*t(i));
        v(i)= -domegan*d(i)+(v0+omegan*d0);
        a(i)= -omegan2*d(i);
   end
end


if(iunit==1)
    a=a/386;
    ay='Accel (G)';
    vy='Vel (in/sec)';
    dy='Disp (in)';
end
if(iunit==2)
    a=a/9.81;
    ay='Accel (G)';    
end
if(iunit==3)
    ay='Accel (m/sec^2)';     
end
if(iunit==2 || iunit==3)
    v=v*100;
    d=d*1000;   
    vy='Vel (cm/sec)';
    dy='Disp (mm)';    
end


hp=figure(fig_num);
fig_num=fig_num+1;
subplot(3,1,1);
plot(t,a);
ylabel(ay);
grid on;
title('Free Vibration');
yLimits = get(gca,'YLim');
ya=max(abs(yLimits));
ylim([-ya,ya]);


subplot(3,1,2);
plot(t,v);
ylabel(vy);
grid on;
yLimits = get(gca,'YLim');
yv=max(abs(yLimits));
ylim([-yv,yv]);

subplot(3,1,3);
plot(t,d);
ylabel(dy);
xlabel('Time(sec)');
grid on;    
yLimits = get(gca,'YLim');
yd=max(abs(yLimits));
ylim([-yd,yd]);
    
%%%%%%%%%%%%%%%%%%%%%%


disp(' ');
disp(' Maximum Absolute Values ');
disp('  ');

out1=sprintf(' %s %8.4g  ',ay,max(abs(a)));
out2=sprintf(' %s %8.4g  ',vy,max(abs(v)));
out3=sprintf(' %s %8.4g  ',dy,max(abs(d)));

disp(out1);
disp(out2);
disp(out3);

%%%%%%%%%%%%%%%%%%%%%%

aname='free_acceleration';
vname='free_velocity';
dname='free_displacement';

assignin('base', aname, [t a]);
assignin('base', vname, [t v]);
assignin('base', dname, [t d]);

message = sprintf('\nOutput Time History Arrays:\n\n  %s\n  %s\n  %s',aname,vname,dname);


disp(message);

uiwait(msgbox(message,'Calculation Complete'));

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(sdof_free_vibrationdata);


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

change_unit_method(hObject, eventdata, handles);




% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_id_Callback(hObject, eventdata, handles)
% hObject    handle to edit_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_id as text
%        str2double(get(hObject,'String')) returns contents of edit_id as a double


% --- Executes during object creation, after setting all properties.
function edit_id_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_iv_Callback(hObject, eventdata, handles)
% hObject    handle to edit_iv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_iv as text
%        str2double(get(hObject,'String')) returns contents of edit_iv as a double


% --- Executes during object creation, after setting all properties.
function edit_iv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_iv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_damp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damp as text
%        str2double(get(hObject,'String')) returns contents of edit_damp as a double


% --- Executes during object creation, after setting all properties.
function edit_damp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nc as text
%        str2double(get(hObject,'String')) returns contents of edit_nc as a double


% --- Executes during object creation, after setting all properties.
function edit_nc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function change_unit_method(hObject, eventdata, handles)
%
n=get(handles.listbox_unit,'Value');

if(n==1)
    set(handles.text_id,'String','Initial Displacement (in)');
    set(handles.text_iv,'String','Initial Velocity (in/sec)');  
    set(handles.text_mass,'String','Mass (lbm)'); 
    set(handles.text_stiffness,'String','Stiffness (lbf/in)');     
else
    set(handles.text_id,'String','Initial Displacement (mm)');
    set(handles.text_iv,'String','Initial Velocity (cm/sec)');   
    set(handles.text_mass,'String','Mass (kg)');    
    set(handles.text_stiffness,'String','Stiffness (N/mm)');     
end

m=get(handles.listbox_method,'Value');

set(handles.edit_fn,'Visible','off');
set(handles.text_fn,'Visible','off');

set(handles.edit_mass,'Visible','off');
set(handles.text_mass,'Visible','off');

set(handles.edit_stiffness,'Visible','off');
set(handles.text_stiffness,'Visible','off');


if(m==1)
    set(handles.edit_fn,'Visible','on');
    set(handles.text_fn,'Visible','on');     
else
    set(handles.edit_mass,'Visible','on');
    set(handles.text_mass,'Visible','on');    
    set(handles.edit_stiffness,'Visible','on');
    set(handles.text_stiffness,'Visible','on');     
end


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

change_unit_method(hObject, eventdata, handles);


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



function edit_stiffness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
