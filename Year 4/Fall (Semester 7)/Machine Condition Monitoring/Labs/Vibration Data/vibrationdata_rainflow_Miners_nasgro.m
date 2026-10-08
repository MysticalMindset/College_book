function varargout = vibrationdata_rainflow_Miners_nasgro(varargin)
% VIBRATIONDATA_RAINFLOW_MINERS_NASGRO MATLAB code for vibrationdata_rainflow_Miners_nasgro.fig
%      VIBRATIONDATA_RAINFLOW_MINERS_NASGRO, by itself, creates a new VIBRATIONDATA_RAINFLOW_MINERS_NASGRO or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_RAINFLOW_MINERS_NASGRO returns the handle to a new VIBRATIONDATA_RAINFLOW_MINERS_NASGRO or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_RAINFLOW_MINERS_NASGRO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_RAINFLOW_MINERS_NASGRO.M with the given input arguments.
%
%      VIBRATIONDATA_RAINFLOW_MINERS_NASGRO('Property','Value',...) creates a new VIBRATIONDATA_RAINFLOW_MINERS_NASGRO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_rainflow_Miners_nasgro_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_rainflow_Miners_nasgro_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_rainflow_Miners_nasgro

% Last Modified by GUIDE v2.5 23-Feb-2016 14:22:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_rainflow_Miners_nasgro_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_rainflow_Miners_nasgro_OutputFcn, ...
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


% --- Executes just before vibrationdata_rainflow_Miners_nasgro is made visible.
function vibrationdata_rainflow_Miners_nasgro_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_rainflow_Miners_nasgro (see VARARGIN)

% Choose default command line output for vibrationdata_rainflow_Miners_nasgro
handles.output = hObject;

set(handles.listbox_method,'Value',1);

listbox_material_Callback(hObject, eventdata, handles);


options_off(hObject,eventdata,handles);

%% set(handles.uipanel_miners,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_rainflow_Miners_nasgro wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function options_off(hObject,eventdata,handles)

%% set(handles.edit_damage_result,'String',' ');

%% set(handles.text_EFT,'Enable','off');
%% set(handles.edit_exponent,'Enable','off');
%% set(handles.pushbutton_calculate_damage,'Enable','off');
%% set(handles.text_DR,'Enable','off');
%% set(handles.edit_damage_result,'Enable','off');
set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save_table,'Enable','off');

%% set(handles.pushbutton_miners,'Enable','off');

%% set(handles.text_valid,'Enable','off');


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_rainflow_Miners_nasgro_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ndt=get(handles.listbox_display_table,'Value');

num_eng=get(handles.listbox_numerical_engine,'Value');

scf=str2num(get(handles.edit_scf,'String'));

k=get(handles.listbox_method,'Value');

try

    if(k==1)
        FS=get(handles.edit_input_array,'String');
        THM=evalin('base',FS);   
    else
        THM=getappdata(0,'THM');
    end

catch
    
    warndlg('Input array not found');
    return;
    
end



THM=fix_size(THM);


sz=size(THM);

if(sz(2)==1)
    y=THM(:,1);
else    
    y=THM(:,2);
end

y=y*scf;

iu=get(handles.listbox_unit,'Value');

if(iu==1) % psi
   y=y/1000;
   YS='Stress (psi)';
end
if(iu==2) % ksi    
   YS='Stress (ksi)';    
end
if(iu==3) % Pa
   y=y/6891.2; 
   YS='Stress (Pa)';
end
if(iu==4) % MPa
   y=y*1.0e+06/6891.2;    
   YS='Stress (MPa)';        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ndf=get(handles.listbox_display_figures,'Value');

if(num_eng==1)
    ttt=THM(:,1);
    [range_cycles,amean,BIG]=vibrationdata_rainflow_mean_function([ttt y],YS,ndf);    
    amp_cycles=[range_cycles(:,1)/2 range_cycles(:,2)];
    amean=fix_size(amean);
    amp_mean_cycles=[range_cycles(:,1)/2 amean range_cycles(:,2)];
