function varargout = classical_pulse_base_input(varargin)
% CLASSICAL_PULSE_BASE_INPUT MATLAB code for classical_pulse_base_input.fig
%      CLASSICAL_PULSE_BASE_INPUT, by itself, creates a new CLASSICAL_PULSE_BASE_INPUT or raises the existing
%      singleton*.
%
%      H = CLASSICAL_PULSE_BASE_INPUT returns the handle to a new CLASSICAL_PULSE_BASE_INPUT or the handle to
%      the existing singleton*.
%
%      CLASSICAL_PULSE_BASE_INPUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLASSICAL_PULSE_BASE_INPUT.M with the given input arguments.
%
%      CLASSICAL_PULSE_BASE_INPUT('Property','Value',...) creates a new CLASSICAL_PULSE_BASE_INPUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before classical_pulse_base_input_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to classical_pulse_base_input_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help classical_pulse_base_input

% Last Modified by GUIDE v2.5 15-Sep-2018 13:59:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @classical_pulse_base_input_OpeningFcn, ...
                   'gui_OutputFcn',  @classical_pulse_base_input_OutputFcn, ...
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


% --- Executes just before classical_pulse_base_input is made visible.
function classical_pulse_base_input_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to classical_pulse_base_input (see VARARGIN)

% Choose default command line output for classical_pulse_base_input
handles.output = hObject;

set(handles.listbox_pulse_type,'Value',1);
set(handles.listbox_analysis_type,'Value',1);
set(handles.listbox_resp_unit,'Value',1);
set(handles.listbox_output_type,'Value',1);
set(handles.listbox_time_unit,'Value',1);
set(handles.listbox_psave,'Value',2);


set(handles.edit_fn,'Visible','off');
set(handles.text_fn,'Visible','off');
set(handles.edit_Q,'String','10');
set(handles.pushbutton_save,'Enable','off');

listbox_resp_unit_Callback(hObject, eventdata, handles);
listbox_analysis_type_Callback(hObject, eventdata, handles);
listbox_pulse_type_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes classical_pulse_base_input wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = classical_pulse_base_input_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculation.
function pushbutton_calculation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * ');
disp('  ');

set(handles.pushbutton_save,'Enable','on');

fn=0;
Q=0;
f1=0;
f2=0;
resp_dur=0;

npt=get(handles.listbox_pulse_type,'Value');
nat=get(handles.listbox_analysis_type,'Value');
ntu=get(handles.listbox_time_unit,'Value');
iunit=get(handles.listbox_resp_unit,'Value');

Q=str2num(get(handles.edit_Q,'String'));


rd0=str2num(get(handles.edit_rd0,'String'));
rv0=str2num(get(handles.edit_rv0,'String'));

if(iunit==2)
   rd0=rd0/1000; 
end


if(nat==1)  % SRS
    f1=str2num(get(handles.edit_aux1,'String'));
    f2=str2num(get(handles.edit_aux2,'String'));
    if(f1<=0)
        f1=0.1;
    end
%
    fn(1)=f1;
    i=1;
    while(1)
        fn(i+1)=fn(i)*2^(1/48);
        if(fn(i+1)>f2)
            fn(i+1)=f2;
            break;
        end
        i=i+1;
    end    
%
else   % Time History Response
%    
    fn=str2num(get(handles.edit_fn,'String'));
    resp_dur=str2num(get(handles.edit_aux1,'String'));
%    
end

amp=str2num(get(handles.edit_amp,'String'));
dur=str2num(get(handles.edit_T,'String'));

if(ntu==2)
    dur=dur/1000;
end

if(npt==1)
    [a_srs,pv_srs,rd_srs,base_th,a_th,rd_th]=...
             vibrationdata_half_sine_pulse_initial(nat,amp,dur,fn,Q,resp_dur,iunit,rd0,rv0);
end
if(npt==2)
    [a_srs,pv_srs,rd_srs,base_th,a_th,rd_th]=vibrationdata_rectangular_pulse_initial(nat,amp,dur,fn,Q,resp_dur,iunit,rd0,rv0);    
