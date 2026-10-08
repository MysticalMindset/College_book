function varargout = vibrationdata_energy_base(varargin)
% VIBRATIONDATA_ENERGY_BASE MATLAB code for vibrationdata_energy_base.fig
%      VIBRATIONDATA_ENERGY_BASE, by itself, creates a new VIBRATIONDATA_ENERGY_BASE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ENERGY_BASE returns the handle to a new VIBRATIONDATA_ENERGY_BASE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ENERGY_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ENERGY_BASE.M with the given input arguments.
%
%      VIBRATIONDATA_ENERGY_BASE('Property','Value',...) creates a new VIBRATIONDATA_ENERGY_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_energy_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_energy_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_energy_base

% Last Modified by GUIDE v2.5 10-Oct-2015 14:55:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_energy_base_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_energy_base_OutputFcn, ...
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


% --- Executes just before vibrationdata_energy_base is made visible.
function vibrationdata_energy_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_energy_base (see VARARGIN)

% Choose default command line output for vibrationdata_energy_base
handles.output = hObject;

set(handles.listbox_psave,'Value',2);

set(handles.edit_Q,'String','10');


set(handles.listbox_frequency_spacing,'Value',1);
set(handles.listbox_method,'Value',1);

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');

set(handles.uipanel_srs,'Visible','off');

listbox_method_Callback(hObject, eventdata, handles); 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_energy_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_energy_base_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output_type,'Value');

if(n==1)
    data=getappdata(0,'EI'); 
end
if(n==2)
    data=getappdata(0,'EK');
end
if(n==3)
    data=getappdata(0,'ED'); 
end
if(n==4)
    data=getappdata(0,'EA'); 
end   
  
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_srs,'Visible','off');

n=get(handles.listbox_method,'Value');

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
end



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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fspace=get(handles.listbox_frequency_spacing,'Value');

set(handles.uipanel_srs,'Visible','off');

fig_num=1;

iu=get(handles.listbox_unit,'Value');

k=get(handles.listbox_method,'Value');

iflag=1;
 
if(k==1)
     try  
         FS=get(handles.edit_input_array,'String');
         THM=evalin('base',FS);  
         iflag=1;
     catch
         iflag=0; 
         warndlg('Input Array does not exist.  Try again.')
     end
else
  THM=getappdata(0,'THM');
end
 
if(iflag==0)
    return;
end 


y=double(THM(:,2));
yy=y;


n=length(y);

dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);
sr=1/dt;

Q=str2num(get(handles.edit_Q,'String'));

fstart=str2num(get(handles.edit_start_frequency,'String'));
  fend=str2num(get(handles.edit_plot_fmax,'String'));

damp=1/(2*Q);

fn(1)=fstart;

fmax=sr/8;

num=1;

if(fspace==1)

    oct=2^(1/12);

    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)*oct;
  
        if(fn(num)>fmax)
            break;
        end
    
    end

end
if(fspace==2)
    
    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)+1.;
  
        if(fn(num)>fmax)
            break;
        end
    
    end
end    
if(fspace==3)
    
    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)+0.5;
  
        if(fn(num)>fmax)
            break;
        end
    
    end
end    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%  Initialize coefficients
%
[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);
%
%
%  SRS engine
%

EK=zeros(num,1);
ED=zeros(num,1);
EA=zeros(num,1); 

a_pos=zeros(num,1);
a_neg=zeros(num,1); 

progressbar;
for j=1:num
%
    progressbar(j/num); 
%
    forward=[ b1(j),  b2(j),  b3(j) ];    
    back   =[     1, -a1(j), -a2(j) ];
%    
    a_resp=filter(forward,back,yy);
    zdd=a_resp-yy;    
%
    a_pos(j)= max(a_resp);
    a_neg(j)= min(a_resp);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
    rd_forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];    
    rd_back   =[     1, -rd_a1(j), -rd_a2(j) ];      
%    
    rd_resp=filter(rd_forward,rd_back,yy);
    z=rd_resp;    
%
    omegan=2*pi*fn(j);
    tdo=2*damp*omegan; 
%
    om2=omegan^2;
%
    zd=(-yy-zdd-om2*z)/tdo;
%
%%
%  
%
    for i=1:length(z);
        EK(j)=EK(j)+zdd(i)*zd(i);
        ED(j)=ED(j)+tdo*zd(i)^2;
        EA(j)=EA(j)+om2*z(i)*zd(i);
    end
%
    EK(j)=EK(j)*dt;
    ED(j)=ED(j)*dt;
    EA(j)=EA(j)*dt;   