else
    
    disp(' ');
    disp(' Calculating... ');
    disp(' ');
%
    dchoice=-1.; % needs to be double
%
    exponent=1;
% 
    [L,C,AverageAmp,MaxAmp,MinMean,AverageMean,MaxMean,MinValley,MaxPeak,D,ac1,ac2,amean,cL]...
                                         =rainflow_mean_mex(y,dchoice,exponent);
%
    sz=size(ac1);
    if(sz(2)>sz(1))
        ac1=ac1';
        ac2=ac2';
    end
%
    ncL=int64(cL);
%
    amp_cycles=[ ac1(1:ncL) ac2(1:ncL) ];
    amean=fix_size(amean);
%    
%%   size(amp_cycles)
%%   size(amean)
%
    amp_mean_cycles=[ ac1(1:ncL) amean(1:ncL) ac2(1:ncL) ];
    range_cycles=[2*amp_cycles(:,1) amp_cycles(:,2)];
%

    clear ac1;
    clear ac2;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    L=flipud(L);
    C=flipud(C);
    AverageAmp=flipud(AverageAmp);
    MaxAmp=flipud(MaxAmp);
    MinMean=flipud(MinMean);    
    AverageMean=flipud(AverageMean);
    MaxMean=flipud(MaxMean);    
    MinValley=flipud(MinValley);
    MaxPeak=flipud(MaxPeak);
%
    clear BIG;
%
    N=max(size(C));
%
    ijk=1;
    for i=1:N-1
      if( abs(L(i))>1.0e-09 && abs(L(i+1))>1.0e-09)
          ijk=ijk+1;
      end
    end
    N=ijk;
%
    BIG=zeros(N,8);
%
%%    MaxAmp=MaxAmp/2;
%%    AverageAmp=AverageAmp/2;
%
    for j=1:N
%
      if(C(j)==0)
         AverageAmp(j)=0.;
         MaxAmp(j)=0.; 
         MinMean(j)=0.;         
         AverageMean(j)=0.;
         MaxMean(j)=0.;         
         MinValley(j)=0.;
         MaxPeak(j)=0.; 
      end
%
      BIG(j,1)=L(j+1);
      BIG(j,2)=L(j);
      BIG(j,3)=C(j);
      BIG(j,4)=AverageAmp(j);
      BIG(j,5)=MaxAmp(j);
      BIG(j,6)=MinMean(j);
      BIG(j,7)=AverageMean(j);      
      BIG(j,8)=MaxMean(j);
      BIG(j,9)=MinValley(j); 
      BIG(j,10)=MaxPeak(j);   
    end      
%
    if(ndf==1)
%
        figure(1);
%
        sz=size(THM);
        
        if(sz(2)==2)
            plot(THM(:,1),THM(:,2));
            xlabel('Time (sec)');
        else
            plot(THM(:,1));            
        end    

%        
        ylabel(YS)
        grid on;
%
        figure(2);
        h=bar(C);
        grid on;
        title('Rainflow');
        ylabel('Cycle Counts');
        xlabel('Range');
%
    end
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(ndt==1)
%
    figure(3)
    hFig = figure(3);
    xwidth=900;
    ywidth=400;
    set(gcf,'PaperPositionMode','auto')
    set(hFig, 'Position', [0 0 xwidth ywidth])
    table1 = uitable;
    set(table1,'ColumnWidth',{27})

    dat =  BIG(:,1:10);
    columnname =   {'Lower Range','Upper Range','Cycles','Ave Amp',...
       'Max Amp','Min Mean','Ave Mean','Max Mean','Min Valley','Max Peak' };
    columnformat = {'numeric', 'numeric','numeric','numeric','numeric',...
       'numeric','numeric','numeric','numeric','numeric'};
    columneditable = [false false false false false false false false false false];   

    sz=size(BIG);
%
    for i = 1:sz(1)
        for j=1:sz(2)
            if(j==3)
                tempStr = sprintf('%10.1f', dat(i,j));                
            else
                tempStr = sprintf('%7.3g', dat(i,j));
            end    
            data_s{i,j} = tempStr;     
        end  
    end