end
if(npt==3)
    [a_srs,pv_srs,rd_srs,base_th,a_th,rd_th]=...    
     vibrationdata_terminal_sawtooth_pulse_initial(nat,amp,dur,fn,Q,resp_dur,iunit,rd0,rv0);      
end
if(npt==4)
    [a_srs,pv_srs,rd_srs,base_th,a_th,rd_th]=...
           vibrationdata_versed_sine_pulse_initial(nat,amp,dur,fn,Q,resp_dur,iunit,rd0,rv0);
end
if(npt==5)
    
    d1=str2num(get(handles.edit_initial,'String'));
    d2=str2num(get(handles.edit_final,'String'));
    
 
    if(ntu==2)
        d1=d1/1000;
        d2=d2/1000;        
    end
    
  
    if(d1<=1e-05)
        warndlg('Initial ramp duration is too short');
        return;
    end
    if(d2<=1e-05)
        warndlg('Final ramp duration is too short');
        return;
    end    
    
    [a_srs,pv_srs,rd_srs,base_th,a_th,rd_th]=...
           vibrationdata_trapezoidal_pulse_initial(nat,fn,amp,dur,d1,d2,Q,resp_dur,iunit,rd0,rv0);
end
if(npt==6)
      
    resp_dur=dur;

    frequency=str2num(get(handles.edit_frequency,'String'));
    [a_srs,pv_srs,rd_srs,base_th,a_th,rd_th]=...
             vibrationdata_sine_initial(nat,amp,frequency,fn,Q,resp_dur,iunit,rd0,rv0);    
end    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

psave=get(handles.listbox_psave,'Value');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nat==1)
    
    fig_num=1;
    
    fmin=a_srs(1,1);
    fmax=max(a_srs(:,1));
    
    md=5;
    
    x_label='Natural Frequency (Hz)';
    y_label='Peak Accel (G)';
    t_string=sprintf('Acceleration SRS Q=%g',Q);
    
    ppp1=[a_srs(:,1) a_srs(:,2)];
    ppp2=[a_srs(:,1) a_srs(:,3)];
    
    leg1='positive';
    leg2='negative';
    
    [fig_num,hasrs]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
    
    if(psave==1)  
        set(gca,'Fontsize',12);        
        print(hasrs,'accel_srs','-djpeg','-r300');
    end    
%    
    
   t_string=sprintf('Pseudo Velocity SRS Q=%g',Q);

    ppp1=[pv_srs(:,1) pv_srs(:,2)];
    ppp2=[pv_srs(:,1) pv_srs(:,3)]; 
       
    if(iunit==1)
        y_label='Peak Velocity (in/sec)';    
    else
        y_label='Peak Velocity (m/sec)';        
    end
    
    [fig_num,hpvsrs]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);    
%       
    if(psave==1)  
        set(gca,'Fontsize',12);          
        print(hpvsrs,'pv_srs','-djpeg','-r300');
    end    
%

    t_string=sprintf('Relative Displacement SRS Q=%g',Q);
  
    ppp1=[rd_srs(:,1) rd_srs(:,2)];
    ppp2=[rd_srs(:,1) rd_srs(:,3)]; 
       
    if(iunit==1)
        y_label='Peak Rel Disp (in)';    
    else
        y_label='Peak Rel Disp (mm)';        
    end   

    [fig_num,hrdsrs]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md); 
           
    if(psave==1)  
        set(gca,'Fontsize',12);          
        print(hpvsrs,'rd_srs','-djpeg','-r300');
    end               

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if(psave==1)

        disp(' ');
        disp(' Plot Files ');
        
        set(gca,'Fontsize',12);          
        print(hrdsrs,'rd_srs','-djpeg','-r300');
        
        disp('accel_srs.jpg');
        disp('pv_srs.jpg');        
        disp('rd_srs.jpg');        
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
else
    disp(' ');
    out4=sprintf('Response Peaks for case: fn=%g Hz, Q=%g \n',fn,Q);
    disp(out4);
    hath=figure(1);
    plot(a_th(:,1),a_th(:,2),base_th(:,1),base_th(:,2));
    xlabel('Time (sec)');
    ylabel('Accel (G)');
    maxa=max(a_th(:,2));
    mina=min(a_th(:,2));
    out1=sprintf('Acceleration (fn=%g Hz, Q=%g) \n Peaks (%6.3g G, %6.3g G)',fn,Q,maxa,mina);
    title(out1);
    out9=sprintf('Acceleration:  %6.3g G   %6.3g G \n',maxa,mina);
    disp(out9);
    grid on;
    legend('Response','Base Input');
    
    if(psave==1)

        set(gca,'Fontsize',13);          
        print(hath,'accel_th','-djpeg','-r300');       
      
    end        
    
    fig_num=2;
    
    xlabel2='Time (sec)';
    
    ylabel1='Accel (G)';
    ylabel2='Accel (G)';
    
    data1=base_th;    
    data2=a_th;

    t_string1='Base Acceleration';
    t_string2=sprintf('Response Acceleration (fn=%g Hz, Q=%g)',fn,Q);
    
    [fig_num]=subplots_two_linlin_two_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);
    
    
