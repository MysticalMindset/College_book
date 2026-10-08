function varargout = vibrationdata_Miles(varargin)
% VIBRATIONDATA_MILES MATLAB code for vibrationdata_Miles.fig
%      VIBRATIONDATA_MILES, by itself, creates a new VIBRATIONDATA_MILES or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_MILES returns the handle to a new VIBRATIONDATA_MILES or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_MILES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_MILES.M with the given input arguments.
%
%      VIBRATIONDATA_MILES('Property','Value',...) creates a new VIBRATIONDATA_MILES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_Miles_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_Miles_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_Miles

% Last Modified by GUIDE v2.5 14-Apr-2014 16:26:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_Miles_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_Miles_OutputFcn, ...
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


% --- Executes just before vibrationdata_Miles is made visible.
function vibrationdata_Miles_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_Miles (see VARARGIN)

% Choose default command line output for vibrationdata_Miles
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_Miles wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_Miles_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_Miles);


function clear_results(hObject, eventdata, handles)

set(handles.edit_grms,'Enable','off','String','');
set(handles.edit_three_sigma,'Enable','off','String','');

set(handles.edit_rd_rms,'Enable','off','String','');
set(handles.edit_rd_ts,'Enable','off','String','');

set(handles.edit_rd_rms_mm,'Enable','off','String','');
set(handles.edit_rd_ts_mm,'Enable','off','String','');


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

P=str2num(get(handles.edit_P,'String'));
fn=str2num(get(handles.edit_fn,'String'));
Q=str2num(get(handles.edit_Q,'String'));

x=sqrt((pi/2)*P*fn*Q);

s1=sprintf('%8.3g',x);
s2=sprintf('%8.3g',3*x);

set(handles.edit_grms,'Enable','on','String',s1);
set(handles.edit_three_sigma,'Enable','on','String',s2);


rts= 29.4*(1/fn^1.5)*sqrt((pi/2)*P*Q);

r=rts/3;

r1=sprintf('%8.3g',r);
r2=sprintf('%8.3g',rts);

set(handles.edit_rd_rms,'Enable','on','String',r1);
set(handles.edit_rd_ts,'Enable','on','String',r2);


rm1=sprintf('%8.3g',25.4*r);
rm2=sprintf('%8.3g',25.4*rts);

set(handles.edit_rd_rms_mm,'Enable','on','String',rm1);
set(handles.edit_rd_ts_mm,'Enable','on','String',rm2);


function edit_grms_Callback(hObject, eventdata, handles)
% hObject    handle to edit_grms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_grms as text
%        str2double(get(hObject,'String')) returns contents of edit_grms as a double


% --- Executes during object creation, after setting all properties.
function edit_grms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_grms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_three_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to edit_three_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_three_sigma as text
%        str2double(get(hObject,'String')) returns contents of edit_three_sigma as a double


% --- Executes during object creation, after setting all properties.
function edit_three_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_three_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_P_Callback(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_P as text
%        str2double(get(hObject,'String')) returns contents of edit_P as a double


% --- Executes during object creation, after setting all properties.
function edit_P_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_P and none of its controls.
function edit_P_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_results(hObject, eventdata, handles);



function edit_rd_rms_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rd_rms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rd_rms as text
%        str2double(get(hObject,'String')) returns contents of edit_rd_rms as a double


% --- Executes during object creation, after setting all properties.
function edit_rd_rms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rd_rms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rd_ts_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rd_ts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rd_ts as text
%        str2double(get(hObject,'String')) returns contents of edit_rd_ts as a double


% --- Executes during object creation, after setting all properties.
function edit_rd_ts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rd_ts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rd_rms_mm_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rd_rms_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rd_rms_mm as text
%        str2double(get(hObject,'String')) returns contents of edit_rd_rms_mm as a double


% --- Executes during object creation, after setting all properties.
function edit_rd_rms_mm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rd_rms_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rd_ts_mm_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rd_ts_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rd_ts_mm as text
%        str2double(get(hObject,'String')) returns contents of edit_rd_ts_mm as a double


% --- Executes during object creation, after setting all properties.
function edit_rd_ts_mm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rd_ts_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