%
    table1 = uitable('Units','normalized','Position',...
            [0 0 1 1], 'Data', data_s,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', columneditable,...
            'RowName',[]);
%
    setappdata(0,'columnname',columnname); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'amp_cycles',amp_cycles); 
setappdata(0,'amp_mean_cycles',amp_mean_cycles); 
setappdata(0,'range_cycles',range_cycles);  
setappdata(0,'BIG',BIG); 


set(handles.pushbutton_save,'Enable','on');
set(handles.edit_output_array,'Enable','on');
set(handles.pushbutton_save_table,'Enable','on');


%% set(handles.text_EFT,'Enable','on');
%% set(handles.edit_exponent,'Enable','on');
%% set(handles.pushbutton_calculate_damage,'Enable','on');
%% set(handles.text_DR,'Enable','on');
%% set(handles.edit_damage_result,'Enable','on');

%% set(handles.pushbutton_miners,'Enable','on');
%% set(handles.text_valid,'Enable','on');


assignin('base', 'range_cycles', range_cycles);

sz=size(range_cycles);

if(sz(1)<=14)
    
   range_cycles=sortrows(range_cycles,1);
   range_cycles=flipud(range_cycles);

   disp(' ');
   disp('     Range  Cycles ');
    
   for i=1:sz(1) 
        out1=sprintf(' %8.4g   %g',range_cycles(i,1),range_cycles(i,2));
        disp(out1);
   end
   
end

A=str2num(get(handles.edit_A,'String'));
B=str2num(get(handles.edit_B,'String'));
C=str2num(get(handles.edit_C,'String'));
P=str2num(get(handles.edit_P,'String'));

if(B<0)
    warndlg(' B coefficient should be > 0 '); 
    return;
end

[damage]=rainflow_stress_damage_nasgro(amp_mean_cycles,A,B,C,P);


disp(' ');
disp(' * * * * ');

sz=size(THM);
nt=sz(1);

if(sz(2)==1)
    tau=1;
else
    tau=THM(nt,1)-THM(1,1);    
end

mlab=getappdata(0,'mlab');
 
out1=sprintf('\n Material: %s ',mlab);
disp(out1);

out1=sprintf('\n A=%g  B=%g  C=%g  P=%g ',A,B,C,P);
disp(out1);

sz=size(THM);

if(sz(2)==2)
    out1=sprintf('\n Duration=%8.4g sec ',tau);
    disp(out1);
end


out1=sprintf('\n Stress Concentration Factor scf=%g',scf);
disp(out1);

out1=sprintf('\n Overall Stress Amplitude with scf =%8.4g ksi ',std(y));
disp(out1);
out1=sprintf('\n Maximum Rainflow Stress Amplitude with scf =%8.4g ksi ',max( amp_mean_cycles(:,1) ));
disp(out1);

out1=sprintf('\n Number of Rainflow Cycles=%8.4g \n',sum(amp_mean_cycles(:,3)));
disp(out1);

out1=sprintf('\n Cumulative Damage=%8.4g ',damage);
disp(out1);

sz=size(THM);

if(sz(2)==2)
    out1=sprintf('\n Cumulative Damage Rate=%8.4g damage/sec\n',damage/tau);
    disp(out1);
end

msgbox('Results written to command window.'); 


% --- Executes on button press in pushbutton_results.
function pushbutton_results_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_rainflow_Miners_nasgro);

% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output_type,'Value');

if(n==1)
    data=getappdata(0,'amp_cycles'); 
end
if(n==2)
    data=getappdata(0,'amp_mean_cycles');     
end
if(n==3)
    data=getappdata(0,'range_cycles');  
end

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

%% set(handles.uipanel_miners,'Visible','on');

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

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
n=get(hObject,'Value');

options_off(hObject,eventdata,handles);

set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');


if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
    
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');    
   set(handles.edit_input_array,'enable','off')
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
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



function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_table.
function pushbutton_save_table_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

