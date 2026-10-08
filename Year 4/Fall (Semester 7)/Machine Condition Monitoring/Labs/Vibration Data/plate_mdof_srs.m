function varargout = plate_mdof_srs(varargin)
% PLATE_MDOF_SRS MATLAB code for plate_mdof_srs.fig
%      PLATE_MDOF_SRS, by itself, creates a new PLATE_MDOF_SRS or raises the existing
%      singleton*.
%
%      H = PLATE_MDOF_SRS returns the handle to a new PLATE_MDOF_SRS or the handle to
%      the existing singleton*.
%
%      PLATE_MDOF_SRS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLATE_MDOF_SRS.M with the given input arguments.
%
%      PLATE_MDOF_SRS('Property','Value',...) creates a new PLATE_MDOF_SRS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plate_mdof_srs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plate_mdof_srs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plate_mdof_srs

% Last Modified by GUIDE v2.5 26-May-2015 13:06:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plate_mdof_srs_OpeningFcn, ...
                   'gui_OutputFcn',  @plate_mdof_srs_OutputFcn, ...
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


% --- Executes just before plate_mdof_srs is made visible.
function plate_mdof_srs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plate_mdof_srs (see VARARGIN)

% Choose default command line output for plate_mdof_srs
handles.output = hObject;

set(handles.uipanel_data,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plate_mdof_srs wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plate_mdof_srs_OutputFcn(hObject, eventdata, handles) 
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

delete(plate_mdof_srs);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fk=getappdata(0,'fk');
pk=getappdata(0,'pk');
ek=getappdata(0,'ek');

N=length(fk);

A=char(get(handles.uitable_coordinates,'Data'));

B=str2num(A);


mode=B(1:N);

nat_freq=B(N+1:2*N);

part_fact=B(2*N+1:3*N);

eigv=B(3*N+1:4*N);

srs=B(4*N+1:5*N);

srs;


a=0;
for i=1:N
    b=(pk(i)*ek(i)*srs(i))^2;
    a=a+b;
    
%%    out1=sprintf('b=%8.4g',b);
%%    disp(out1);
end
a=sqrt(a);

out1=sprintf('\n SRSS, maximum expected acceleration = %8.4g ',a);
disp(out1);

msgbox('Results written to Command Window');


function edit_node_Callback(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_node as text
%        str2double(get(hObject,'String')) returns contents of edit_node as a double

pushbutton_enter_node_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function edit_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_enter_node.
function pushbutton_enter_node_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_data,'Visible','on');



fn=getappdata(0,'fn');
ModeShapes=getappdata(0,'ModeShapes');
pff=getappdata(0,'pff');
pff=abs(pff);
mp=max(pff);

node=str2num(get(handles.edit_node,'String'));

ndof=3*node-2;

k=1;

for i=1:length(fn);
    if(pff(i)>0.01*mp)
        fk(k)=fn(i);
        pk(k)=pff(i);
        mk(k)=i;
        ek(k)=abs(ModeShapes(ndof,i));
        k=k+1;
        if(k==7)
            break;
        end
    end
end

setappdata(0,'fk',fk);
setappdata(0,'pk',pk);
setappdata(0,'ek',ek);


for i = 1:length(fk);

    data_s{i,1} = sprintf('%d',mk(i));     
    data_s{i,2} = sprintf('%7.4g',fk(i));    
    data_s{i,3} = sprintf('%7.4g',pk(i));    
    data_s{i,4} = sprintf('%7.4g',ek(i));    
    data_s{i,5} = '';
    
end

set(handles.uitable_coordinates,'Data',data_s);
