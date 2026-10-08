function varargout = two_dof_base(varargin)
% TWO_DOF_BASE MATLAB code for two_dof_base.fig
%      TWO_DOF_BASE, by itself, creates a new TWO_DOF_BASE or raises the existing
%      singleton*.
%
%      H = TWO_DOF_BASE returns the handle to a new TWO_DOF_BASE or the handle to
%      the existing singleton*.
%
%      TWO_DOF_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_BASE.M with the given input arguments.
%
%      TWO_DOF_BASE('Property','Value',...) creates a new TWO_DOF_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_base

% Last Modified by GUIDE v2.5 11-Oct-2016 16:12:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_base_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_base_OutputFcn, ...
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


% --- Executes just before two_dof_base is made visible.
function two_dof_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_base (see VARARGIN)

% Choose default command line output for two_dof_base
handles.output = hObject;


fstr='two_dof_base_ai.jpg';
 
bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
 
pos1 = getpixelposition(handles.pushbutton1,true);

xc=0.5*pos1(3)+pos1(1);
x=round(xc-0.5*w);
y=pos1(2)+1.4*pos1(4);

set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [x y w h]);
axis off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fstr='two_dof_base_bi.jpg';
 
bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes2);
image(bg);
 
pos1 = getpixelposition(handles.pushbutton2,true);

xc=0.5*pos1(3)+pos1(1);
x=round(xc-0.5*w);
y=pos1(2)+1.4*pos1(4);

set(handles.axes2, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [x y w h]);
axis off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fstr='two_dof_base_di.jpg';
 
bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes3);
image(bg);
 
pos1 = getpixelposition(handles.pushbutton3,true);

xc=0.5*pos1(3)+pos1(1);
x=round(xc-0.5*w);
y=pos1(2)+1.4*pos1(4);

set(handles.axes3, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [x y w h]);
axis off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

setappdata(0,'fig_num',fig_num);   

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_base_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.two_dof_a= two_dof_base_a;
set(handles.two_dof_a,'Visible','on');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.two_dof_b= two_dof_base_b;
set(handles.two_dof_b,'Visible','on');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.two_dof_d= two_dof_base_d;
set(handles.two_dof_d,'Visible','on');


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2
