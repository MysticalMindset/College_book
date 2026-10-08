function varargout = vibrationdata_SRS_plot(varargin)
% VIBRATIONDATA_SRS_PLOT MATLAB code for vibrationdata_SRS_plot.fig
%      VIBRATIONDATA_SRS_PLOT, by itself, creates a new VIBRATIONDATA_SRS_PLOT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SRS_PLOT returns the handle to a new VIBRATIONDATA_SRS_PLOT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SRS_PLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SRS_PLOT.M with the given input arguments.
%
%      VIBRATIONDATA_SRS_PLOT('Property','Value',...) creates a new VIBRATIONDATA_SRS_PLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_SRS_plot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_SRS_plot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_SRS_plot

% Last Modified by GUIDE v2.5 17-Oct-2018 16:34:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_SRS_plot_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_SRS_plot_OutputFcn, ...
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


% --- Executes just before vibrationdata_SRS_plot is made visible.
function vibrationdata_SRS_plot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_SRS_plot (see VARARGIN)

% Choose default command line output for vibrationdata_SRS_plot
handles.output = hObject;

set(handles.listbox_method,'Value',1);
set(handles.listbox_frequency_limits,'Value',1);
set(handles.listbox_input_type,'Value',1);

listbox_frequency_limits_Callback(hObject, eventdata, handles);
listbox_amplitude_limits_Callback(hObject, eventdata, handles);

set(handles.listbox_psave,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_SRS_plot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_SRS_plot_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_SRS_plot);


%8 --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%

fig_num=get(handles.listbox_figure_number,'Value');
 
 
Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
 
if(NFigures>fig_num)
    NFigures=fig_num;
end
 
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end
 

  
%%%%%%%%%%%

psave=get(handles.listbox_psave,'Value');

k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

Q=str2num(get(handles.edit_Q,'String'));


ttt=get(handles.edit_title,'String');

title_label=sprintf('%s Q=%g',ttt,Q);

xaxis_label=get(handles.edit_xaxis_label,'String');
yaxis_label=get(handles.edit_yaxis_label,'String');


h=figure(fig_num);

p=get(handles.listbox_input_type,'Value');

if(p==1)
    plot(THM(:,1),THM(:,2));
else
    plot(THM(:,1),THM(:,2),THM(:,1),THM(:,3));
    legend ('positive','negative');        
end    

title(title_label );
xlabel(xaxis_label);
ylabel(yaxis_label);
grid on;

m=get(handles.listbox_frequency_limits,'Value');

if(m==1) % automatic
    
    fmin=THM(1,1);
    fmax=max(THM(:,1));

    
    [xtt,xTT,iflag]=xtick_label(fmin,fmax);

   
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);    
    end   
    

    
    xlim([fmin,fmax]);

    

else     % manual
    
    f1=str2num(get(handles.edit_start_frequency,'String'));
    f2=str2num(get(handles.edit_end_frequency,'String'));
    xlim([f1,f2]);
    
end

%%%%%%%%%%%%%%%%%%%%%

ma=get(handles.listbox_amplitude_limits,'Value');

if(ma==2)
    
    ymin=str2num(get(handles.edit_ymin,'String'));
    ymax=str2num(get(handles.edit_ymax,'String'));
    ylim([ymin,ymax]);    
    
end

%%%%%%%%%%%%%%%%%%%%%

 set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
                             
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
n=get(hObject,'Value');

set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

m=get(handles.listbox_input_type,'Value');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   
   if(m==1)
    THM = fscanf(fid,'%g %g',[2 inf]);
   else
    THM = fscanf(fid,'%g %g %g',[3 inf]);       
   end
   
   THM=THM';
    
   setappdata(0,'THM',THM);
end


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


% --- Executes on selection change in listbox_figure_number.
function listbox_figure_number_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_figure_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_figure_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_figure_number


% --- Executes during object creation, after setting all properties.
function listbox_figure_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_figure_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_amplitude_limits.
function listbox_amplitude_limits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amplitude_limits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amplitude_limits

n=get(handles.listbox_amplitude_limits,'Value');
 
if(n==1) % auto
    set(handles.text_ymin,'Visible','off');
    set(handles.text_ymax,'Visible','off');
    set(handles.edit_ymin,'Visible','off');
    set(handles.edit_ymax,'Visible','off');    
else % manual
    set(handles.text_ymin,'Visible','on');
    set(handles.text_ymax,'Visible','on');
    set(handles.edit_ymin,'Visible','on');
    set(handles.edit_ymax,'Visible','on');      
end



% --- Executes during object creation, after setting all properties.
function listbox_amplitude_limits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_limits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