%    
    hrdth=figure(3);
    plot(rd_th(:,1),rd_th(:,2));
    xlabel('Time (sec)');
    max_rd=max(rd_th(:,2));
    min_rd=min(rd_th(:,2));
    if(iunit==1)
        out1=sprintf('Relative Displacement (fn=%g Hz, Q=%g) \n Peaks (%6.3g in, %6.3g in)',fn,Q,max_rd,min_rd);        
        out2=sprintf('Relative Displacement:  %6.3g in   %6.3g in',max_rd,min_rd);    
        ylabel('Rel Disp (in)');        
    else
        out1=sprintf('Relative Displacement (fn=%g Hz, Q=%g) \n Peaks (%6.3g mm, %6.3g mm)',fn,Q,max_rd,min_rd);        
        out2=sprintf('Relative Displacement:  %6.3g mm   %6.3g mm',max_rd,min_rd);
        ylabel('Rel Disp (mm)');         
    end
    title(out1);
    disp(out2);
    grid on;
    
    if(psave==1)

        set(gca,'Fontsize',13);          
        print(hrdth,'rd_th','-djpeg','-r300');
             
        disp(' ');
        disp(' Plot Files ');         
        
        disp('accel_th.jpg');
        disp('rd_th.jpg');
        
    end    

    
    
    
    
end


if(psave==1)
 
    msgbox('Plot files exported to hard drive');
   
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(classical_pulse_base_input);


% --- Executes on selection change in listbox_pulse_type.
function listbox_pulse_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pulse_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pulse_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pulse_type

