function varargout = vibrationdata_rectangular_plate_fea(varargin)
% VIBRATIONDATA_RECTANGULAR_PLATE_FEA MATLAB code for vibrationdata_rectangular_plate_fea.fig
%      VIBRATIONDATA_RECTANGULAR_PLATE_FEA, by itself, creates a new VIBRATIONDATA_RECTANGULAR_PLATE_FEA or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_RECTANGULAR_PLATE_FEA returns the handle to a new VIBRATIONDATA_RECTANGULAR_PLATE_FEA or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_RECTANGULAR_PLATE_FEA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_RECTANGULAR_PLATE_FEA.M with the given input arguments.
%
%      VIBRATIONDATA_RECTANGULAR_PLATE_FEA('Property','Value',...) creates a new VIBRATIONDATA_RECTANGULAR_PLATE_FEA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_rectangular_plate_fea_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_rectangular_plate_fea_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_rectangular_plate_fea

% Last Modified by GUIDE v2.5 06-Aug-2018 13:19:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_rectangular_plate_fea_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_rectangular_plate_fea_OutputFcn, ...
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


% --- Executes just before vibrationdata_rectangular_plate_fea is made visible.
function vibrationdata_rectangular_plate_fea_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_rectangular_plate_fea (see VARARGIN)

% Choose default command line output for vibrationdata_rectangular_plate_fea
handles.output = hObject;

clear_all(hObject, eventdata, handles); 

string_one(hObject, eventdata, handles);

%%%%

set(handles.listbox_mode,'Value',1);


point_mass_matrix=zeros(1,2);
setappdata(0,'point_mass_matrix',point_mass_matrix);
assignin('base', 'point_mass_matrix', point_mass_matrix);

constraint_matrix=zeros(1,4);
setappdata(0,'constraint_matrix',constraint_matrix);
assignin('base', 'constraint_matrix', constraint_matrix);

listbox_unit_Callback(hObject, eventdata, handles);

model_key=0;
setappdata(0,'model_key',model_key);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_rectangular_plate_fea wait for user response (see UIRESUME)
% uiwait(handles.figure1);




% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_rectangular_plate_fea_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function clear_all(hObject, eventdata, handles) 



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_rectangular_plate_fea);


function step_generate_mesh(hObject, eventdata, handles)

disp(' ');
disp(' * * * * * * * * * ');
disp(' ');

update_all_masses(hObject, eventdata, handles);

try
   close(1); 
end

fig_num=1;

mass_method=get(handles.listbox_mass_method,'Value');
n=get(handles.listbox_unit,'Value');
iu=n;

if(mass_method<=2)
    rho=str2num(get(handles.edit_mass_density,'String'));
    
    if(iu==1) % English
        rho=rho/386;
    end    
end
if(mass_method==2)
    nsm=str2num(get(handles.edit_nsm,'String'));
    
    if(iu==1) % English
        nsm=nsm/386;
    end
end
if(mass_method==3)
    total_mass=str2num(get(handles.edit_total_mass,'String'));    
    
    if(iu==1) % English
        total_mass=total_mass/386;
    end          
end

  E=str2num(get(handles.edit_elastic_modulus,'String'));
 mu=str2num(get(handles.edit_poisson,'String'));

  
  L=str2num(get(handles.edit_length,'String'));
  W=str2num(get(handles.edit_width,'String'));
  T=str2num(get(handles.edit_thickness,'String'));

  
if(length(L)==0)
    warndlg('Enter Length');
    return;
end
if(length(W)==0)
    warndlg('Enter Width');
    return;
end
if(length(T)==0)
    warndlg('Thickness');
    return;
end

if(iu==2) % metric
    T=T/1000;
    [E]=GPa_to_Pa(E);
    L=L/1000;
    W=W/1000;
end
  
 
area=L*W;
volume=area*T;


mass_method=get(handles.listbox_mass_method,'Value');

if(mass_method<=2)
    bare_mass=rho*volume;
end

if(mass_method==1)    
    total_mass = bare_mass;
end
if(mass_method==2)
    total_mass = (bare_mass + nsm);
end
if(mass_method==3)
    total_mass = str2num(get(handles.edit_total_mass,'String'));
end

rho=total_mass/volume;

setappdata(0,'T',T);
setappdata(0,'L',L);
setappdata(0,'W',W);  
setappdata(0,'iu',iu);  
  
setappdata(0,'E',E);
setappdata(0,'rho',rho);
setappdata(0,'mu',mu);

if(n==1)
    total_mass=total_mass*386;
end


update_all_masses(hObject, eventdata, handles);


h=T;


thick=h;

clear T;

D=E*(h^3)/(12*(1-mu^2));

beta=2*(1-mu);

nx=str2num(get(handles.edit_nodes_length,'String'));
ny=str2num(get(handles.edit_nodes_width,'String'));

setappdata(0,'nx',nx);
setappdata(0,'ny',ny);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

number_nodes=nx*ny;
%
dx=L/(nx-1);
dy=W/(ny-1);
%
setappdata(0,'dx',dx);
setappdata(0,'dy',dy);
%
ijk=1;

node_matrix=zeros(nx*ny,2);

dcmax=1.0e+99;
icenter=1;

disp(' Calculate node_matrix ');

%
for j=1:ny
%    
    for i=1:nx
        node_matrix(ijk,1)=(i-1)*dx;
        node_matrix(ijk,2)=(j-1)*dy;      
        
        aa=(L/2)-node_matrix(ijk,1);
        bb=(W/2)-node_matrix(ijk,2);
        
        dc=sqrt( aa^2 + bb^2);
        
        if(dc<dcmax)
            dcmax=dc;
            icenter=ijk;
        end
        
        ijk=ijk+1;  
    end
%    
end

%
ne=(nx-1)*(ny-1);
nelem=ne;
%
j=1;
k=1;

disp(' Calculate element_matrix ');

for i=1:ne
%
    element_matrix(i,1)=j; 
    element_matrix(i,2)=j+1; 
    element_matrix(i,3)=element_matrix(i,2)+nx;
    element_matrix(i,4)=element_matrix(i,1)+nx;
%
    j=j+1;
    k=k+1;
    
    if(k==nx)
        j=j+1;
        k=1;
    end
%    
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

disp(' Plot node_matrix ');

h=figure(fig_num);
fig_num=fig_num+1;
if(iu==1)
    plot(node_matrix(:,1),node_matrix(:,2),'.');
else
    plot(1000*node_matrix(:,1),1000*node_matrix(:,2),'.');    
end
%
clear nodex;
clear nodey;
nodex=node_matrix(:,1);
nodey=node_matrix(:,2);

%
for i=1:number_nodes
   string=num2str(i,'%d\n');
   if(iu==1)
        text(nodex(i),nodey(i),string);
   else
        text(1000*nodex(i),1000*nodey(i),string);       
   end
end
%
if(iu==1)
    xlabel('X (in)');
    ylabel('Y (in)');
else
    xlabel('X (mm)');
    ylabel('Y (mm)');    
end
title('Nodes & Elements');
grid on;
%
xmax=max(nodex)+dx/2;
ymax=max(nodey)+dy/2;
%
xmin=min(nodex)-dx/2;
ymin=min(nodey)-dy/2;
%
if(iu==1)
    axis([xmin,xmax,ymin,ymax]);
else
    xxmin=xmin*1000;
    xxmax=xmax*1000;    
    yymin=ymin*1000;
    yymax=ymax*1000;       
    axis([xxmin,xxmax,yymin,yymax]);    
end    
%
node1=element_matrix(:,1);
node2=element_matrix(:,2);
node3=element_matrix(:,3);
node4=element_matrix(:,4);
%
hold on;
%
for i=1:ne
    x=[ nodex(node1(i)) nodex(node2(i)) nodex(node3(i)) nodex(node4(i)) nodex(node1(i))];
    y=[ nodey(node1(i)) nodey(node2(i)) nodey(node3(i)) nodey(node4(i)) nodey(node1(i))];

    if(iu==1)
        plot(x,y);    
    else
        xx=1000*x;
        yy=1000*y;
        plot(xx,yy);        
    end