%
%%
%
end
%
pause(0.3);
progressbar(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(iu==1)
    scale=386^2;
    slabel='Energy/Mass (in/sec)^2';
end 
if(iu==2)
    scale=9.81^2;  
    slabel='Energy/Mass ((m/sec)^2';    
end 
if(iu==3)
    scale=1;  
    slabel='Energy/Mass ((m/sec)^2';        
end 
%
EK=EK*scale;
ED=ED*scale;
EA=EA*scale;
%
EI=EK+ED+EA; 

EK=abs(EK);
ED=abs(ED);
EA=abs(EA);
EI=abs(EI);
%
fn=fix_size(fn);
EK=fix_size(EK);
ED=fix_size(ED);
EA=fix_size(EA);
EI=fix_size(EI);
%
setappdata(0,'EK',[fn EK]);
setappdata(0,'ED',[fn ED]);
setappdata(0,'EA',[fn EA]);
setappdata(0,'EI',[fn EI]);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
a_neg=abs(a_neg);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
fn=fix_size(fn);
a_pos=fix_size(a_pos);
a_neg=fix_size(a_neg);
%
accel_data=[fn a_pos a_neg];
%
h=figure(fig_num);
fig_num=fig_num+1;
plot(THM(:,1),THM(:,2));
title('Base Input Acceleration Time History');
xlabel(' Time(sec) ')
if(iu==1 || iu==2)
    ylabel('Accel (G)')
else
    ylabel('Accel (m/sec^2)')    
end
grid on;


psave=get(handles.listbox_psave,'Value');

if(psave==1)
    
    disp(' Plot Files ');
    disp(' ');
    
    pname='base_input_th';
    
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');
    
    out1=sprintf('   %s.png',pname);
    disp(out1);
       
end

plot_fmax=str2num(get(handles.edit_plot_fmax,'String'));

fmin=fstart;
fmax=fend;

t_string=sprintf('Acceleration SRS Q=%g',Q);

if(iu==1 || iu==2)
    y_lab='Peak Accel (G)';
else
    y_lab='Peak Accel (m/sec^2)';    
end
[fig_num,h]=srs_plot_function_h(fig_num,fn,a_pos,a_neg,t_string,y_lab,fmin,fmax);


if(psave==1)
    
    pname='accel_SRS';
    
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');
    
    out1=sprintf('   %s.png',pname);
    disp(out1);
       
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=figure(fig_num);
fig_num=fig_num+1;
plot(fn,EI);
t_string=sprintf('Input Energy per Mass Response Spectrum Q=%g',Q);

title(t_string);
xlabel('Natural Frequency (Hz)');
ylabel(slabel);
%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
end

%
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
xlim([fmin fmax]);
%
grid on;



if(psave==1)
    
    pname='Energy_per_Mass_RS';
    
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');
    
    out1=sprintf('   %s.png',pname);
    disp(out1);
       
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=figure(fig_num);
fig_num=fig_num+1;
plot(fn,EI,fn,EK,fn,ED,fn,EA);
legend('Input','Kinetic','Dissipated','Absorbed','Location','northwest');
t_string=sprintf('Energy per Mass Response Spectrum Q=%g',Q);


title(t_string);
xlabel('Natural Frequency (Hz)');
ylabel(slabel);
%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
end

%
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
xlim([fmin fmax]);
%
grid on;


if(psave==1)
    
    pname='Energy_per_Mass_RS_four';
    
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');
    
    out1=sprintf('   %s.png',pname);
    disp(out1);
       
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'accel_data',accel_data);     

set(handles.pushbutton_save,'Enable','on');
set(handles.edit_output_array,'Enable','on');

n=length(fn);

for i=1:n
    if(fn(i)>plot_fmax)
        i=i-1;
        break;
    end
end

set(handles.uipanel_srs,'Visible','on');

mfn=0;
maxa=0;

for i=1:length(fn)
    if( a_pos(i) > maxa)
        maxa=a_pos(i);
        mfn=fn(i);
    end
    if( a_neg(i) > maxa)
        maxa=a_neg(i);
        mfn=fn(i);
    end    
end

if(iu==1 || iu==2)
    yl='G';
else
    yl='m/sec^2';    
end
disp(' ');
disp(' ******************* ');
disp(' ');
out1=sprintf(' Maximum Response  Q=%g',Q);
out2=sprintf('\n  %8.4g Hz  %8.4g %s  \n',mfn,maxa,yl);
disp(out1);
disp(out2);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_srs_base)

% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
set(handles.uipanel_srs,'Visible','off');

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



function edit_plot_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_plot_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_plot_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_plot_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_srs,'Visible','off');


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_srs,'Visible','off');


% --- Executes on key press with focus on edit_start_frequency and none of its controls.
function edit_start_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_srs,'Visible','off');


% --- Executes on key press with focus on edit_plot_fmax and none of its controls.
function edit_plot_fmax_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_plot_fmax (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_srs,'Visible','off');


% --- Executes on key press with focus on listbox_unit and none of its controls.
function listbox_unit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


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


% --- Executes on selection change in listbox_frequency_spacing.
function listbox_frequency_spacing_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency_spacing contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency_spacing


% --- Executes during object creation, after setting all properties.
function listbox_frequency_spacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