BIG=getappdata(0,'BIG');
columnname=getappdata(0,'columnname');

FileName = uiputfile;

% csvwrite(FileName,columnname);

fid = fopen(FileName,'wt');
fprintf(fid, '%s,',columnname{:});
fprintf(fid, '\n');
fclose(fid);

dlmwrite (FileName, BIG, '-append');

h = msgbox('Save Complete'); 




function edit_table_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_table_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_table_name as text
%        str2double(get(hObject,'String')) returns contents of edit_table_name as a double


% --- Executes during object creation, after setting all properties.
function edit_table_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_table_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_exponent_Callback(hObject, eventdata, handles)
% hObject    handle to edit_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_exponent as text
%        str2double(get(hObject,'String')) returns contents of edit_exponent as a double


% --- Executes during object creation, after setting all properties.
function edit_exponent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_exponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate_damage.
function pushbutton_calculate_damage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate_damage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

b=str2num(get(handles.edit_exponent,'String'));

range_cycles=getappdata(0,'range_cycles');  

D=0;

sz=size(range_cycles);

for i=1:sz(1)
    D=D+range_cycles(i,2)*( 0.5*range_cycles(i,1) )^b;
end    

string=sprintf('%8.4g',D);

set(handles.edit_damage_result,'String',string);


function edit_damage_result_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damage_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damage_result as text
%        str2double(get(hObject,'String')) returns contents of edit_damage_result as a double


% --- Executes during object creation, after setting all properties.
function edit_damage_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damage_result (see GCBO)
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
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

options_off(hObject,eventdata,handles);


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


% --- Executes on selection change in listbox_display_table.
function listbox_display_table_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_display_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_display_table contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_display_table


% --- Executes during object creation, after setting all properties.
function listbox_display_table_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_display_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_display_figures.
function listbox_display_figures_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_display_figures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_display_figures contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_display_figures


% --- Executes during object creation, after setting all properties.
function listbox_display_figures_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_display_figures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_numerical_engine.
function listbox_numerical_engine_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_numerical_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_numerical_engine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_numerical_engine


% --- Executes during object creation, after setting all properties.
function listbox_numerical_engine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_numerical_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_miners.
function pushbutton_miners_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_miners (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_miners;    
 
set(handles.s,'Visible','on'); 



function edit_A_Callback(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_A as text
%        str2double(get(hObject,'String')) returns contents of edit_A as a double


% --- Executes during object creation, after setting all properties.
function edit_A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_B_Callback(hObject, eventdata, handles)
% hObject    handle to edit_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_B as text
%        str2double(get(hObject,'String')) returns contents of edit_B as a double


% --- Executes during object creation, after setting all properties.
function edit_B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_C_Callback(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_C as text
%        str2double(get(hObject,'String')) returns contents of edit_C as a double


% --- Executes during object creation, after setting all properties.
function edit_C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
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


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit


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


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('nasgro_coefficients.jpg');
figure(555);
imshow(A,'border','tight','InitialMagnification',100);


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

n=get(handles.listbox_material,'Value');

set(handles.edit_A,'String','');
set(handles.edit_B,'String','');
set(handles.edit_C,'String','');
set(handles.edit_P,'String','');

mlab = 'other';

if(n==1) % Aluminum 6061-T6
    set(handles.edit_A,'String','20.68');
    set(handles.edit_B,'String','9.84');
    set(handles.edit_C,'String','0');
    set(handles.edit_P,'String','0.63');
    mlab = 'Aluminum 6061-T6';
end
if(n==2) % Aluminum 7075-T6
    set(handles.edit_A,'String','18.22');
    set(handles.edit_B,'String','7.77');
    set(handles.edit_C,'String','10.15');
    set(handles.edit_P,'String','0.62');    
    mlab = 'Aluminum 7075-T6';    
end

setappdata(0,'mlab',mlab);



% --- Executes during object creation, after setting all properties.
function listbox_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scf as text
%        str2double(get(hObject,'String')) returns contents of edit_scf as a double


% --- Executes during object creation, after setting all properties.
function edit_scf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
