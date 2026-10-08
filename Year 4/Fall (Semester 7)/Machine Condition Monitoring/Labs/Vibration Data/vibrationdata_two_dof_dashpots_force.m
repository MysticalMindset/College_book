function varargout = vibrationdata_two_dof_dashpots_force(varargin)
% VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE MATLAB code for vibrationdata_two_dof_dashpots_force.fig
%      VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE, by itself, creates a new VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE returns the handle to a new VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE.M with the given input arguments.
%
%      VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE('Property','Value',...) creates a new VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_two_dof_dashpots_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_two_dof_dashpots_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_two_dof_dashpots_force

% Last Modified by GUIDE v2.5 24-Aug-2018 14:20:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_two_dof_dashpots_force_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_two_dof_dashpots_force_OutputFcn, ...
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


% --- Executes just before vibrationdata_two_dof_dashpots_force is made visible.
function vibrationdata_two_dof_dashpots_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_two_dof_dashpots_force (see VARARGIN)

% Choose default command line output for vibrationdata_two_dof_dashpots_force
handles.output = hObject;

%%%%%%%%%%%

fstr = 'two_dof_system_dashpots_b_sm.jpg';
 
bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
 
pos1 = getpixelposition(handles.pushbutton_select_a,true);

xc=0.5*pos1(3)+pos1(1);
x=round(xc-0.5*w);
y=pos1(2)+1.4*pos1(4);

set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [x y w h]);
axis off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fstr ='two_dof_system_dashpots_c_sm.jpg';
 
bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes2);
image(bg);
 
pos1 = getpixelposition(handles.pushbutton_select_b,true);

xc=0.5*pos1(3)+pos1(1);
x=round(xc-0.5*w);
y=pos1(2)+1.4*pos1(4);

set(handles.axes2, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [x y w h]);
axis off;


%%%%%%%%%%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_two_dof_dashpots_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_two_dof_dashpots_force_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_two_dof_dashpots_force);


% --- Executes on button press in pushbutton_select_a.
function pushbutton_select_a_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= two_dof_system_dashpots_b;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_select_b.
function pushbutton_select_b_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= two_dof_system_dashpots_c;
set(handles.s,'Visible','on');

% --- Executes on button press in pushbutton_select_c.
function pushbutton_select_c_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= two_dof_system_c_force;
set(handles.s,'Visible','on');
