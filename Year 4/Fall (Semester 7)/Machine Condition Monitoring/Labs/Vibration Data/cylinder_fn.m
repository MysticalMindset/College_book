function varargout = cylinder_fn(varargin)
% CYLINDER_FN MATLAB code for cylinder_fn.fig
%      CYLINDER_FN, by itself, creates a new CYLINDER_FN or raises the existing
%      singleton*.
%
%      H = CYLINDER_FN returns the handle to a new CYLINDER_FN or the handle to
%      the existing singleton*.
%
%      CYLINDER_FN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CYLINDER_FN.M with the given input arguments.
%
%      CYLINDER_FN('Property','Value',...) creates a new CYLINDER_FN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cylinder_fn_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cylinder_fn_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cylinder_fn

% Last Modified by GUIDE v2.5 06-Jul-2015 17:56:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cylinder_fn_OpeningFcn, ...
                   'gui_OutputFcn',  @cylinder_fn_OutputFcn, ...
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


% --- Executes just before cylinder_fn is made visible.
function cylinder_fn_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cylinder_fn (see VARARGIN)

% Choose default command line output for cylinder_fn
handles.output = hObject;

change_material_units(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cylinder_fn wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cylinder_fn_OutputFcn(hObject, eventdata, handles) 
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

iu=get(handles.listbox_units,'Value');

E=str2num(get(handles.edit_elastic_modulus,'String'));
rho=str2num(get(handles.edit_mass_density,'String'));
v=str2num(get(handles.edit_poisson,'String'));
h=str2num(get(handles.edit_thickness,'String'));
L=str2num(get(handles.edit_length,'String'));
diam=str2num(get(handles.edit_diameter,'String'));

if(iu==1)     % English
    rho=rho/386.;
else              % metric
    [E]=GPa_to_Pa(E);
    h=h/1000;
end

c=sqrt(E/rho);

bc=get(handles.listbox_bc,'Value');

%
nmax=160;
mmax=160;
%

[fring]=infinite_cylinder_ring(E,rho,v,h,diam);

[ffb,nnb,mmb,kv,radius]=cylinder_engine(E,rho,v,h,diam,L,mmax,nmax,bc);
a=radius;
%
disp('  ');
disp(' n is circumferential mode parameter, where 2n=the number of ');
disp('   cross points in the radial displacement shape'); 
disp(' ');
disp(' m is axial mode parameter, where m=the number of cross points ');
disp('   along the longitudinal lines ');
disp('  ');
%
disp(' ')
disp('  fn(Hz)   n  m ');
%
mmm=kv-1;
if(mmm>320)
    mmm=320;
end


for i=1:mmm
    out1=sprintf(' %d  %8.2f  %d  %d ',i,ffb(i),nnb(i),mmb(i));
    disp(out1)
end
%
if(fring>0)
    s1=sprintf('\n Infinite Length Ring Frequency = %8.4g Hz  n=0  m=0\n',fring);
    disp(s1);
end    
%
clear fc;
clear nn;
%
ioct=2;
if(ioct==1)
	fc(1)=2.;
	fc(2)=4.;
	fc(3)=8.;
	fc(4)=16.;
	fc(5)=31.5;
	fc(6)=63.;
	fc(7)=125.;
	fc(8)=250.;
	fc(9)=500.;
	fc(10)=1000.;
	fc(11)=2000.;
	fc(12)=4000.;
	fc(13)=8000.;
	fc(14)=16000.;
    imax=14;
end
if(ioct==2)
	fc(1)=2.5;
	fc(2)=3.15;
	fc(3)=4.;
	fc(4)=5.;
	fc(5)=6.3;
	fc(6)=8.;
	fc(7)=10.;
	fc(8)=12.5;
	fc(9)=16.;
	fc(10)=20.;
	fc(11)=25.;
	fc(12)=31.5;
	fc(13)=40.;
	fc(14)=50.;
	fc(15)=63.;
	fc(16)=80.;
	fc(17)=100.;
	fc(18)=125.;
	fc(19)=160.;
	fc(20)=200.;
	fc(21)=250.;
	fc(22)=315.;
	fc(23)=400.;
	fc(24)=500.;
	fc(25)=630.;
	fc(26)=800.;
	fc(27)=1000.;
	fc(28)=1250.;
	fc(29)=1600.;
	fc(30)=2000.;
	fc(31)=2500.;
	fc(32)=3150.;
	fc(33)=4000.;
	fc(34)=5000.;
	fc(35)=6300.;
	fc(36)=8000.;
	fc(37)=10000.;
	fc(38)=12500.;
	fc(39)=16000.;
	fc(40)=20000.;
    imax=40;
end
%
nun=zeros([1 imax]);
for j=1:imax
    fl=fc(j)/sqrt(2);
    fu=fc(j)*sqrt(2);
    for i=1:(kv-1)
        if(ffb(i)>=fl && ffb(i) < fu)
           nun(j)=nun(j)+1;    
        end
        if(ffb(i)>fu)
            break;
        end
    end    
end
%
for j=1:imax
    fl=fc(j)/sqrt(2);
    fu=fc(j)*sqrt(2);  
    nun(j)=nun(j)/(fu-fl);
end
%
md=[fc' nun'];
md=sortrows(md,1);
figure(1);
fig_num=2;
plot(md(:,1),md(:,2));
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
xlabel('Frequency (Hz)');
ylabel('Modes/Hz');
title('Cylinder Modal Density, One-Third Octave Bands');
grid('on');


ffb=fix_size(ffb);
nnb=fix_size(nnb);
mmb=fix_size(mmb);

fn=[ffb nnb mmb];


sz=size(md);
k=1;
for i=1:sz(1)
    if(md(i,2)>1.0e-08)
        mmd(k,:)=md(i,:);
        k=k+1;
    end
end

setappdata(0,'fn',fn);
setappdata(0,'mmd',mmd);
setappdata(0,'a',a);
setappdata(0,'L',L);
setappdata(0,'nnb',nnb);
setappdata(0,'mmb',mmb);
setappdata(0,'fn',fn);
setappdata(0,'bc',bc);
setappdata(0,'fig_num',fig_num);

set(handles.pushbutton_plot,'Visible','on');

msgbox('Results written to Command Window');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
change_material_units(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_materials.
function listbox_materials_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_materials contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_materials
change_material_units(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_materials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_elastic_modulus_Callback(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_elastic_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_elastic_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit_elastic_modulus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_density_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass_density as text
%        str2double(get(hObject,'String')) returns contents of edit_mass_density as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_poisson_Callback(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_poisson as text
%        str2double(get(hObject,'String')) returns contents of edit_poisson as a double


% --- Executes during object creation, after setting all properties.
function edit_poisson_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function change_material_units(hObject, eventdata, handles)

set(handles.pushbutton_plot,'Visible','off');

n=get(handles.listbox_units,'Value');

if(n==1)
    s1='Diameter (in)';
    sem='Elastic Modulus (psi)';
    smd='Mass Density (lbm/in^3)';
    sth='Thickness (in)';  
    sh='Length (in)';
   
else
    s1='Diameter (m)';
    sem='Elastic Modulus (GPa)';
    smd='Mass Density (kg/m^3)'; 
    sth='Thickness (mm)';    
    sh='Length (m)';    
end

set(handles.text_diameter,'String',s1);
set(handles.text_elastic_modulus,'String',sem);
set(handles.text_mass_density,'String',smd);
set(handles.text_thickness,'String',sth);
set(handles.text_length,'String',sh);

m=get(handles.listbox_materials,'Value');

[elastic_modulus,mass_density,poisson]=six_materials(n,m);


ss1=' ';
ss2=' ';
ss3=' ';   

if(m<=6)
        ss1=sprintf('%8.4g',elastic_modulus);
        ss2=sprintf('%8.4g',mass_density);
        ss3=sprintf('%8.4g',poisson);
end
     
set(handles.edit_elastic_modulus,'String',ss1);
set(handles.edit_mass_density,'String',ss2); 
set(handles.edit_poisson,'String',ss3);



function edit_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_diameter as a double


% --- Executes during object creation, after setting all properties.
function edit_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_thickness as a double


% --- Executes during object creation, after setting all properties.
function edit_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_length as text
%        str2double(get(hObject,'String')) returns contents of edit_length as a double


% --- Executes during object creation, after setting all properties.
function edit_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_bc.
function listbox_bc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bc
set(handles.pushbutton_plot,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_bc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'fn');
else
    data=getappdata(0,'mmd');
end


output_name=get(handles.edit_output_array,'String');

assignin('base', output_name, data);

h = msgbox('Save Complete'); 


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' plotting... ');

fn=getappdata(0,'fn');
mmd=getappdata(0,'mmd');
a=getappdata(0,'a');
L=getappdata(0,'L');
nnb=getappdata(0,'nnb');
mmb=getappdata(0,'mmb');
fn=getappdata(0,'fn');
bc=getappdata(0,'bc');

x = inputdlg('Enter mode number');
nq = str2num(x{1});

if(nq>length(fn));
    out1=sprintf(' Maximum mode number = %d',length(fn));
    warndlg(out1);
    return;
end


LN=64;

radius=a;

dL=L/LN;
dT=pi/45;


fig_num=getappdata(0,'fig_num');

figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);

hold on;

n=nnb(nq);
m=mmb(nq);

nnt=90; 
 
dtd=360/nnt; 
 
theta=zeros(nnt,1);

for i=1:nnt
    theta(i)=(i-1)*dtd;
end    

dT=dtd*pi/180;
theta=theta*pi/180;

ntheta=n*theta;
ndT=n*dT;



if(bc==1)  % free-free  
    kL=(2*m+1)*pi/2;
end
if(bc==2)  % fixed-fixed 
    kL=(2*m+1)*pi/2;    
end
if(bc==3)  % fixed-free
    kL=(2*m-1)*pi/2;   
end
if(bc==4)  % simply supported-simply supported
    kL=m*pi;    
end

k=kL/L;


for j=1:(LN+1)
    
    L1=(j-1)*dL;
    L2=L1+dL;
        
    for i=1:90
         
        p=theta(i);
        np=ntheta(i);
                      
        dr=radius/20;
       
        
        r1=radius + dr*sin(np)     + dr*sin(k*L1);
        r2=radius + dr*sin(np+ndT) + dr*sin(k*L1);
        r3=radius + dr*sin(np+ndT) + dr*sin(k*L2);
        r4=radius + dr*sin(np)     + dr*sin(k*L2);
        

        x1=r1*cos(p);
        x2=r2*cos(p+dT);   
        x3=r3*cos(p+dT);         
        x4=r4*cos(p);
                   
        y1=r1*sin(p);
        y2=r2*sin(p+dT);   
        y3=r3*sin(p+dT);         
        y4=r4*sin(p);
        
        
        X=[x1 x2 x3 x4 ];
        Y=[y1 y2 y3 y4 ];
                
             
        Z=[L1 L1 L2 L2];
        
        patch(X,Y,Z,'g');
    end
end

view([-45 45]);

U=max([radius L]);

Ur=U/2;

xlim([ -Ur Ur ]);
ylim([ -Ur Ur ]);
zlim([ 0 U ]);

out1=sprintf(' Mode %d  fn=%8.4g Hz  n=%d m=%d',nq,fn(nq),n,m);
title(out1);

hold off;
