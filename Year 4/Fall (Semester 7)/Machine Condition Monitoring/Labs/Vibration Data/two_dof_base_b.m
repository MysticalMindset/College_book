function varargout = two_dof_base_b(varargin)
% TWO_DOF_BASE_B MATLAB code for two_dof_base_b.fig
%      TWO_DOF_BASE_B, by itself, creates a new TWO_DOF_BASE_B or raises the existing
%      singleton*.
%
%      H = TWO_DOF_BASE_B returns the handle to a new TWO_DOF_BASE_B or the handle to
%      the existing singleton*.
%
%      TWO_DOF_BASE_B('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_BASE_B.M with the given input arguments.
%
%      TWO_DOF_BASE_B('Property','Value',...) creates a new TWO_DOF_BASE_B or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_base_b_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_base_b_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_base_b

% Last Modified by GUIDE v2.5 20-Aug-2014 09:33:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_base_b_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_base_b_OutputFcn, ...
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


% --- Executes just before two_dof_base_b is made visible.
function two_dof_base_b_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_base_b (see VARARGIN)

% Choose default command line output for two_dof_base_b
handles.output = hObject;

fstr='two_dof_base_bi.jpg';
 
bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes2);
image(bg);
 
pos1 = getpixelposition(handles.uipanel_data,true);

x=round(0.5*pos1(3)-0.5*w);
y=round(0.5*pos1(4)-0.65*h);
 
set(handles.axes2, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [x y w h]);
axis off;



fig_num=1;

setappdata(0,'fig_num',fig_num);

clear_buttons(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_base_b wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function clear_buttons(hObject, eventdata, handles)
set(handles.enter_damping_pushbutton,'Visible','off');
set(handles.transmissibility_pushbutton,'Visible','off');
set(handles.steady_sine_pushbutton,'Visible','off');
set(handles.half_sine_pushbutton,'Visible','off');
set(handles.arbitrary_pulse_pushbutton,'Visible','off');
set(handles.PSD_pushbutton,'Visible','off');
set(handles.pushbutton_SRS,'Visible','off');

% --- Outputs from this function are returned to the command line.
function varargout = two_dof_base_b_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in fn_pushbutton.
function fn_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fn_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
iu=get(handles.units_listbox,'value');

m1=str2num( get(handles.mass1_edit,'String' ));
m2=str2num( get(handles.mass2_edit,'String' ));
k1=str2num( get(handles.stiffness1_edit,'String' ));
k2=str2num( get(handles.stiffness2_edit,'String' ));
k3=str2num( get(handles.stiffness3_edit,'String' ));

mass=zeros(2,2);


mass(1,1)=m1;
mass(2,2)=m2;

stiffness=[(k1+k2) -k2; -k2 (k2+k3)];

%
if(iu==1)
   mass=mass/386.;
end
%
disp(' ');
[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,2);
%
disp(' ');
dof=2;
%
disp(' ');
%
for i=1:dof
  v(i)=1.;
end
%
disp('        Natural    Participation    Effective  ');
disp('Mode   Frequency      Factor        Modal Mass ');
%
LM=MST*mass*v';
pf=LM;
sum=0;
%    
mmm=MST*mass*ModeShapes;   
%
for i=1:dof
        pff(i)=pf(i)/mmm(i,i);
        emm(i)=pf(i)^2/mmm(i,i);
        out1 = sprintf('%d  %10.4g Hz   %10.4g   %10.4g',i,fn(i),pff(i),emm(i) );
        disp(out1)
        sum=sum+emm(i);
end
out1=sprintf('\n modal mass sum = %8.4g \n',sum);
disp(out1);

disp(' ');
disp(' mass matrix ');
mass
disp(' ');
disp(' stiffness matrix ');
stiffness
disp(' ');
ModeShapes
%
setappdata(0,'unit',iu);
setappdata(0,'m2',mass);
setappdata(0,'k2',stiffness);
setappdata(0,'fn',fn);
setappdata(0,'ModeShapes',ModeShapes);

PF=pf;
if(iu==1)
    PF=PF/386;
end

setappdata(0,'PF',PF);

set(handles.enter_damping_pushbutton,'Visible','on');

guidata(hObject, handles);

set(handles.pushbutton_SRS,'Visible','on');
%
msgbox('Calculation complete.  Output written to Matlab Command Window.');



% --- Executes on button press in enter_damping_pushbutton.
function enter_damping_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to enter_damping_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.two_dof_c= two_dof_damping;
set(handles.two_dof_c,'Visible','on');

set(handles.transmissibility_pushbutton,'Visible','on');
set(handles.steady_sine_pushbutton,'Visible','on');
set(handles.half_sine_pushbutton,'Visible','on');
set(handles.arbitrary_pulse_pushbutton,'Visible','on');
set(handles.PSD_pushbutton,'Visible','on');

% --- Executes on button press in transmissibility_pushbutton.
function transmissibility_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to transmissibility_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.two_dof_trans= two_dof_transmissibility;
set(handles.two_dof_trans,'Visible','on');

% --- Executes on button press in steady_sine_pushbutton.
function steady_sine_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to steady_sine_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.two_dof_sine= two_dof_sine;
set(handles.two_dof_sine,'Visible','on');


% --- Executes on button press in half_sine_pushbutton.
function half_sine_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to half_sine_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.two_dof_half_sine= two_dof_half_sine;
set(handles.two_dof_half_sine,'Visible','on');

% --- Executes on button press in arbitrary_pulse_pushbutton.
function arbitrary_pulse_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to arbitrary_pulse_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.two_dof_arb= two_dof_arbitrary;
set(handles.two_dof_arb,'Visible','on');

% --- Executes on button press in PSD_pushbutton.
function PSD_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to PSD_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.two_dof_PSD= two_dof_PSD;
set(handles.two_dof_PSD,'Visible','on');

% --- Executes on button press in return_pushbutton.
function return_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to return_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(two_dof_base_b);


function mass1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass1_edit as text
%        str2double(get(hObject,'String')) returns contents of mass1_edit as a double


% --- Executes during object creation, after setting all properties.
function mass1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mass2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass2_edit as text
%        str2double(get(hObject,'String')) returns contents of mass2_edit as a double


% --- Executes during object creation, after setting all properties.
function mass2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness2_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness2_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness1_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness1_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in units_listbox.
function units_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns units_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from units_listbox
n=get(hObject,'Value');

if(n==1)
    set(handles.mass_unit_text,'String','Mass Unit: lbm');
    set(handles.stiffness_unit_text,'String','Stiffness Unit: lbf/in');    
else
    set(handles.mass_unit_text,'String','Mass Unit: kg'); 
    set(handles.stiffness_unit_text,'String','Stiffness Unit: N/m');     
end
clear_buttons(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function units_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness3_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness3_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness3_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness3_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on mass2_edit and none of its controls.
function mass2_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_buttons(hObject, eventdata, handles);


% --- Executes on key press with focus on stiffness3_edit and none of its controls.
function stiffness3_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to stiffness3_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_buttons(hObject, eventdata, handles);


% --- Executes on key press with focus on stiffness2_edit and none of its controls.
function stiffness2_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_buttons(hObject, eventdata, handles);


% --- Executes on key press with focus on mass1_edit and none of its controls.
function mass1_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_buttons(hObject, eventdata, handles);


% --- Executes on key press with focus on stiffness1_edit and none of its controls.
function stiffness1_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_buttons(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_SRS.
function pushbutton_SRS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SRS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.mdof_SRS= mdof_SRS;
set(handles.mdof_SRS,'Visible','on');
