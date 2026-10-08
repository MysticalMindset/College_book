function varargout = vibrationdata_SRS_plot_multiple(varargin)
% VIBRATIONDATA_SRS_PLOT_MULTIPLE MATLAB code for vibrationdata_SRS_plot_multiple.fig
%      VIBRATIONDATA_SRS_PLOT_MULTIPLE, by itself, creates a new VIBRATIONDATA_SRS_PLOT_MULTIPLE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SRS_PLOT_MULTIPLE returns the handle to a new VIBRATIONDATA_SRS_PLOT_MULTIPLE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SRS_PLOT_MULTIPLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SRS_PLOT_MULTIPLE.M with the given input arguments.
%
%      VIBRATIONDATA_SRS_PLOT_MULTIPLE('Property','Value',...) creates a new VIBRATIONDATA_SRS_PLOT_MULTIPLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_SRS_plot_multiple_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_SRS_plot_multiple_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_SRS_plot_multiple

% Last Modified by GUIDE v2.5 21-Mar-2018 13:31:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_SRS_plot_multiple_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_SRS_plot_multiple_OutputFcn, ...
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


% --- Executes just before vibrationdata_SRS_plot_multiple is made visible.
function vibrationdata_SRS_plot_multiple_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_SRS_plot_multiple (see VARARGIN)

% Choose default command line output for vibrationdata_SRS_plot_multiple
handles.output = hObject;


set(handles.listbox_frequency_limits,'Value',1);
set(handles.listbox_input_type,'Value',1);

listbox_frequency_limits_Callback(hObject, eventdata, handles);

set(handles.listbox_psave,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_SRS_plot_multiple wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_SRS_plot_multiple_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_SRS_plot_multiple);


%8 --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

psave=get(handles.listbox_psave,'Value');

fig_num=1;


try
    FS=get(handles.edit_input_array_1,'String');
    THM1=evalin('base',FS);   
catch
    warndlg(' Input array 1 not found ');
    return;
end
try
    FS=get(handles.edit_input_array_2,'String');
    THM2=evalin('base',FS);   
catch
    warndlg(' Input array 2 not found ');
    return;
end

%%%

Q=str2num(get(handles.edit_Q,'String'));

xaxis_label=get(handles.edit_xaxis_label,'String');
yaxis_label=get(handles.edit_yaxis_label,'String');


p=get(handles.listbox_input_type,'Value');


m=get(handles.listbox_frequency_limits,'Value');

if(m==1) % automatic
    
    fmin=min([ THM1(1,1)      THM2(1,1) ]); 
    fmax=max([ max(THM1(:,1)) max(THM2(:,1))]);
   
else     % manual
    
    fmin=str2num(get(handles.edit_start_frequency,'String'));
    fmax=str2num(get(handles.edit_end_frequency,'String'));
end

md=4;



x_label=xaxis_label;
y_label=yaxis_label;

leg1=get(handles.edit_leg1,'String');
leg2=get(handles.edit_leg2,'String');

skv=get(handles.edit_title,'String');


if(p==1)
    
    t_string=sprintf('%s Q=%g',skv,Q);
    
    ppp1=THM1;
    ppp2=THM2;
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
    
else

%%%

    sz1=size(THM1);          
    m11=sz1(1);
    m12=sz1(2);
    
    sz2=size(THM2);          
    m21=sz2(1);
    m22=sz2(2);    
    
    if(m12~=3)
        warndlg(' Input Array 1 must have three columns');
        return;
    end
    if(m22~=3)
        warndlg(' Input Array 2 must have three columns');
        return;
    end    
    
%%%    

    
    THM1a(:,1)=THM1(:,1);
    
    for i=1:m11
        THM1a(i,2)=max([ THM1(i,2)  THM1(i,3) ]);
    end
%%%    

    
    THM2a(:,1)=THM2(:,1);
    
    for i=1:m21
        THM2a(i,2)=max([ THM2(i,2)  THM2(i,3) ]);
    end    
%%%    

    t_string=sprintf('%s Q=%g \n Absolute',skv,Q);    
        
    ppp1=THM1a;
    ppp2=THM2a;
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
%%% 
    t_string=sprintf('%s Q=%g \n Positive',skv,Q);
    
    ppp1=[THM1(:,1) THM1(:,2) ];
    ppp2=[THM2(:,1) THM2(:,2) ];
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
%%% 
    t_string=sprintf('%s Q=%g \n Negative',skv,Q);
    
    ppp1=[THM1(:,1) THM1(:,3) ];
    ppp2=[THM2(:,1) THM2(:,3) ];
    
    [fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
                   y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);               
               
%%% 

    t_string=sprintf('%s Q=%g',skv,Q); 

    ppp1=[THM1(:,1) THM1(:,2) ];
    ppp2=[THM1(:,1) THM1(:,3) ];
    ppp3=[THM2(:,1) THM2(:,2) ];
    ppp4=[THM2(:,1) THM2(:,3) ];

    legg1=sprintf('%s pos',leg1);
    legg2=sprintf('%s neg',leg1); 
    legg3=sprintf('%s pos',leg2);
    legg4=sprintf('%s neg',leg2);      
    
    [fig_num,h2]=plot_loglog_function_md_four_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,ppp4,legg1,legg2,legg3,legg4,fmin,fmax,md);    
    
end    
    
%
if(psave==1)
        
        disp(' ');
        disp(' Plot file:');
        disp(' ');
    
        pname='srs_plot';
        
        out1=sprintf('   %s.png',pname);
        disp(out1);
    
        set(gca,'Fontsize',12);
        print(h,pname,'-dpng','-r300');
    
end      


function edit_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double


% --- Executes during object creation, after setting all properties.
function edit_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_yaxis_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yaxis_label as text
%        str2double(get(hObject,'String')) returns contents of edit_yaxis_label as a double


% --- Executes during object creation, after setting all properties.
function edit_yaxis_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xaxis_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xaxis_label as text
%        str2double(get(hObject,'String')) returns contents of edit_xaxis_label as a double


% --- Executes during object creation, after setting all properties.
function edit_xaxis_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xaxis_label (see GCBO)
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



function edit_input_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_end_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_end_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_end_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_start_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_start_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_start_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_frequency_limits.
function listbox_frequency_limits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency_limits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency_limits
n=get(handles.listbox_frequency_limits,'Value');
 
if(n==1) % auto
    set(handles.text_start_frequency,'Visible','off');
    set(handles.text_end_frequency,'Visible','off');
    set(handles.edit_start_frequency,'Visible','off');
    set(handles.edit_end_frequency,'Visible','off');    
else % manual
    set(handles.text_start_frequency,'Visible','on');
    set(handles.text_end_frequency,'Visible','on');
    set(handles.edit_start_frequency,'Visible','on');
    set(handles.edit_end_frequency,'Visible','on');      
end


% --- Executes during object creation, after setting all properties.
function listbox_frequency_limits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_input_type.
function listbox_input_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_type


% --- Executes during object creation, after setting all properties.
function listbox_input_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave


% --- Executes during object creation, after setting all properties.
function listbox_psave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_return_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_input_array_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_leg1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_leg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_leg1 as text
%        str2double(get(hObject,'String')) returns contents of edit_leg1 as a double


% --- Executes during object creation, after setting all properties.
function edit_leg1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_leg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_leg2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_leg2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_leg2 as text
%        str2double(get(hObject,'String')) returns contents of edit_leg2 as a double


% --- Executes during object creation, after setting all properties.
function edit_leg2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_leg2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