end
hold off;
%
pname='nodes_elements.emf';        
out1=sprintf('\n plot file:   %s \n',pname);
disp(out1);
    
set(gca,'Fontsize',12);
print(h,pname,'-dmeta','-r300');
%
dof=number_nodes*3;
setappdata(0,'dof',dof);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Calculating uncontrained mass and stiffness matrices... ');

[mass,stiff,total_volume]=vibrationdata_rectangular_plate_mass_stiff...
  (nelem,nodex,nodey,node1,node2,node3,node4,mu,beta,thick,dof,rho,D);   
%
mass_unc=mass;
stiff_unc=stiff;


setappdata(0,'icenter',icenter);
setappdata(0,'nodex',nodex);
setappdata(0,'nodey',nodey);

setappdata(0,'mass_unc',mass_unc);
setappdata(0,'stiff_unc',stiff_unc);
setappdata(0,'node_matrix',node_matrix);
setappdata(0,'fig_num',fig_num);
setappdata(0,'number_nodes',number_nodes);
setappdata(0,'total_mass',total_mass);

setappdata(0,'iu',iu);

setappdata(0,'node_matrix',node_matrix);
setappdata(0,'element_matrix',element_matrix);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
disp('* Unconstrained model statistics ');
out1=sprintf('\n  nodes=%d  elements=%d   degrees-of-freedom=%d  \n',number_nodes,nelem,dof);
disp(out1);

n=icenter;
ctdof=(n-1)*3+1;


out1=sprintf('  Node nearest center = %d \n   with translational dof = %d ',icenter,ctdof);
disp(out1);

setappdata(0,'icenter',icenter);
setappdata(0,'ctdof',ctdof);


disp(' ');
disp(' Generation complete');
msgbox('Generation Complete');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton_generate_mesh.
function pushbutton_generate_mesh_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_generate_mesh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)






