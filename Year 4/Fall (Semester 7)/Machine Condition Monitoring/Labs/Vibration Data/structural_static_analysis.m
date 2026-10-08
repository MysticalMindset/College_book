function varargout = structural_static_analysis(varargin)
% STRUCTURAL_STATIC_ANALYSIS MATLAB code for structural_static_analysis.fig
%      STRUCTURAL_STATIC_ANALYSIS, by itself, creates a new STRUCTURAL_STATIC_ANALYSIS or raises the existing
%      singleton*.
%
%      H = STRUCTURAL_STATIC_ANALYSIS returns the handle to a new STRUCTURAL_STATIC_ANALYSIS or the handle to
%      the existing singleton*.
%
%      STRUCTURAL_STATIC_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRUCTURAL_STATIC_ANALYSIS.M with the given input arguments.
%
%      STRUCTURAL_STATIC_ANALYSIS('Property','Value',...) creates a new STRUCTURAL_STATIC_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before structural_static_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to structural_static_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help structural_static_analysis

% Last Modified by GUIDE v2.5 28-Aug-2017 13:35:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @structural_static_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @structural_static_analysis_OutputFcn, ...
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


% --- Executes just before structural_static_analysis is made visible.
function structural_static_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to structural_static_analysis (see VARARGIN)

% Choose default command line output for structural_static_analysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes structural_static_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = structural_static_analysis_OutputFcn(hObject, eventdata, handles) 
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

delete(structural_static_analysis)


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis


% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis,'Value');

if(n==1)
    handles.s=continuum_mechanics_stress_strain;      
end
if(n==2)
    handles.s=stress_toolbox;    
end 
if(n==3)
    handles.s=spacecraft_clamp_band;    
end 
if(n==4)
    handles.s=column_buckling;    
end 