common(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_pulse_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pulse_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function common(hObject, eventdata, handles)

nat=get(handles.listbox_analysis_type,'Value');

if(nat==1)
    set(handles.edit_fn,'Visible','off');
    set(handles.text_fn,'Visible','off');
    set(handles.edit_aux2,'Visible','on');
    set(handles.text_aux2,'Visible','on');
    set(handles.text_aux1,'String','Start Freq (Hz)');
    
    str{1}=sprintf('Acceleration SRS');
    str{2}=sprintf('Pseudo Velocity SRS');
    str{3}=sprintf('Relative Disp SRS');
else
    set(handles.edit_fn,'Visible','on');
    set(handles.text_fn,'Visible','on');
    set(handles.text_aux1,'String','Response Duration (sec)');
    set(handles.edit_aux2,'Visible','off');
    set(handles.text_aux2,'Visible','off');
    
    str{1}=sprintf('Base Acceleration');    
    str{2}=sprintf('Response Acceleration');
    str{3}=sprintf('Relative Displacement');    
end

set(handles.listbox_output_type,'String',str);

%%%%%

n=get(handles.listbox_pulse_type,'Value');

set(handles.text_ramp_durations,'Visible','off');
set(handles.text_initial,'Visible','off');
set(handles.text_final,'Visible','off');
set(handles.edit_initial,'Visible','off');
set(handles.edit_final,'Visible','off');
set(handles.text_frequency,'Visible','off');
set(handles.edit_frequency,'Visible','off');

set(handles.text_aux1,'Visible','on');
set(handles.edit_aux1,'Visible','on');

set(handles.text_duration,'String','Pulse Duration');    

if(n==5)    
    set(handles.text_duration,'String','Total Duration');
    set(handles.text_ramp_durations,'Visible','on');
    set(handles.text_initial,'Visible','on');
    set(handles.text_final,'Visible','on');
    set(handles.edit_initial,'Visible','on');
    set(handles.edit_final,'Visible','on');     
end

if(n==6)
    
    set(handles.text_duration,'String','Total Duration');
    
    if(nat==2)
        set(handles.text_aux1,'Visible','off');
        set(handles.edit_aux1,'Visible','off');
    end
    
    set(handles.text_frequency,'Visible','on');
    set(handles.edit_frequency,'Visible','on');    
end



% --- Executes on selection change in listbox_analysis_type.
function listbox_analysis_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis_type

common(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function listbox_analysis_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_type (see GCBO)
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



function edit_amp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amp as text
%        str2double(get(hObject,'String')) returns contents of edit_amp as a double


% --- Executes during object creation, after setting all properties.
function edit_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_T_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T as text
%        str2double(get(hObject,'String')) returns contents of edit_T as a double


% --- Executes during object creation, after setting all properties.
function edit_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_time_unit.
function listbox_time_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_time_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_time_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_time_unit


% --- Executes during object creation, after setting all properties.
function listbox_time_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_time_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_aux1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aux1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aux1 as text
%        str2double(get(hObject,'String')) returns contents of edit_aux1 as a double


% --- Executes during object creation, after setting all properties.
function edit_aux1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aux1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_aux2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aux2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aux2 as text
%        str2double(get(hObject,'String')) returns contents of edit_aux2 as a double


% --- Executes during object creation, after setting all properties.
function edit_aux2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aux2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_resp_unit.
function listbox_resp_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_resp_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_resp_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_resp_unit

iu=get(handles.listbox_resp_unit,'Value');

if(iu==1)

    set(handles.text_rd0,'String','Initial Relative Displacement (in)');
    set(handles.text_rv0,'String','Initial Relative Velocity (in/sec)');

else
    
    set(handles.text_rd0,'String','Initial Relative Displacement (mm)');
    set(handles.text_rv0,'String','Initial Relative Velocity (m/sec)');    
    
end


% --- Executes during object creation, after setting all properties.
function listbox_resp_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_resp_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ntype=get(handles.listbox_analysis_type,'Value');

ndata=get(handles.listbox_output_type,'Value');

if(ntype==1) % srs
    if(ndata==1)
        data=getappdata(0,'accleration_srs');
    end
    if(ndata==2)
        data=getappdata(0,'pseudo_velocity_srs');
    end
    if(ndata==3)
        data=getappdata(0,'relative_disp_srs');
    end
else % th
    if(ndata==1)
        data=getappdata(0,'base_input');
    end    
    if(ndata==2)
        data=getappdata(0,'acceleration');
    end
    if(ndata==3)
        data=getappdata(0,'relative_disp');
    end    
end

output_name=get(handles.edit_output_filename,'String');
assignin('base', output_name,data);

h = msgbox('Save Complete'); 


function edit_output_filename_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_filename as text
%        str2double(get(hObject,'String')) returns contents of edit_output_filename as a double


% --- Executes during object creation, after setting all properties.
function edit_output_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
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



function edit_initial_Callback(hObject, eventdata, handles)
% hObject    handle to edit_initial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_initial as text
%        str2double(get(hObject,'String')) returns contents of edit_initial as a double


% --- Executes during object creation, after setting all properties.
function edit_initial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_final_Callback(hObject, eventdata, handles)
% hObject    handle to edit_final (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_final as text
%        str2double(get(hObject,'String')) returns contents of edit_final as a double


% --- Executes during object creation, after setting all properties.
function edit_final_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_final (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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



function edit_rv0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rv0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rv0 as text
%        str2double(get(hObject,'String')) returns contents of edit_rv0 as a double


% --- Executes during object creation, after setting all properties.
function edit_rv0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rv0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rd0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rd0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rd0 as text
%        str2double(get(hObject,'String')) returns contents of edit_rd0 as a double


% --- Executes during object creation, after setting all properties.
function edit_rd0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rd0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