function edit_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_width as text
%        str2double(get(hObject,'String')) returns contents of edit_width as a double
update_all_masses(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
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
update_all_masses(hObject, eventdata, handles);

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



function edit_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_thickness as a double
update_all_masses(hObject, eventdata, handles);

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



function edit_nsm_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nsm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nsm as text
%        str2double(get(hObject,'String')) returns contents of edit_nsm as a double
update_all_masses(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit_nsm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nsm (see GCBO)
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
update_all_masses(hObject, eventdata, handles);

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



function edit_total_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_total_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_total_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_total_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_total_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_total_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material

clear_all(hObject, eventdata, handles); 

n=get(handles.listbox_unit,'Value');

m=get(handles.listbox_material,'Value');

if(n==1)  % English
    if(m==1) % aluminum
        elastic_modulus=1e+007;
        mass_density=0.1;  
    end  
    if(m==2)  % steel
        elastic_modulus=3e+007;
        mass_density= 0.28;         
    end
    if(m==3)  % copper
        elastic_modulus=1.6e+007;
        mass_density=  0.322;
    end
    if(m==4)  % G10
        elastic_modulus=2.7e+006;
        mass_density=  0.065;
    end
else                 % metric
    if(m==1)  % aluminum
        elastic_modulus=70;
        mass_density=  2700;
    end
    if(m==2)  % steel
        elastic_modulus=205;
        mass_density=  7700;        
    end
    if(m==3)   % copper
        elastic_modulus=110;
        mass_density=  8900;
    end
    if(m==4)  % G10
        elastic_modulus=18.6;
        mass_density=  1800;
    end
end
 
if(m==1) % aluminum
        poisson=0.33;  
end  
if(m==2)  % steel
        poisson= 0.30;         
end
if(m==3)  % copper
        poisson=  0.33;
end
if(m==4)  % G10
        poisson=  0.12;
end
 
if(m<5)
    ss1=sprintf('%8.4g',elastic_modulus);
    ss2=sprintf('%8.4g',mass_density);
    ss3=sprintf('%8.4g',poisson);  
 
    set(handles.edit_elastic_modulus,'String',ss1);
    set(handles.edit_mass_density,'String',ss2);  
    set(handles.edit_poisson,'String',ss3);  
end

listbox_mass_method_Callback(hObject, eventdata, handles);
update_all_masses(hObject, eventdata, handles);
  

function update_bare_plate(hObject, eventdata, handles)
%

iu=get(handles.listbox_unit,'Value');

try
    L=str2num(get(handles.edit_length,'String'));
    W=str2num(get(handles.edit_width,'String'));
    T=str2num(get(handles.edit_thickness,'String')); 
    rho=str2num(get(handles.edit_mass_density,'String'));     
    
    if(iu==2)
        L=L/1000;
        W=W/1000;
        T=T/1000;
    end
    
    volume=L*W*T;
    
    out1=sprintf('volume=%6.3g  rho=%6.3g',volume,rho);
%%    disp(out1);
    
    bare_mass=volume*rho;
    s2=sprintf('%6.3g',bare_mass);
    if(bare_mass>0 && bare_mass<1.0e+20)
        set(handles.edit_bare_plate_mass,'String',s2);
    else
        set(handles.edit_bare_plate_mass,'String','0');
    end
catch
    set(handles.edit_bare_plate_mass,'String','0');
end 

    
    
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


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

update_all_masses(hObject, eventdata, handles);

n=get(handles.listbox_unit,'Value');

if(n==1)
    sem='Elastic Modulus (psi)';
    smd='Mass Density (lbm/in^3)';
    snsm='Nonstructural Mass (lbm)';
    sbare='Bare Plate Mass (lbm)';
    spoint='Point Masses (lbm)';    
    stmass='Total Mass (lbm)';
    sL='Length (in)';
    sW='Width (in)';
    sT='Thickness (in)';
else
    sem='Elastic Modulus (GPa)';
    smd='Mass Density (kg/m^3)';
    snsm='Nonstructural Mass (kg)';
    sbare='Bare Plate Mass (kg)';  
    spoint='Point Masses (kg)';      
    stmass='Total Mass (kg)';
    sL='Length (mm)';
    sW='Width (mm)';
    sT='Thickness (mm)';    
end    
%
set(handles.text_elastic_modulus,'String',sem);
set(handles.text_mass_density,'String',smd);
set(handles.text_nsm,'String',snsm);
set(handles.text_total_mass,'String',stmass);
set(handles.text_length,'String',sL);
set(handles.text_width,'String',sW);
set(handles.text_thickness,'String',sT);
set(handles.text_bare_plate,'String',sbare);
set(handles.text_point_mass,'String',spoint);

listbox_material_Callback(hObject, eventdata, handles);
clear_all(hObject, eventdata, handles); 

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


% --- Executes on selection change in listbox_mass_method.
function listbox_mass_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mass_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mass_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mass_method

set(handles.edit_total_mass,'String','0');

clear_all(hObject, eventdata, handles); 

n=get(handles.listbox_mass_method,'Value');

set(handles.text_mass_density,'Visible','off');
set(handles.edit_mass_density,'Visible','off');   


set(handles.edit_nsm,'Enable','off');

set(handles.edit_total_mass,'Enable','off');

if(n<=2)
    set(handles.text_mass_density,'Visible','on');
    set(handles.edit_mass_density,'Visible','on');      
end

if(n==2)
    set(handles.edit_nsm,'Enable','on');
else
    set(handles.edit_nsm,'String','0');    
end
if(n==3)
    set(handles.edit_total_mass,'Enable','on');    
end

update_all_masses(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_mass_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mass_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nodes_width_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nodes_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nodes_width as text
%        str2double(get(hObject,'String')) returns contents of edit_nodes_width as a double


% --- Executes during object creation, after setting all properties.
function edit_nodes_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nodes_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nodes_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nodes_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nodes_length as text
%        str2double(get(hObject,'String')) returns contents of edit_nodes_length as a double


% --- Executes during object creation, after setting all properties.
function edit_nodes_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nodes_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function step_constraints(hObject, eventdata, handles)

setappdata(0,'ic_choice',0);


set(handles.uipanel_plot_modes,'Visible','off');

handles.s=rectangular_plate_fea_constraints;
set(handles.s,'Visible','on')



% --- Executes on button press in pushbutton_constraints.
function pushbutton_constraints_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_constraints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function step_calculate_fn(hObject, eventdata, handles)

fig_num=getappdata(0,'fig_num');

mass_method=get(handles.listbox_mass_method,'Value');


try
    THM=evalin('base','point_mass_matrix');   
    point_mass_matrix=THM;
end


mass=getappdata(0,'mass_unc');
stiff=getappdata(0,'stiff_unc');
dof=getappdata(0,'dof');

iu=getappdata(0,'iu');

nodex=getappdata(0,'nodex');
nodey=getappdata(0,'nodey');
number_nodes=getappdata(0,'number_nodes');

ibc=0;

try
    THM=evalin('base','constraint_matrix');   
    constraint_matrix=THM;
    n=length(constraint_matrix(:,1));   
    
    for i=1:n
        if(constraint_matrix(i,1)>0)
            ibc=ibc+1;
        end
    end
    
end

out1=sprintf('\n number of constrained nodes = %d \n',ibc);
disp(out1);



pmt=0;

try
    sz=size(point_mass_matrix);

    if(sz(1)>0 )
   
        for i=1:sz(1)
       
            if(point_mass_matrix(i,1)>0)
           
                pm=point_mass_matrix(i,2);
            
                if(iu==1)
                    pm=pm/386;                
                end
            
                n=3*point_mass_matrix(i,1)-2;
            
                mass(n,n)=mass(n,n)+pm;
                pmt=pmt+pm;
            
            end
        
        end
    
    end
catch
% no point mass
end

mass_unc=mass;


icenter=getappdata(0,'icenter');
ctdof=getappdata(0,'ctdof');


if(ibc>=1 && constraint_matrix(1,1) ~= 0)

    [mass,stiff,pp,con,qicenter,qctdof,ivector]=...
        rectangular_plate_apply_constraints_c(constraint_matrix,ibc,mass,stiff,icenter,ctdof);

end



disp(' Calculate eigenvalues...  ');
disp(' ');

tic
[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiff,mass,2);
toc

disp(' ');
disp(' Finished eigenvalue calculation ');


%%%

ndd=length(fn);


iu=getappdata(0,'iu');

L=str2num(get(handles.edit_length,'String'));
W=str2num(get(handles.edit_width,'String'));
T=str2num(get(handles.edit_thickness,'String'));

if(iu==2)
   L=L/1000;
   W=W/1000;
   T=T/1000;
end

if(mass_method<=2)

    rho=str2num(get(handles.edit_mass_density,'String'));


    pmass=L*W*T*rho;

    total_mass=pmass;

    if(pmt>0)
        if(iu==1)
            total_mass=pmass+pmt*386;
        else
            total_mass=pmass+pmt;
        end
    end

else
    total_mass=str2num(get(handles.edit_total_mass,'String'));    
end

total_mass



setappdata(0,'total_mass',total_mass);
ss=sprintf('%8.4g',total_mass);
set(handles.edit_total_mass,'String',ss);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ibc>=1 && constraint_matrix(1,1) ~= 0)
    [ModeShapes_corrected]=mode_shape_correction(dof,pp,con,ModeShapes);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    LM=ModeShapes'*mass*ivector;
    
    
    pf=LM;

%    
    mmm=ModeShapes'*mass*ModeShapes;   
%  
    clear length;
    nndd=length(pf);
    for i=1:nndd
        pff(i)=pf(i)/mmm(i,i);
        emm(i)=pf(i)^2/mmm(i,i);
        if(emm(i) < 1e-30)
            emm(i)=0.;
            pff(i)=0.;
        end    
%

    end
%
    pdof=length(emm);
    if(pdof>40)
        pdof=40;
    end
%
    mmat=get(handles.listbox_material,'Value');
    if(mmat==1)
       out1='Material: aluminum';
    end
    if(mmat==2)
       out1='Material: steel';
    end
    if(mmat==3)
       out1='Material: copper';
    end
    if(mmat==4)
       out1='Material: G10';
    end
    if(mmat==5)
       out1='Material: other';
    end    
    disp(out1);
%
    disp(' ');
    disp('                                        Effective            ');
    disp('           Natural     Participation    Modal Mass   Mass    ');
    
    if(iu==1)
        disp('Mode       Freq(Hz)       Factor          (lbm)      Percent ');
    else
        disp('Mode       Freq(Hz)       Factor          (kg)      Percent ');        
    end
%
    sss=0;
    
    
    tmm=total_mass;
    
    if(iu==1)
        tmm=tmm/386;
    end

    for i=1:pdof
        frac=100*emm(i)/tmm;
        if(frac<0.0001)
            frac=0;
        end
        if(iu==1)
            out1 = sprintf('  %d \t %11.5g \t %9.5f \t %9.5f \t %7.3f',i,fn(i),pff(i),386*emm(i),frac);
        else
            out1 = sprintf('  %d \t %11.5g \t %9.5f \t %9.5f \t %7.3f',i,fn(i),pff(i),emm(i),frac);            
        end
        disp(out1)
        
        
        sss=sss+emm(i);
        
        if(i==24)
            break;
        end
    end        
%
    disp(' ')
    
    
    if(iu==1)
        out1 = sprintf(' Total Effective Modal Mass = %10.4g lbf sec^2/in',sss );
        out2 = sprintf('                            = %10.4g lbm',sss*386 );
    else
        out1 = sprintf(' Total Effective Modal Mass = %10.4g kg',sss );        
    end
    
    
    disp(out1)
    if(iu==1)
        disp(out2)
    end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


setappdata(0,'mass_unc',mass_unc);
setappdata(0,'mass',mass);
setappdata(0,'stiff',stiff);
setappdata(0,'fn',fn);

setappdata(0,'ModeShapes',ModeShapes);
setappdata(0,'ModeShapes_corrected',ModeShapes_corrected);


setappdata(0,'ibc',ibc);
setappdata(0,'pff',pff);
setappdata(0,'emm',emm);
setappdata(0,'ivector',ivector);

set(handles.uipanel_plot_modes,'Visible','on');


disp(' ');
disp(' The following arrays are saved to Matlab Workspace: ');

disp(' ');
disp(' Plate constrained matrices');
disp('   plate_mass  & plate_stiffness ');

assignin('base','plate_mass',mass);
assignin('base','plate_stiffness',stiff); 

disp(' ');
disp(' Natural frequencies and mass-normalized mode shapes');
disp('   plate_fn  & plate_modes ');

assignin('base','plate_fn',fn);
assignin('base','plate_modes',ModeShapes); 



disp(' ');
disp(' Note that the plotting elements are triangular ');
disp(' even though the FEA model elements are rectangular. ');

% set(handles.pushbutton_damping,'Visible','on');
update_all_masses(hObject, eventdata, handles);


icenter=getappdata(0,'icenter');

if(icenter>1)
    out1=sprintf('  Node nearest center = %d ',icenter);
    disp(out1);
end

out1=sprintf('\n Constrained translational dof nearest center = %d  \n',qctdof);
disp(out1);

msgbox('fn Calculation Complete');



% --- Executes on button press in pushbutton_calculate_fn.
function pushbutton_calculate_fn_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    fig_num=getappdata(0,'fig_num');    
catch
   fig_num=500; 
end

if(isempty(fig_num))
    fig_num=500;
end


iu=getappdata(0,'iu');
dof=getappdata(0,'dof');

nodex=getappdata(0,'nodex');
nodey=getappdata(0,'nodey');
number_nodes=getappdata(0,'number_nodes');

fn=getappdata(0,'fn');
ModeShapes=getappdata(0,'ModeShapes_corrected');
    
k=get(handles.listbox_mode,'Value');

[fig_num]=...
vibrationdata_rectangular_elements_plot_modes(nodex,nodey,fig_num,ModeShapes,fn,number_nodes,k,iu);
    


function edit_mode_number_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mode_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mode_number as text
%        str2double(get(hObject,'String')) returns contents of edit_mode_number as a double


% --- Executes during object creation, after setting all properties.
function edit_mode_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mode_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_mode.
function listbox_mode_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mode


% --- Executes during object creation, after setting all properties.
function listbox_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function step_point_mass(hObject, eventdata, handles)

setappdata(0,'ichoice',0);

% handles.s=rectangular_plate_fea_point_mass;
% set(handles.s,'Visible','on')

h=rectangular_plate_fea_point_mass;

waitfor(h);

update_all_masses(hObject, eventdata, handles)


% --- Executes on button press in pushbutton_point_mass.
function pushbutton_point_mass_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_point_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function update_all_masses(hObject, eventdata, handles)
%
update_bare_plate(hObject, eventdata, handles);
update_point_mass(hObject, eventdata, handles);
update_total_mass(hObject, eventdata, handles);


function update_total_mass(hObject, eventdata, handles)
%

n=get(handles.listbox_mass_method,'Value');


if(n==3)
    return;
end

try
  nsm=str2num(get(handles.edit_nsm,'String'));
catch
  nsm=0;
end

try
  bare_mass=str2num(get(handles.edit_bare_plate_mass,'String'));
catch
  bare_mass=0;
end

try
  point_mass=str2num(get(handles.edit_point_mass,'String'));
catch
  point_mass=0;
end


tm=nsm+bare_mass+point_mass;

ss=sprintf('%6.3g',tm);
set(handles.edit_total_mass,'String',ss);



function update_point_mass(hObject, eventdata, handles)
%
%% disp(' update point mass');
%
try
    point_mass_matrix=evalin('base','point_mass_matrix');   
    pmt=sum(point_mass_matrix(:,2));
    ss=sprintf('%6.3g',pmt);
catch
%%    disp(' update point mass failed');
     ss='0';
end


set(handles.edit_point_mass,'String',ss); 


function step_damping(hObject, eventdata, handles)

handles.s=plate_fea_damping;     
set(handles.s,'Visible','on'); 




% --- Executes on button press in pushbutton_damping.
function pushbutton_damping_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function step_partition_Callback(hObject, eventdata, handles)

%  ea=[1 2]  dof with enforced

% num total dof
% nem number of dof with enforced acceleration

%
%  etype =1  enforced acceleration
%         2  enforced displacement
%


mass=getappdata(0,'mass_unc');
stiff=getappdata(0,'stiff_unc');

sz=size(mass);
dof=sz(1);

tracking_array=zeros(dof,1);


for i=1:dof
    tracking_array(i)=i;
    free_dof_array(i)=i;
end

TZ_tracking_array=zeros(dof,2);

num_nodes=round(dof/3);

for i=1:num_nodes
   TZ_tracking_array(i)=3*i-2;
end


k=1;

ibc=1;

try
    THM=evalin('base','constraint_matrix');   
    constraint_matrix=THM;
    n=length(constraint_matrix(:,1));   
    
    
    for i=1:n
        if(constraint_matrix(i,2)==1)

            ea(k)=3*constraint_matrix(i,1)-2;
            
%%           out1=sprintf('* %d %d %8.4g  ',i,n,ea(k));
%%           disp(out1);
            
            k=k+1;
            
        end
        
        if(constraint_matrix(i,3)==1 || constraint_matrix(i,4)==1  )
            rot_constraint_matrix(ibc,1)=constraint_matrix(i,1);
            rot_constraint_matrix(ibc,2)=0;
            rot_constraint_matrix(ibc,3)=constraint_matrix(i,3);
            rot_constraint_matrix(ibc,4)=constraint_matrix(i,4);
            ibc=ibc+1;
        end
        
        
    end
    
catch
    warndlg('constraint matrix unavailable');
    return;
end

ibc=ibc-1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



sz=size(constraint_matrix);

nc=sz(1);

k=1;
for i=1:nc 
    
     cmn=constraint_matrix(i,1);
    
     if(constraint_matrix(i,2)==1)
        cdof(k)=3*cmn-2;
        k=k+1;
     end    
     if(constraint_matrix(i,3)==1)
        cdof(k)=3*cmn-1;
        k=k+1;
     end
     if(constraint_matrix(i,4)==1)
        cdof(k)=3*cmn;
        k=k+1;
     end     
end

cdof=sort(cdof,'descend');

for i=1:length(cdof);
    free_dof_array(cdof(i))=[];
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


k=1;
for i=1:ibc 
     if(rot_constraint_matrix(i,3)==1)
        rot_dof(k)=3*rot_constraint_matrix(i,1)-1;
        k=k+1;
     end
     if(rot_constraint_matrix(i,4)==1)
        rot_dof(k)=3*rot_constraint_matrix(i,1);
        k=k+1;
     end     
end

rot_dof=sort(rot_dof);
ibc=length(rot_dof);    
     

ea=unique(ea);
nem=length(ea);
setappdata(0,'nem',nem);

ea=fix_size(ea);



eac(:,1)=ea;


if(ibc>=1)  % correct ea matrix
    
    rot_dof=sort(rot_dof,'descend');
    
    for i=1:ibc
        for j=1:nem
            if(ea(j)>rot_dof(i))
                ea(j)=ea(j)-1;
%%                out7=sprintf(' %d %d ',ea(j),rot_dof(i));
%%                disp(out7);
            end
        end
    end
    
    drot_dof=sort(rot_dof,'descend');
    
    for i=1:ibc
        
      tracking_array(drot_dof(i))=[];
         
    end   

    
    for i=1:ibc
        for j=1:num_nodes
            if( TZ_tracking_array(j)>rot_dof(i) )
                   TZ_tracking_array(j)=TZ_tracking_array(j)-1;
            end       
        end
    end    
    
    
end


eac(:,2)=ea;

for i=1:length(ea)
    eac(i,3)=eac(i,2)-eac(i,1);
end
    

ea=unique(ea);
nem=length(ea);


if(nem==0)
    warndlg('No drive dofs');
    return;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(ibc>1)  % apply rotational constraints
    [mass,stiff,pp,con]=...
        rectangular_plate_apply_constraints(rot_constraint_matrix,ibc,mass,stiff);
end



sz=size(mass);
num=sz(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
etype=1;
 
% num total dof
% nem number of dof with enforced acceleration
 
disp(' Track Changes ');  
 
[ngw]=track_changes(nem,num,ea);
 
dtype=2; % display partitioned matrices

%% out1=sprintf('\n ** num=%d  nem=%d \n',num,nem);
%% disp(out1);

 
disp(' Enforced Partition Matrices ');    

[TT,T1,T2,Mwd,Mww,Kwd,Kww]=...
                enforced_partition_matrices(num,ea,mass,stiff,etype,dtype);


disp(' Generalized Eigen ');            
            
[part_fn,part_omega,part_ModeShapes,part_MST]=Generalized_Eigen(Kww,Mww,2);            
            
setappdata(0,'TT',TT);
setappdata(0,'T1',T1);
setappdata(0,'T2',T2);

setappdata(0,'Mwd',Mwd);
setappdata(0,'Mww',Mww);
setappdata(0,'Kwd',Kwd);
setappdata(0,'Kww',Kww);

 
setappdata(0,'TZ_tracking_array',TZ_tracking_array); 

setappdata(0,'tracking_array',tracking_array); 
setappdata(0,'free_dof_array',free_dof_array); 

setappdata(0,'part_fn',part_fn);
setappdata(0,'part_omega',part_omega);
setappdata(0,'part_ModeShapes',part_ModeShapes);
setappdata(0,'ngw',ngw);



msgbox('Partitioning Complete');            





% --- Executes on button press in pushbutton_partition.
function pushbutton_partition_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_partition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% --- Executes on key press with focus on edit_elastic_modulus and none of its controls.
function edit_elastic_modulus_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 


% --- Executes on key press with focus on edit_poisson and none of its controls.
function edit_poisson_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 


% --- Executes on key press with focus on edit_mass_density and none of its controls.
function edit_mass_density_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 
update_all_masses(hObject, eventdata, handles);

% --- Executes on key press with focus on edit_nsm and none of its controls.
function edit_nsm_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_nsm (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 
update_all_masses(hObject, eventdata, handles);

% --- Executes on key press with focus on edit_total_mass and none of its controls.
function edit_total_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_total_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 


% --- Executes on key press with focus on edit_length and none of its controls.
function edit_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 
update_all_masses(hObject, eventdata, handles);

% --- Executes on key press with focus on edit_width and none of its controls.
function edit_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_width (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_all(hObject, eventdata, handles); 
update_all_masses(hObject, eventdata, handles);

% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 
update_all_masses(hObject, eventdata, handles);

% --- Executes on key press with focus on edit_nodes_length and none of its controls.
function edit_nodes_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_nodes_length (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 


% --- Executes on key press with focus on edit_nodes_width and none of its controls.
function edit_nodes_width_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_nodes_width (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_all(hObject, eventdata, handles); 


% --- Executes on button press in pushbutton_plate_fea_transmissibility.
function pushbutton_plate_fea_transmissibility_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plate_fea_transmissibility (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton_plate_fea_sine.
function pushbutton_plate_fea_sine_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plate_fea_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=plate_fea_sine;     
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_PSD.
function pushbutton_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=plate_fea_psd;     
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_arbitrary.
function pushbutton_arbitrary_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arbitrary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=plate_fea_arbitrary;     
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_load_model.
function pushbutton_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

reset_all(hObject, eventdata, handles);


[filename, pathname] = uigetfile('*.mat');
 
NAME = [pathname,filename];

struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);

for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct

try

   BeamSettings=evalin('base','BeamSettings');

catch
   warndlg(' evalin failed ');
   return;
end

rho=0;
nsm=0;
total_mass=0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    iu=BeamSettings.iu;
    setappdata(0,'iu',iu);
    set(handles.listbox_unit,'Value',iu);
    listbox_unit_Callback(hObject, eventdata, handles);   
catch    
end

try
    icenter=BeamSettings.icenter;
    setappdata(0,'icenter',icenter); 
catch    
end

try
    ctdof=BeamSettings.ctdof;
    setappdata(0,'ctdof',ctdof); 
catch    
end

try
    setappdata(0,'n',BeamSettings.n); 
catch    
end

try
    nx=BeamSettings.nx;
    setappdata(0,'nx',nx); 
    ss=sprintf('%d',nx);
    set(handles.edit_nodes_length,'String',ss);
catch    
end

try
    ny=BeamSettings.ny;
    setappdata(0,'ny',ny); 
    ss=sprintf('%d',ny);
    set(handles.edit_nodes_width,'String',ss);    
catch    
end

try
    T=BeamSettings.T;
    setappdata(0,'T',T); 
    ss=sprintf('%g',T);
    set(handles.edit_thickness,'String',ss);    
catch    
end

try
    L=BeamSettings.L; 
    ss=sprintf('%g',L);
    set(handles.edit_length,'String',ss);
    if(iu==2)
        L=L/1000;
    end
    setappdata(0,'L',L);
catch    
end

try
    W=BeamSettings.W;
    ss=sprintf('%g',W);
    set(handles.edit_width,'String',ss);
    if(iu==2)
        W=W/1000;
    end    
    setappdata(0,'W',W);
catch    
end

try
    E=BeamSettings.E;
    setappdata(0,'E',E); 
    ss=sprintf('%g',E);
    set(handles.edit_elastic_modulus,'String',ss);    
catch    
end

try
    rho=BeamSettings.rho;
    setappdata(0,'rho',rho); 
    ss=sprintf('%g',rho);    
    set(handles.edit_mass_density,'String',ss);    
catch    
end

try
    mu=BeamSettings.mu;
    setappdata(0,'mu',mu); 
    ss=sprintf('%g',mu);       
    set(handles.edit_poisson,'String',ss);    
catch    
end

try
    nm=BeamSettings.nm;
    setappdata(0,'nm',nm); 
catch    
end

try
    nsm=BeamSettings.nsm;
    setappdata(0,'nsm',nsm); 
    ss=sprintf('%g',nsm);     
    set(handles.edit_nsm,'String',ss);    
catch    
end

try
    total_mass=BeamSettings.total_mass;
    setappdata(0,'total_mass',total_mass); 
    ss=sprintf('%g',total_mass);    
    set(handles.edit_total_mass,'String',ss);    
catch    
end

try
    dx=BeamSettings.dx;
    setappdata(0,'dx',dx); 
catch    
end

try
    dy=BeamSettings.dy;
    setappdata(0,'dy',dy); 
catch    
end

try
    dof=BeamSettings.dof;
    setappdata(0,'dof',dof); 
catch    
end

try
    number_nodes=BeamSettings.number_nodes;
    setappdata(0,'number_nodes',number_nodes); 
catch    
end

try
    nodex=BeamSettings.nodex;
    setappdata(0,'nodex',nodex); 
catch    
end

try
    nodey=BeamSettings.nodey;
    setappdata(0,'nodey',nodey); 
catch    
end

try
    m=BeamSettings.mass_method;
    set(handles.listbox_mass_method,'Value',m);
    listbox_mass_method_Callback(hObject, eventdata, handles);
catch    
end


try
    mass_unc=BeamSettings.mass_unc;
    setappdata(0,'mass_unc',mass_unc); 
catch    
end

try
    stiff_unc=BeamSettings.stiff_unc;
    setappdata(0,'stiff_unc',stiff_unc); 
catch    
end

try
    node_matrix=BeamSettings.node_matrix;
    setappdata(0,'node_matrix',node_matrix); 
catch    
end

try
    element_matrix=BeamSettings.element_matrix;
    setappdata(0,'element_matrix',element_matrix); 
catch    
end

try
    setappdata(0,'point_mass_matrix',BeamSettings.point_mass_matrix); 
    assignin('base', 'point_mass_matrix',BeamSettings.point_mass_matrix);    
catch    
end

try
    setappdata(0,'constraint_matrix',BeamSettings.constraint_matrix); 
    assignin('base', 'constraint_matrix',BeamSettings.constraint_matrix);    
catch    
end

try
    setappdata(0,'ematrix',BeamSettings.ematrix); 
    assignin('base', 'ematrix',BeamSettings.ematrix)    
catch    
end

try
    mass=BeamSettings.mass;
    setappdata(0,'mass',mass); 
catch    
end

try
    stiff=BeamSettings.stiff;
    setappdata(0,'stiff',stiff); 
catch    
end

try
    fn=BeamSettings.fn;
    setappdata(0,'fn',fn); 
catch    
end

try
    ModeShapes=BeamSettings.ModeShapes;
    setappdata(0,'ModeShapes',ModeShapes); 
catch    
end

try
    setappdata(0,'ModeShapes_corrected',BeamSettings.ModeShapes_corrected); 
catch    
end

try
    setappdata(0,'ibc',BeamSettings.ibc); 
catch    
end

try
    pff=BeamSettings.pff;
    setappdata(0,'pff',BeamSettings.pff); 
catch    
end

try
    damp_Q=BeamSettings.damp_Q;
    setappdata(0,'damp_Q',damp_Q); 
catch    
end

try
    damp_ratio=BeamSettings.damp_ratio;
    setappdata(0,'damp_ratio',BeamSettings.damp_ratio); 
catch    
end

try
    emm=BeamSettings.emm;
    setappdata(0,'emm',emm); 
catch    
end

try
    ivector=BeamSettings.ivector;
    setappdata(0,'ivector',ivector); 
catch    
end

try
    setappdata(0,'nem',BeamSettings.nem); 
catch    
end

try
    setappdata(0,'TT',BeamSettings.TT); 
catch    
end

try
    setappdata(0,'T1',BeamSettings.T1); 
catch    
end

try
    setappdata(0,'T2',BeamSettings.T2); 
catch    
end

try
    setappdata(0,'Mwd',BeamSettings.Mwd); 
catch    
end

try
    Mww=BeamSettings.Mww;
    setappdata(0,'Mww',Mww); 
catch    
end

try
    setappdata(0,'Kwd',BeamSettings.Kwd); 
catch    
end

try
    Kww=BeamSettings.Kww;
    setappdata(0,'Kww',Kww); 
catch    
end

try
    setappdata(0,'TZ_tracking_array',BeamSettings.TZ_tracking_array); 
catch    
end

try
    setappdata(0,'tracking_array',BeamSettings.tracking_array); 
catch    
end

try
    setappdata(0,'free_dof_array',BeamSettings.free_dof_array); 
catch    
end

try
    setappdata(0,'part_fn',BeamSettings.part_fn); 
catch    
end

try
    setappdata(0,'part_omega',BeamSettings.part_omega); 
catch    
end

try
    setappdata(0,'part_ModeShapes',BeamSettings.part_ModeShapes); 
catch    
end

try
    setappdata(0,'ngw',BeamSettings.ngw); 
catch    
end

% % %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

update_bare_plate(hObject, eventdata, handles);
update_point_mass(hObject, eventdata, handles);
update_total_mass(hObject, eventdata, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

if(length(nx)>0 && length(ny)>0 && min(size(mass_unc))>0 && max(size(stiff_unc))>0)

    h=figure(fig_num);
    fig_num=fig_num+1;
    if(iu==1)
        plot(node_matrix(:,1),node_matrix(:,2),'.');
    else
        plot(1000*node_matrix(:,1),1000*node_matrix(:,2),'.');    
    end
    
 
%
    number_nodes=length(nodex);
    setappdata(0,'number_nodes',number_nodes);
    
    for i=1:number_nodes
        string=num2str(i,'%d\n');
        if(iu==1)
            text(nodex(i),nodey(i),string);
        else
            text(1000*nodex(i),1000*nodey(i),string);       
        end
    end

%
    if(iu==1)
        xlabel('X (in)');
        ylabel('Y (in)');
    else
        xlabel('X (mm)');
        ylabel('Y (mm)');    
    end
    title('Nodes & Elements');
    grid on;
%
    xmax=max(nodex)+dx/2;
    ymax=max(nodey)+dy/2;
%
    xmin=min(nodex)-dx/2;
    ymin=min(nodey)-dy/2;
%
    if(iu==1)
        axis([xmin,xmax,ymin,ymax]);
    else
        xxmin=xmin*1000;
        xxmax=xmax*1000;    
        yymin=ymin*1000;
        yymax=ymax*1000;       
        axis([xxmin,xxmax,yymin,yymax]);    
    end

%
    node1=element_matrix(:,1);
    node2=element_matrix(:,2);
    node3=element_matrix(:,3);
    node4=element_matrix(:,4);
%
    hold on;
%
    ne=length(node1);
    nelem=ne;
%
    for i=1:ne
        x=[ nodex(node1(i)) nodex(node2(i)) nodex(node3(i)) nodex(node4(i)) nodex(node1(i))];
        y=[ nodey(node1(i)) nodey(node2(i)) nodey(node3(i)) nodey(node4(i)) nodey(node1(i))];
 
        if(iu==1)
            plot(x,y);    
        else
            xx=1000*x;
            yy=1000*y;
            plot(xx,yy);        
        end
    end
    hold off;

%
    pname='nodes_elements.emf';        
    out1=sprintf('\n plot file:   %s \n',pname);
    disp(out1);
    
    set(gca,'Fontsize',12);
    print(h,pname,'-dmeta','-r300');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    point_mass_matrix=getappdata(0,'point_mass_matrix');
    sz=size(point_mass_matrix);

    if(sz(1)>=1)
        if(point_mass_matrix(1,1)>0)

            iu=getappdata(0,'iu');
            N=sz(1);

            node_matrix=getappdata(0,'node_matrix');


            dx=getappdata(0,'dx');
            dy=getappdata(0,'dy');

            fig_num=200;
            h=figure(fig_num);

            if(iu==1)
                plot(node_matrix(:,1),node_matrix(:,2),'.');
            else
                plot(1000*node_matrix(:,1),1000*node_matrix(:,2),'.');    
            end


%
            for i=1:N
                if(point_mass_matrix(i,1)>0) 
       
                    string=sprintf('%d %g',point_mass_matrix(i,1),point_mass_matrix(i,2));
  
                    p=point_mass_matrix(i,1);
                    if(iu==1)
                         text(nodex(p),nodey(p),string);
                    else  
                         text(1000*nodex(p),1000*nodey(p),string);                       
                    end

                end     
            end
            if(iu==1)
                title('Point Masses (node, lbm)');
                xlabel('X (in)');
                ylabel('Y (in)');
            else
                title('Point Masses (node, kg)');    
                xlabel('X (mm)');
                ylabel('Y (mm)');    
            end
            grid on;
%
            xmax=max(nodex)+dx/2;
            ymax=max(nodey)+dy/2;
%
            xmin=min(nodex)-dx/2;
            ymin=min(nodey)-dy/2;
%
            if(iu==1)
                axis([xmin,xmax,ymin,ymax]);
            else
                axis([1000*xmin,1000*xmax,1000*ymin,1000*ymax]);               
            end

            pname='point_mass.emf';        
            out1=sprintf('plot file:   %s',pname);
            disp(out1);
            set(gca,'Fontsize',12);
            print(h,pname,'-dmeta','-r300');    
    
        end
    end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    constraint_matrix=getappdata(0,'constraint_matrix');
        
    iu=getappdata(0,'iu');
 
    sz=size(constraint_matrix);
 
    N=sz(1);
 
    node_matrix=getappdata(0,'node_matrix');
 
    sz=size(node_matrix);
 
    if(max(sz)<=0)
        warndlg('node_matrix does not exist');
        return;
    end
 

    
    dx=getappdata(0,'dx');
    dy=getappdata(0,'dy');
 
    fig_num=100;
    h=figure(fig_num);
 
    if(iu==1)
        plot(node_matrix(:,1),node_matrix(:,2),'.');
    else
        plot(1000*node_matrix(:,1),1000*node_matrix(:,2),'.');    
    end
 
    title('Constraints (Tz,Rx,Ry)  0=free 1=constrained');
%
    clear nodex;
    clear nodey;
    nodex=node_matrix(:,1);
    nodey=node_matrix(:,2);
%

%
    for i=1:N
        if(constraint_matrix(i,1)>0) 
       
%%        string=sprintf('%d',constraint_matrix(i,1));
  
            string='';
 
            if(constraint_matrix(i,2)==1)        
                string=strcat(string,'1');
            else
                string=strcat(string,'0');            
            end
            if(constraint_matrix(i,3)==1)
                string=strcat(string,'1');
            else
                string=strcat(string,'0');                        
            end
            if(constraint_matrix(i,4)==1)
                string=strcat(string,'1');
            else
                string=strcat(string,'0');                        
            end     
        
            p=constraint_matrix(i,1);
        
            if(iu==1)
                text(nodex(p),nodey(p),string);
            else
                text(1000*nodex(p),1000*nodey(p),string);            
            end
        end     
    end
    if(iu==1)
        xlabel('X (in)');
        ylabel('Y (in)');
    else
        xlabel('X (mm)');
        ylabel('Y (mm)');    
    end
    grid on;

%
    xmax=max(nodex)+dx/2;
    ymax=max(nodey)+dy/2;
%
    xmin=min(nodex)-dx/2;
    ymin=min(nodey)-dy/2;
%
 
    if(iu==1)
        axis([xmin,xmax,ymin,ymax]);
    else
        xxmin=1000*xmin;
        xxmax=1000*xmax;
        yymin=1000*ymin;
        yymax=1000*ymax;    
        axis([xxmin,xxmax,yymin,yymax]);    
    end
    
    pname='constraints.emf';        
    out1=sprintf('plot file:   %s',pname);
    disp(out1);
    set(gca,'Fontsize',12);
    print(h,pname,'-dmeta','-r300');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    dof=number_nodes*3;
    setappdata(0,'dof',dof);
%
    disp(' Unconstrained model statistics ');
    out1=sprintf('\n  nodes=%d  elements=%d   degrees-of-freedom=%d  \n',number_nodes,nelem,dof);
    disp(out1);
    
   
    string_four(hObject, eventdata, handles);
    
    if(  isempty(icenter)==0 &&  isempty(ctdof)==0 )
        out1=sprintf('\n  Node nearest center = %d \n   with translational dof = %d \n',icenter,ctdof);
        disp(out1);
    end    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(isempty(fn)==0 && isempty(emm)==0)
   
%    mode=ModeShapes;
%    LM=mode'*mass*ivector;
    
%
    disp(' ');
    disp('                                        Effective            ');
    disp('           Natural     Participation    Modal Mass   Mass    ');
    
    if(iu==1)
        disp('Mode       Freq(Hz)       Factor          (lbm)      Percent ');
    else
        disp('Mode       Freq(Hz)       Factor          (kg)      Percent ');        
    end
%    
    kk=0;
    for i=1:length(emm)
        frac=100*emm(i)/total_mass;
        if(frac<0.0001)
            frac=0;
        end
         
        if(iu==1)
            out1 = sprintf('  %d \t %11.5g \t %9.5f \t %9.5f \t %7.3f',i,fn(i),pff(i),386*emm(i),386*frac);
        else
            out1 = sprintf('  %d \t %11.5g \t %9.5f \t %9.5f \t %7.3f',i,fn(i),pff(i),emm(i),frac);            
        end
        kk=kk+1;
        disp(out1)
        if(i==24)
            break;
        end
    end        
%
    disp(' ')
    
    sss=sum(emm(1:kk));
    
    if(iu==1)
        out1 = sprintf(' Total Effective Modal Mass = %10.4g lbf sec^2/in',sss );
        out2 = sprintf('                            = %10.4g lbm',sss*386 );
    else
        out1 = sprintf(' Total Effective Modal Mass = %10.4g kg',sss );        
    end
    
    
    disp(out1)
    if(iu==1)
        disp(out2)
    end    
    

    string_five(hObject, eventdata, handles);
    
    
    if(length(damp_Q)>=1 && length(damp_ratio)>=1)
        disp(' ');
        disp('Mode    fn     Q     Damping');
        disp('       (Hz)          Ratio');
 
        for i=1:length(damp_Q)
            out1=sprintf('%d  %8.4g  %6.3g  %6.3g',i,fn(i),damp_Q(i),damp_ratio(i));
            disp(out1);
        end
 
        setappdata(0,'damp_Q',damp_Q);
        setappdata(0,'damp_ratio',damp_ratio);    
        
        string_seven(hObject, eventdata, handles);
        
    end

    
    set(handles.uipanel_plot_modes,'Visible','on');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   sz=size(Mww);
   
   if(sz(1)>=2)
        
        string_twelve(hObject, eventdata, handles); 
        
   end
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


model_key=1;
setappdata(0,'model_key',model_key);

disp(' ');
disp('Load complete');
msgbox('Load Complete');

% --- Executes on button press in pushbutton_save_model.
function pushbutton_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    m=get(handles.listbox_mass_method,'Value');
    BeamSettings.mass_method=m;
end

try
    iu=get(handles.listbox_unit,'Value');
    BeamSettings.iu=iu;
end

try
    icenter=getappdata(0,'icenter');
    BeamSettings.icenter=icenter;
end

try
    ctdof=getappdata(0,'ctdof');
    BeamSettings.ctdof=ctdof;
end

try
    n=get(handles.listbox_material,'Value');
    BeamSettings.n=n;
end

try
    nx=str2num(get(handles.edit_nodes_length,'String'));
    BeamSettings.nx=nx;
end

try
    ny=str2num(get(handles.edit_nodes_width,'String'));
    BeamSettings.ny=ny;
end

try
    T=str2num(get(handles.edit_thickness,'String'));
    BeamSettings.T=T;
end

try
    L=str2num(get(handles.edit_length,'String'));
    BeamSettings.L=L;
end

try
    W=str2num(get(handles.edit_width,'String')); 
    BeamSettings.W=W;
end

try
    E=str2num(get(handles.edit_elastic_modulus,'String'));
    BeamSettings.E=E;
end

try
    rho=str2num(get(handles.edit_mass_density,'String'));
    BeamSettings.rho=rho;
end

try
    mu=str2num(get(handles.edit_poisson,'String'));
    BeamSettings.mu=mu;
end

try
    nm=get(handles.listbox_mass_method,'Value');
    BeamSettings.nm=nm;
end

try
    nsm=str2num(get(handles.edit_nsm,'String'));
    BeamSettings.nsm=nsm;
end

try
    total_mass=str2num(get(handles.edit_total_mass,'String'));
    BeamSettings.total_mass=total_mass;
end

try
    dx=getappdata(0,'dx');
    BeamSettings.dx=dx;
end

try
    dy=getappdata(0,'dy');
    BeamSettings.dy=dy;
end

try
    dof=getappdata(0,'dof')
    BeamSettings.dof=dof;
end

try
    number_nodes=getappdata(0,'number_nodes');
    BeamSettings.number_nodes=number_nodes;
end

try
    nodex=getappdata(0,'nodex');
    BeamSettings.nodex=nodex;
end

try
    nodey=getappdata(0,'nodey');
    BeamSettings.nodey=nodey;
end

try
    mass_unc=getappdata(0,'mass_unc');
    BeamSettings.mass_unc=mass_unc;
end

try
    stiff_unc=getappdata(0,'stiff_unc');
    BeamSettings.stiff_unc=stiff_unc;
end

try
    node_matrix=getappdata(0,'node_matrix');
    BeamSettings.node_matrix=node_matrix;
end

try
    element_matrix=getappdata(0,'element_matrix');
    BeamSettings.element_matrix=element_matrix;
end

try
    point_mass_matrix=getappdata(0,'point_mass_matrix');
    BeamSettings.point_mass_matrix=point_mass_matrix;
end

try
    constraint_matrix=getappdata(0,'constraint_matrix');
    BeamSettings.constraint_matrix=constraint_matrix;
end

try
    ematrix=getappdata(0,'ematrix');
    BeamSettings.ematrix=ematrix;
end

try
    mass=getappdata(0,'mass');
    BeamSettings.mass=mass;
end

try
    stiff=getappdata(0,'stiff');
    BeamSettings.stiff=stiff;
end

try
    fn=getappdata(0,'fn');
    BeamSettings.fn=fn;
end

try
    ModeShapes=getappdata(0,'ModeShapes');
    BeamSettings.ModeShapes=ModeShapes;
end

try
    ModeShapes_corrected=getappdata(0,'ModeShapes_corrected');
    BeamSettings.ModeShapes_corrected=ModeShapes_corrected;
end

try
    ibc=getappdata(0,'ibc');
    BeamSettings.ibc=ibc;
end

try
    pff=getappdata(0,'pff');
    BeamSettings.pff=pff;
end

try
    damp_Q=getappdata(0,'damp_Q');
    BeamSettings.damp_Q=damp_Q;
end

try
    damp_ratio=getappdata(0,'damp_ratio');
    BeamSettings.damp_ratio=damp_ratio;
end

try
    emm=getappdata(0,'emm');
    BeamSettings.emm=emm;
end

try
    ivector=getappdata(0,'ivector');
    BeamSettings.ivector=ivector;
end

try
    nem=getappdata(0,'nem');
    BeamSettings.nem=nem;
end

try
    TT=getappdata(0,'TT');
    BeamSettings.TT=TT;
end

try
    T1=getappdata(0,'T1');
    BeamSettings.T1=T1;
end

try
    T2=getappdata(0,'T2');
    BeamSettings.T2=T2;
end

try
    Mwd=getappdata(0,'Mwd');
    BeamSettings.Mwd=Mwd;
end

try
    Mww=getappdata(0,'Mww');
    BeamSettings.Mww=Mww;
end

try
    Kwd=getappdata(0,'Kwd');
    BeamSettings.Kwd=Kwd;
end

try
    Kww=getappdata(0,'Kww');
    BeamSettings.Kww=Kww;
end

try
    TZ_tracking_array=getappdata(0,'TZ_tracking_array');
    BeamSettings.TZ_tracking_array=TZ_tracking_array;
end

try
    tracking_array=getappdata(0,'tracking_array');
    BeamSettings.tracking_array=tracking_array;
end

try
    free_dof_array=getappdata(0,'free_dof_array');
    BeamSettings.free_dof_array=free_dof_array;
end

try
    part_fn=getappdata(0,'part_fn');
    BeamSettings.part_fn=part_fn;
end

try
    part_omega=getappdata(0,'part_omega');
    BeamSettings.part_omega=part_omega;
end

try
    part_ModeShapes=getappdata(0,'part_ModeShapes');
    BeamSettings.part_ModeShapes=part_ModeShapes;
end

try
    ngw=getappdata(0,'ngw');
    BeamSettings.ngw=ngw;
end    

% % %

structnames = fieldnames(BeamSettings, '-full'); % fields in the struct

% % %

   [writefname, writepname] = uiputfile('*.mat','Save data as');

   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    try
 
        save(elk, 'BeamSettings'); 
 
    catch
        warndlg('Save error');
        return;
    end
 


% Construct a questdlg with two options
choice = questdlg('Save Complete.  Reset Workspace?', ...
	'Options', ...
	'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        disp([choice ' Reseting'])
        pushbutton_reset_Callback(hObject, eventdata, handles)
end  



function reset_all(hObject, eventdata, handles) 

string_one(hObject, eventdata, handles);


set(handles.edit_length,'String','');
set(handles.edit_width,'String','');
set(handles.edit_thickness,'String','');

set(handles.listbox_step,'String',' '); 


% set(handles.listbox_material,'Value',1);
listbox_material_Callback(hObject, eventdata, handles);

set(handles.listbox_mass_method,'Value',1);
listbox_mass_method_Callback(hObject, eventdata, handles);

setappdata(0,'icenter','');
setappdata(0,'ctdof','');
setappdata(0,'dx','');
setappdata(0,'dy','');
setappdata(0,'dof','');
setappdata(0,'number_nodes','');
setappdata(0,'nodex','');
setappdata(0,'nodey','');
setappdata(0,'mass_unc','');
setappdata(0,'stiff_unc','');
setappdata(0,'node_matrix','');
setappdata(0,'element_matrix','');
setappdata(0,'fn',''); 
setappdata(0,'ModeShapes','');  
setappdata(0,'ModeShapes_corrected','');  
setappdata(0,'ibc','');  
setappdata(0,'pff','');   
setappdata(0,'emm','');
setappdata(0,'ivector','');

setappdata(0,'damp_Q','');
setappdata(0,'damp_ratio','');  

setappdata(0,'nem','');
setappdata(0,'TT','');
setappdata(0,'T1','');
setappdata(0,'T2','');
 
setappdata(0,'Mwd','');
setappdata(0,'Mww','');
setappdata(0,'Kwd','');
setappdata(0,'Kww','');
 
 
setappdata(0,'TZ_tracking_array',''); 
 
setappdata(0,'tracking_array',''); 
setappdata(0,'free_dof_array',''); 
 
setappdata(0,'part_fn','');
setappdata(0,'part_omega','');
setappdata(0,'part_ModeShapes','');
setappdata(0,'ngw','');

setappdata(0,'constraint_matrix_added','');


assignin('base', 'constraint_matrix','');
assignin('base', 'point_mass_matrix','');
assignin('base', 'ematrix','');
assignin('base', 'mass','');
assignin('base', 'stiff','');

set(handles.edit_model_name,'String','');


set(handles.edit_bare_plate_mass,'String','0');
set(handles.edit_nsm,'String','0');
set(handles.edit_point_mass,'String','0');
set(handles.edit_total_mass,'String','0');





% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


reset_all(hObject, eventdata, handles);

msgbox('Reset Complete');



function edit_model_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_model_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_model_name as text
%        str2double(get(hObject,'String')) returns contents of edit_model_name as a double


% --- Executes during object creation, after setting all properties.
function edit_model_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_model_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bare_plate_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bare_plate_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bare_plate_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_bare_plate_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_bare_plate_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bare_plate_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_point_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_point_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_point_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_point_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_point_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_point_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_mdof_srs.
function pushbutton_mdof_srs_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mdof_srs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=plate_mdof_srs;     
set(handles.s,'Visible','on');


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_step.
function listbox_step_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_step contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_step


% --- Executes during object creation, after setting all properties.
function listbox_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function string_one(hObject, eventdata, handles)

    set(handles.listbox_step,'String',' '); 

    string_th{1}='Generate Unconstrained Model';

    set(handles.listbox_step,'String',string_th,'Value',1);
        

function string_four(hObject, eventdata, handles)

    set(handles.listbox_step,'String',' '); 

    string_th{1}='Generate Unconstrained Model';
    string_th{2}='Add Point Mass';
    string_th{3}='Specify Constraints';
    string_th{4}='Calculate fn';    
    
    set(handles.listbox_step,'String',string_th,'Value',1); 
    
    
function string_five(hObject, eventdata, handles)

    set(handles.listbox_step,'String',' '); 

    string_th{1}='Generate Unconstrained Model';
    string_th{2}='Add Point Mass';
    string_th{3}='Specify Constraints';
    string_th{4}='Calculate fn';    
    string_th{5}='Add Damping';
    
    set(handles.listbox_step,'String',string_th,'Value',1);     


function string_seven(hObject, eventdata, handles)

    set(handles.listbox_step,'String',' '); 

    string_th{1}='Generate Unconstrained Model';
    string_th{2}='Add Point Mass';
    string_th{3}='Specify Constraints';
    string_th{4}='Calculate fn';    
    string_th{5}='Add Damping';
    string_th{6}='Uniform, Fully Correlated Pressure, Transfer Function';
    string_th{7}='Partition Matrices for Base Excitation';    
    
    set(handles.listbox_step,'String',string_th,'Value',1);  
    
function string_twelve(hObject, eventdata, handles)   
    
    set(handles.listbox_step,'String',' '); 

    string_th{1}='Generate Unconstrained Model';
    string_th{2}='Add Point Mass';
    string_th{3}='Specify Constraints';
    string_th{4}='Calculate fn';    
    string_th{5}='Add Damping';
    string_th{6}='Uniform, Fully Correlated Pressure, Transfer Function';
    string_th{7}='Partition Matrices for Base Excitation';   
    string_th{8}='Transmissibility';
    string_th{9}='Sine Base Input';
    string_th{10}='PSD Base Input';
    string_th{11}='Arbitrary Time History Base Input';
    string_th{12}='MDOF SRS';    
    
    set(handles.listbox_step,'String',string_th,'Value',1);  
    
    
% --- Executes on button press in pushbutton_perform.
function pushbutton_perform_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_perform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_step,'Value');

if(n==1)
    step_generate_mesh(hObject, eventdata, handles);
    
    string_four(hObject, eventdata, handles);
    
end
if(n==2)
    step_point_mass(hObject, eventdata, handles);
end
if(n==3)
    step_constraints(hObject, eventdata, handles); 
end
if(n==4)
    step_calculate_fn(hObject, eventdata, handles);
    
    string_five(hObject, eventdata, handles);
    
end
if(n==5)
   step_damping(hObject, eventdata, handles);
   
   string_seven(hObject, eventdata, handles);
   
end
if(n==6)
  
    handles.s=plate_fea_uniform_pressure_transfer;     
    set(handles.s,'Visible','on'); 
   
end
if(n==7)
   step_partition_Callback(hObject, eventdata, handles); 
   
   string_twelve(hObject, eventdata, handles); 
end

if(n==8)
    handles.s=plate_fea_transmissibility;     
    set(handles.s,'Visible','on');  
end  
if(n==9)
    handles.s=plate_fea_sine;     
    set(handles.s,'Visible','on');  
end 
if(n==10)
    handles.s=plate_fea_psd;     
    set(handles.s,'Visible','on'); 
end 
if(n==11)
    handles.s=plate_fea_arbitrary;     
    set(handles.s,'Visible','on');    
end 
if(n==12)
    handles.s=plate_mdof_srs;     
    set(handles.s,'Visible','on');    
end 




function step_apply_uniform_SPL(hObject, eventdata, handles)
%
