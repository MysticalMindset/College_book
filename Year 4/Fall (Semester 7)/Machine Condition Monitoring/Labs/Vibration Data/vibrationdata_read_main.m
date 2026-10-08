function varargout = vibrationdata_read_main(varargin)
% VIBRATIONDATA_READ_MAIN MATLAB code for vibrationdata_read_main.fig
%      VIBRATIONDATA_READ_MAIN, by itself, creates a new VIBRATIONDATA_READ_MAIN or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_READ_MAIN returns the handle to a new VIBRATIONDATA_READ_MAIN or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_READ_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_READ_MAIN.M with the given input arguments.
%
%      VIBRATIONDATA_READ_MAIN('Property','Value',...) creates a new VIBRATIONDATA_READ_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_read_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_read_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_read_main

% Last Modified by GUIDE v2.5 10-May-2018 11:31:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_read_main_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_read_main_OutputFcn, ...
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


% --- Executes just before vibrationdata_read_main is made visible.
function vibrationdata_read_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_read_main (see VARARGIN)

% Choose default command line output for vibrationdata_read_main
handles.output = hObject;

set(handles.listbox_type,'Value',1);

listbox_type_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_read_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_read_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_read_main);

% --- Executes on button press in pushbutton_Load.
function pushbutton_Load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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

msgbox('Load complete');

% --- Executes on button press in pushbutton_select_input.
function pushbutton_select_input_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=vibrationdata_read_ascii_text;    
set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

set(handles.listbox_array, 'String', '');

n=get(handles.listbox_type,'Value');

if(n==1) % Acceleration Time History

    string_th{1}=sprintf('SRS 2000G Acceleration');
    string_th{2}=sprintf('SRS 1000G Acceleration');
    string_th{3}=sprintf('Re-entry Vehicle Separation, LSC, Raw');
    string_th{4}=sprintf('Re-entry Vehicle Separation, LSC, Cleaned');    
    string_th{5}=sprintf('Flight Accelerometer Data, Suborbital Launch Vehicle');
    string_th{6}=sprintf('Solid Rocket Motor, Resonant Burn, Flight Data');
    string_th{7}=sprintf('Channel Beam');
    string_th{8}=sprintf('Drop Transient, Launch Vehicle');
    string_th{9}=sprintf('Space Shuttle SRB FWD IEA Slashdown');
    string_th{10}=sprintf('Flight Stage Separation Shock');
    string_th{11}=sprintf('Taurus Auto');  
    string_th{12}=sprintf('Complex Oscillating Pulse');  
    string_th{13}=sprintf('NASA HDBK 7005 Mid-Field Pyrotechnic Shock');  
    m=13;
end
if(n==2) % Acoustic Time History    
    
    string_th{1}=sprintf('Tuning Fork');
    string_th{2}=sprintf('Transformer Magnetostriction');
    string_th{3}=sprintf('Q400 Turboprop Aircraft');
    string_th{4}=sprintf('Apache Helicopter Flyover');  
    string_th{5}=sprintf('Hoover Dam Turbine Generators');  
    string_th{6}=sprintf('Launch Abort System Pad One Test');     
    m=6;
end
if(n==3) % Earthquake Time History
    
    string_th{1}=sprintf('El Centro earthquake NS');
    string_th{2}=sprintf('El Centro earthquake EW');
    string_th{3}=sprintf('El Centro earthquake UP');
    string_th{4}=sprintf('El Centro earthquake Triaxial');  
    string_th{5}=sprintf('Solomon Island earthquake');   
    string_th{6}=sprintf('GR-63-Core Zone 4 Synthesis');    
    m=6;
end
if(n==4) % Stress Time History
    
    string_th{1}=sprintf('ASTM E 1049 85 - Rainflow Stress');
    m=1;
end
if(n==5) % PSD

    string_th{1}=sprintf('NAVMAT PSD Specification');
    string_th{2}=sprintf('MIL-STD-1540B ATP PSD Specification');
    string_th{3}=sprintf('Aircraft External Fuselage Pressure PSD in Flight');
    string_th{4}=sprintf('HALT PSD Sample');
    string_th{5}=sprintf('Flight Data Sample');
    string_th{6}=sprintf('Test Spec Sample');   
    string_th{7}=sprintf('Suborbital Vehicle Bulkhead Flight Data'); 
    string_th{8}=sprintf('Saturn V Honeycomb Sandwich Test Data');  
    string_th{9}=sprintf('NASA/TM-2009-215902 Saturn V PSDs');   
    m=9;
end
if(n==6) % SPL

    string_th{1}=sprintf('MIL-STD-1540C SPL, Acceptance');
    string_th{2}=sprintf('Launch Vehicle Avionics Module Liftoff SPL');
    string_th{3}=sprintf('Saturn V Reference, One-Third Octave');
    string_th{4}=sprintf('P31'); 
    string_th{5}=sprintf('P32');    
    m=5;
end
if(n==7) % SRS
    string_th{1}=sprintf('MIL-STD-810G Crash Hazard');
    string_th{2}=sprintf('Vandenberg AFB 1%% Damping');
    string_th{3}=sprintf('Harris 2%% Damping');
    string_th{4}=sprintf('IEEE std 693 RSS, Various');
    string_th{5}=sprintf('GR-63 Core Zone 4');    
    string_th{6}=sprintf('GR-63 Core Zone 3');    
    string_th{7}=sprintf('GR-63 Core Zones 1 & 2');    
    string_th{8}=sprintf('ANSI C37.98 Normalized');     
    string_th{9}=sprintf('Frangible Joint Source Shock, 26 grains/ft');
    string_th{10}=sprintf('NASA LSC Source Shock, 30 grains/ft');   
    m=10;
end
if(n==8) % Wavelet Table
    string_th{1}=sprintf('wavelet_2k');
    string_th{2}=sprintf('wavelet_11k');
    m=2;
end
if(n==9) % Sound Files
    string_th{1}=sprintf('Apache Helicopter Flyover');
    string_th{2}=sprintf('Sine Sweep');    
    string_th{3}=sprintf('Transformer Hum');
    string_th{4}=sprintf('Tuning Fork');  
    m=3;
end

set(handles.listbox_array, 'Value', m);   % do not change
set(handles.listbox_array,'Value',1);
set(handles.listbox_array,'String',string_th)


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_array.
function listbox_array_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_array contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_array


% --- Executes during object creation, after setting all properties.
function listbox_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * ');
disp(' ');

fig_num=200;

p=get(handles.listbox_type,'Value');
n=get(handles.listbox_array,'Value');

%% out1=sprintf('\n p=%d n=%d \n',p,n);
%% disp(out1);

iflag=0;


if(p==1) % Acceleration Time History
 
    xlab='Time (sec)';
    ylab='Accel (G)';
    
    if(n==1)
        load('srs2000G_accel.txt');
        aa=srs2000G_accel;
        
        out1=sprintf('Array Name: srs2000G_accel    units: time(sec) & accel(G)');    
        output_name='srs2000G_accel';
        assignin('base', output_name, srs2000G_accel);   
        ttt='SRS 2000G Acceleration';
    end
    if(n==2)
        load('srs1000G_accel.txt');
        aa=srs1000G_accel;
        
        out1=sprintf('Array Name: srs1000G_accel    units: time(sec) & accel(G)');
        output_name='srs1000G_accel';
        assignin('base', output_name, srs1000G_accel);
        ttt='SRS 1000G Acceleration';
    
    end
    if(n==3)
        load('rv_separation_raw.txt');
        aa=rv_separation_raw;
        
        out1=sprintf('Array Name:  rv_separation_raw    units: time(sec) & accel(G)');
    
        output_name='rv_separation_raw';
        assignin('base', output_name, rv_separation_raw);  
        ttt='Re-entry Vehicle Separation, LSC, Raw Data';
    end
    if(n==4)
        load('rv_separation_cleaned.txt');
        aa=rv_separation_cleaned;
        
        out1=sprintf('Array Name:  rv_separation_cleaned    units: time(sec) & accel(G)');
    
        output_name='rv_separation_cleaned';
        assignin('base', output_name, rv_separation_cleaned);  
        ttt='Re-entry Vehicle Separation, LSC, Cleaned Data';
    end    
    if(n==5)
        load('flight_accel_data.txt');
        aa=flight_accel_data;
        
        out1=sprintf('Array Name:  flight_accel_data    units: time(sec) & accel(G)');
    
        output_name='flight_accel_data';
        assignin('base', output_name, flight_accel_data);  
        ttt='Flight Accelerometer Data, Suborbital Launch Vehicle';
    end
    if(n==6)
        load('solid_motor.dat'); 
        aa=solid_motor;
        
        out1=sprintf('Array Name:  solid_motor    units: time(sec) & accel(G)');
    
        output_name='solid_motor';
        assignin('base', output_name, solid_motor);  
        ttt='Solid Rocket Motor, Resonant Burn, Flight Data';
    end
    if(n==7)
        load('channel.txt');
        aa=channel;
        
        out1=sprintf('Array Name:  channel    units: time(sec) & accel(G)');
    
        output_name='channel';
        assignin('base', output_name, channel);
        ttt='Channel Beam';
    end    
    if(n==8)
        load('drop.txt');
        aa=drop;
        
        out1=sprintf('Array Name:  drop    units: time(sec) & accel(G)');
    
        output_name='drop';
        assignin('base', output_name, drop);
        ttt='Drop Transient, Launch Vehicle';
    end    
    if(n==9)
        load('srb_iea.txt');
        aa=srb_iea;
        
        out1=sprintf('Array Name:  srb_iea   units: time(sec) & accel(G)');
    
        output_name='srb_iea';
        assignin('base', output_name, srb_iea);
        ttt='Space Shuttle SRB FWD IEA Slashdown';
    end    

    if(n==10)
        load('flight_stage_sep.txt');
        aa=flight_stage_sep;
        
        out1=sprintf('Array Name:  flight_stage_sep   units: time(sec) & accel(G)');
    
        output_name='flight_stage_sep';
        assignin('base', output_name, flight_stage_sep); 
        ttt='Flight Stage Separation Shock, Suborbital Vehicle';
    end      
    if(n==11)
        load('Taurus_auto.dat');
        aa=Taurus_auto;
        
        out1=sprintf('Array Name:  Taurus_auto   units: time(sec) & accel(G)');
    
        output_name='Taurus_auto';
        assignin('base', output_name, Taurus_auto); 
        ttt='Taurus Auto Console 65 mph';
    end  
    if(n==12)
        load('complex_pulse.txt');
        aa=complex_pulse;
        
        out1=sprintf('Array Name:  complex_pulse   units: time(sec) & accel(G)');
    
        output_name='complex_pulse';
        assignin('base', output_name, complex_pulse); 
        ttt='Complex Oscillating Pulse';
    end      
    if(n==13)
        load('midfield_shock.txt');
        aa=midfield_shock;
        
        out1=sprintf('Array Name:  midfield_shock   units: time(sec) & accel(G)');
    
        output_name='midfield_shock';
        assignin('base', output_name, midfield_shock); 
        ttt='NASA HDBK 7005  Mid-Field Pyrotechnic Shock';
    end  

    figure(1);
    plot(aa(:,1),aa(:,2),'b');
    grid on;
    xlabel(xlab);
    ylabel(ylab);
    title(ttt);
    
    if(n==1)
        openfig('srs2000G_synthesized.fig');
    end 
end
if(p==2) % Acoustic Time History    
    if(n==1)
        load('tuning_fork.txt');
        aa=tuning_fork;
        ttt='Tuning Fork';
        
        out1=sprintf('Array Name:  tuning_fork   units: time(sec) & unscaled sound pressure');
    
        output_name='tuning_fork';
        assignin('base', output_name, tuning_fork);      
    end    
    if(n==2)
        load('transformer.txt');
        aa=transformer;
        ttt='Transformer Magnetostriction';
        
        out1=sprintf('Array Name:  transformer   units: time(sec) & unscaled sound pressure');
    
        output_name='transformer';
        assignin('base', output_name, transformer);      
    end   
    if(n==3)
        load('Q400.mat');
        aa=Q400;
        ttt='Q400 Turboprop Aircraft';
        
        out1=sprintf('Array Name:  Q400   units: time(sec) & unscaled sound pressure');
       
        output_name='Q400';
        assignin('base', output_name, Q400);  
    
    end   
 %%   
    if(n==4)
        load('apache.mat');
        aa=apache;
        ttt='Apache Helicopter Flyover';
        
        out1=sprintf('Array Name:  apache   units: time(sec) & unscaled sound pressure');
    
        output_name='apache';
        assignin('base', output_name, apache);      
    end  
    
    if(n==5)  
        load('Hoover_dam.mat');
        aa=Hoover_dam;
        ttt='Hoover Dam Generators';
        
        out1=sprintf('Array Name:  Hoover_dam   units: time(sec) & unscaled sound pressure');
    
        output_name='Hoover_dam';
        assignin('base', output_name, Hoover_dam);      
    end  
    if(n==6)
        load('LS009v_sm.txt');
        aa=LS009v_sm;
        ttt='LAS Pad One Test LS009v';
        
        out1=sprintf('Array Name:  LS009v_sm   units: time(sec) & sound pressure (psi)');
    
        output_name='LS009v_sm';
        assignin('base', output_name, LS009v_sm);      
    end      
    
 %%   
    figure(1);
    plot(aa(:,1),aa(:,2));
    grid on;
    xlabel('Time (sec)');
    if(n<=5)
        ylabel('Unscaled Sound Pressure');
    else
         ylabel('Sound Pressure (psi)');       
    end
    title(ttt);    
    
end
if(p==3) % Earthquake Time History
    
    xlab='Time (sec)';
    ylab='Accel (G)';
    
    if(n==1)
        load('elcentro_NS.dat');
        aa=elcentro_NS;
        ttt='El Centro NS';
        
        out1=sprintf('Array Name:  elcentro_NS   units: time(sec) & accel(G)');
    
        output_name='elcentro_NS';
        assignin('base', output_name, elcentro_NS);      
    end  
    if(n==2)
        load('elcentro_EW.dat');
        aa=elcentro_EW;
        ttt='El Centro EW';
        
        out1=sprintf('Array Name:  elcentro_EW   units: time(sec) & accel(G)');
    
        output_name='elcentro_EW';
        assignin('base', output_name, elcentro_EW);      
    end       
    if(n==3)
        load('elcentro_UP.dat');
        aa=elcentro_UP;
        ttt='El Centro UP';
        
        out1=sprintf('Array Name:  elcentro_UP   units: time(sec) & accel(G)');
    
        output_name='elcentro_UP';
        assignin('base', output_name, elcentro_UP);      
    end             
    if(n==4)
        load('elcentro_triaxial.dat');
        aa=elcentro_triaxial;
        ttt='elcentro_triaxial';
        
        out1=sprintf('Array Name:  elcentro_triaxial: NS,EW,UP \n  units: time(sec), accel(G), accel(G), accel(G)');
    
        output_name='elcentro_triaxial';
        assignin('base', output_name, elcentro_triaxial);   
        
        
        figure(1);
        
        subplot(3,1,1);
        plot(aa(:,1),aa(:,2));
        title('El Centro NS, EW, UP');
        ylabel(ylab);
        grid on;
        
        subplot(3,1,2);   
        plot(aa(:,1),aa(:,3));
        ylabel(ylab);         
        grid on;
        
        subplot(3,1,3);    
        plot(aa(:,1),aa(:,4));
        ylabel(ylab);       
        grid on;
        
        xlabel(xlab);
        
    end    
    
    if(n==5)
        load('solomon.txt');
        aa=solomon;
        ttt='Solomon Island Earthquake 2004';
        
        out1=sprintf('Array Name:  solomon   units: time(sec) & unscaled relative displacement');
    
        output_name='solomon';
        assignin('base', output_name, solomon);
        ylab='Unscaled Relative Displacement';
    end        
    if(n==6)
         
        try
            load('zone4_acceleration.txt');
            aa=zone4_acceleration;
        catch
            warndlg('load zone4_acceleration.txt failed');
            return; 
        end
        
        ttt='GR 63 Zone 4 Synthesis  2% Damping';
        
        out1=sprintf('Array Name:  zone4_acceleration   units: time(sec) & accel(G)');
        disp(out1);
        
        output_name='zone4_acceleration';
        assignin('base', output_name, zone4_acceleration);
        ylab='Accel (G)';
        
        load('zone4_SRS.txt');
        
        out1=sprintf('Array Name:  zone4_SRS   units: fn(Hz) & peak accel(G)');
        disp(out1);    
        
        output_name='zone4_SRS';
        assignin('base', output_name, zone4_SRS);
        
%%%%%        
        
        GR63_zone4=[0.3	0.2;
               0.6	2.0;
               2.0	5.0;
               5.0   5.0;
              15.0	1.6;
              50.0	1.6];        
        
        assignin('base', 'GR63_zone4', GR63_zone4 ); 
        out1=sprintf('Array Name: GR63_zone4    units: fn(Hz) & peak accel(G)');             
    end    
    
    
    if(n~=4)
        figure(1);
        
        try
            plot(aa(:,1),aa(:,2));        
        catch
            warndlg(' aa not found ');
            return;
        end
        
        grid on;
        xlabel(xlab);
        ylabel(ylab);
        title(ttt);       
        
        if(n==6)
            
            fn=zone4_SRS(:,1);
            a_pos=zone4_SRS(:,2);
            a_neg=zone4_SRS(:,3);
            
            srs_spec=GR63_zone4;
            
            y_lab='Accel (G)';

            
            fmin=0.3;
            fmax=50;
            t_string='SRS GR63 Zone 4 Synthesis  2% damping';  
  
            
            fig_num=2;
            tol=1.5;
                       
            [fig_num,h]=...
                srs_plot_function_spec_h(fig_num,fn,a_pos,a_neg,t_string,y_lab,fmin,fmax,srs_spec,tol);           
            
        end
        
    end    

    
end
if(p==4) % Stress Time History
    if(n==1)
        load('ASTM_test.txt');
        aa=ASTM_test;
        
        out1=sprintf('Array Name:  ASTM_test   units: time(sec) & stress');
    
        output_name='ASTM_test';
        assignin('base', output_name, ASTM_test); 
        xlab='Time';
        ylab='Stress';
        ttt='ASTM E 1049 85 - Rainflow Stress';
    end
    
    figure(1);
    plot(aa(:,1),aa(:,2));
    grid on;
    xlabel(xlab);
    ylabel(ylab);
    title(ttt);     
end    
if(p==5) % PSD 
    
    x_label='Frequency (Hz)';
    y_label='Accel (G^2/Hz)';
    
    if(n==1)
        load('navmat_spec.psd');
        out1=sprintf('Array Name: navmat_spec    units: freq(Hz) & G^2/Hz');
        ttt='NAVMAT PSD Specification  6.06 GRMS';
        ppp=navmat_spec;
        output_name='navmat_spec';
        assignin('base', output_name, navmat_spec);
        fmin=20;
        fmax=2000;
        [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);

    end
    if(n==2)
        load('mil_std_1540b.psd');         
        out1=sprintf('Array Name: mil_std_1540b    units: freq(Hz) & G^2/Hz');
        ttt='MIL-STD-1540B ATP PSD  6.14 GRMS';
        ppp=mil_std_1540b;
        output_name='mil_std_1540b';
        assignin('base', output_name, mil_std_1540b);   
        fmin=20;
        fmax=2000;
        [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);        
  
    end
    if(n==3)
        iflag=1;  
        handles.s= vibrationdata_aircraft_fuselage_psd;                  
        set(handles.s,'Visible','on')
        
    end
    if(n==4)
        load('HALT_psd.txt');
        out1=sprintf('Array Name: HALT_psd    units: freq(Hz) & G^2/Hz');
        ttt='HALT PSD Sample  16.9 GRMS';
        ppp=HALT_psd;        
        output_name='HALT_psd';
        assignin('base', output_name, HALT_psd); 
        fmin=10;
        fmax=10000;
        [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);        
   
    end    
    if(n==5)
        load('flight_data.psd');
        out1=sprintf('Array Name: flight_data    units: freq(Hz) & G^2/Hz');
        ttt='Flight Data  2.9 GRMS';
        ppp=flight_data;        
        output_name='flight_data';
        assignin('base', output_name, flight_data); 
        fmin=20;
        fmax=2000;
        [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);        
   
    end 
    if(n==6)
        load('test_spec.psd');
        out1=sprintf('Array Name: test_spec    units: freq(Hz) & G^2/Hz');
        ttt='Test Spec  7.8 GRMS';
        ppp=test_spec;        
        output_name='test_spec';
        assignin('base', output_name, test_spec); 
        fmin=20;
        fmax=2000;
        [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);        
   
    end     
    if(n==7)
        load('sub_bulkhead.txt');
        out1=sprintf('Array Name: sub_bulkhead    units: freq(Hz) & G^2/Hz');
        ttt='Suborbital Vehicle Bulkhead  5.93 GRMS';
        ppp=sub_bulkhead;        
        output_name='sub_bulkhead';
        assignin('base', output_name, sub_bulkhead); 
        fmin=20;
        fmax=2000;
        [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);        
   
    end     
    if(n==8)
        load('saturn_v_honeycomb_psd.txt');
        out1=sprintf('Array Name: saturn_v_honeycomb_psd    units: freq(Hz) & G^2/Hz');
        ttt=sprintf('Saturn V Honeycomb Sandwich Test \n One-Third Octave PSD  66.9 GRMS');
        ppp=saturn_v_honeycomb_psd;        
        output_name='saturn_v_honeycomb_psd';
        assignin('base', output_name, saturn_v_honeycomb_psd); 
        fmin=20;
        fmax=2000;
        [fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label,ttt,ppp,fmin,fmax);        
   
    end      
    if(n==9)
        
        NAME='Saturn_V_data.mat';

        struct=load(NAME);
        structnames = fieldnames(struct, '-full'); % fields in the struct

        k=length(structnames);

        for i=1:k
            namevar=strcat('struct.',structnames{i});
            value=eval(namevar);
            assignin('base',structnames{i},value);
            disp(structnames{i})
        end
        
        out1='PSD arrays loaded to Workspace.  Names fxx, where xx is figure number in NASA/TM-2009-215902';
    end      
end
if(p==6) % SPL
    if(n==1)
        load('mil_std_1540c_spl.txt');
        output_name='m1540_spl';
        assignin('base', output_name, mil_std_1540c_spl );      

        n_type=1;
    
        f=mil_std_1540c_spl(:,1);
        dB=mil_std_1540c_spl(:,2);
    
        [~]=spl_plot(fig_num,n_type,f,dB);
    
        out1='Array Name: m1540_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
    
    end  
    if(n==2)
        load('avionics_module_liftoff_spl.txt');
        output_name='avionics_module_liftoff_spl';
        assignin('base', output_name, avionics_module_liftoff_spl );      

        n_type=1;
    
        f=avionics_module_liftoff_spl(:,1);
        dB=avionics_module_liftoff_spl(:,2);
    
        [~]=spl_plot(fig_num,n_type,f,dB);
    
        out1='Array Name: avionics_module_liftoff_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
    
    end 

    if(n==3)  
        load('saturn_v_reference_spl.txt');
        output_name='saturn_v_reference_spl';
        assignin('base', output_name, saturn_v_reference_spl );      

        n_type=1;
    
        f=saturn_v_reference_spl(:,1);
        dB=saturn_v_reference_spl(:,2);
    
        [~]=spl_plot(fig_num,n_type,f,dB);
        
        disp('  ');
        disp(' Saturn V (NASA/TM—2009–215902) ');
        disp('  ');    
        
        out1='Array Name: saturn_v_reference_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
    
    end      
    
    if(n==4)  
        load('p31_liftoff_spl.txt');
        output_name='p31_liftoff_spl';
        assignin('base', output_name, p31_liftoff_spl );      
 
        n_type=1;
    
        f=p31_liftoff_spl(:,1);
        dB=p31_liftoff_spl(:,2);
    
        [~]=spl_plot(fig_num,n_type,f,dB);
    
        out1='Array Name: p31_liftoff_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
    
    end  
    if(n==5)  
        load('p32_liftoff_spl.txt');
        output_name='p32_liftoff_spl';
        assignin('base', output_name, p32_liftoff_spl );      
 
        n_type=1;
    
        f=p32_liftoff_spl(:,1);
        dB=p32_liftoff_spl(:,2);
    
        [~]=spl_plot(fig_num,n_type,f,dB);
    
        out1='Array Name: p32_liftoff_spl    units: f(Hz) & SPL(dB) ref: 20 micro Pa';
    
    end     
    
   
    
    
end
if(p==7) % SRS
    if(n==1)
        load('crash_srs.txt');
    
        output_name='crash_srs';
        assignin('base', output_name, crash_srs );
    
        fn=crash_srs(:,1);
        accel=crash_srs(:,2);
        y_lab='Accel (G)';
        fmin=10;
        fmax=2000;
        t_string='SRS Crash Hazard Q=10';
%
        [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);
    
        out1=sprintf('Array Name: crash_srs    units: fn(Hz) & peak accel(G)');   
    
    end
    if(n==2)
    
        load('vafb_1p.txt');  
        
        output_name='vafb_1p';
        assignin('base', output_name, vafb_1p ); 
    
    
        fn=vafb_1p(:,1);
        accel=vafb_1p(:,2);
        y_lab='Accel (G)';
        fmin=0.1;
        fmax=100;
        t_string='SRS VAFB  1% damping';    
        [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);    
    
        out1=sprintf('Array Name: vafb_1p    units: fn(Hz) & peak accel(G)');    
    
    end
    if(n==3)
    
        load('Harris_2p.txt');  
        
        output_name='Harris_2p';
        assignin('base', output_name, Harris_2p );    
    
        fn=Harris_2p(:,1);
        accel=Harris_2p(:,2);
        y_lab='Accel (G)';
        fmin=0.1;
        fmax=100;
        t_string='SRS Harris  2% damping';    
        [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
    
        out1=sprintf('Array Name: Harris_2p    units: fn(Hz) & peak accel(G)');    
    
    end
    if(n==4)
        
        iflag=1;
        handles.s=IEEE_RSS;    
        set(handles.s,'Visible','on');
    
    end
    
   
    
    if(n==5)    
        
        GR63_zone4=[0.3	0.2;
               0.6	2.0;
               2.0	5.0;
               5.0   5.0;
              15.0	1.6;
              50.0	1.6];        
        
        assignin('base', 'GR63_zone4', GR63_zone4 ); 
    
        fn=GR63_zone4(:,1);
        accel=GR63_zone4(:,2);
        y_lab='Accel (G)';
        fmin=0.3;
        fmax=50;
        t_string='SRS GR63 Zone 4  2% damping';    
        [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
    
        out1=sprintf('Array Name: GR63_zone4    units: fn(Hz) & peak accel(G)');        
    
    end
    if(n==6)
        
        
        GR63_zone3=[0.3	0.2;
                    0.6	2.0;
                    1.0	3.0;
                    5.0 3.0;
                    15.0 1.0;
                    50.0 1.0];

                
        assignin('base', 'GR63_zone3', GR63_zone3 ); 
                   
                
        fn=GR63_zone3(:,1);
        accel=GR63_zone3(:,2);
        y_lab='Accel (G)';
        fmin=0.3;
        fmax=50;
        t_string='SRS GR63 Zone 3  2% damping';    
        [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
    
        out1=sprintf('Array Name: GR63_zone3    units: fn(Hz) & peak accel(G)');  
                
                
    end
    if(n==7)
   
        GR63_zone1_2=[ 0.3	0.2;
                       0.6	2.0;
                       5.0   2.0;
                       15.0	0.6;
                       50.0	0.6];           
        
        assignin('base', 'GR63_zone1_2', GR63_zone1_2 ); 
               
                   
                   
        fn=GR63_zone1_2(:,1);
        accel=GR63_zone1_2(:,2);
        y_lab='Accel (G)';
        fmin=0.3;
        fmax=50;
        t_string='SRS GR63 Zones 1 & 2  2% damping';    
        [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
    
        out1=sprintf('Array Name: GR63_zone1_2    units: fn(Hz) & peak accel(G)');  
        
    end
    if(n==8)
   
        ANSI_C37_98=[ 1	0.25;
                       4	2.5;
                       16   2.5;
                       33	1.0;
                       50	1.0];           
        
        assignin('base', 'ANSI_C37_98', ANSI_C37_98 ); 
               
                   
                   
        fn=ANSI_C37_98(:,1);
        accel=ANSI_C37_98(:,2);
        y_lab='Accel (G)';
        fmin=1;
        fmax=50;
        t_string='SRS ANSI C37.98 Normalized  5% damping';    
        [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
    
        out1=sprintf('Array Name: ANSI_C37_98   units: fn(Hz) & peak accel(G)');  
        
    end
    if(n==9)
   
        FJ_source_26grpft=[ 100	  100;
                            4200  16000;
                           10000  16000];           
        
        assignin('base', 'FJ_source_26grpft', FJ_source_26grpft ); 
               
                   
                   
        fn=FJ_source_26grpft(:,1);
        accel=FJ_source_26grpft(:,2);
        y_lab='Accel (G)';
        fmin=fn(1);
        fmax=fn(end);
        t_string='SRS Frangible Joint Source Shock 26 grains/ft  Q=10';    
        [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
    
        out1=sprintf('Array Name: FJ_source_26grpft   units: fn(Hz) & peak accel(G)');  
        
    end 
    if(n==10)
   
        LSC_source_30grpft=[32	    320;
                            1150	11593;
                            1550	13731;
                            1970	14943;
                            2470	15683;
                            3050	15873;
                            3940	15493;
                            5000	14234];           
        
        assignin('base', 'LSC_source_30grpft',LSC_source_30grpft ); 
               
                   
                   
        fn=LSC_source_30grpft(:,1);
        accel=LSC_source_30grpft(:,2);
        y_lab='Accel (G)';
        fmin=fn(1);
        fmax=fn(end);
        t_string='SRS  NASA LSC Source Shock 30 grains/ft  Q=10';    
        [~]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax);      
    
        out1=sprintf('Array Name: LSC_source_30grpft   units: fn(Hz) & peak accel(G)');  
        
    end     
    

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(p==8) % Wavelet Table
    if(n==1)
        load('wavelet_2k.txt');
        out1=sprintf('Array Name: wavelet_2k    units: index f(Hz) Accel(G) NHS Delay(sec)');
    
        output_name='wavelet_2k';
        assignin('base', output_name, wavelet_2k);  
   
    end        
    if(n==2)
        load('wavelet_11k.txt');
        out1=sprintf('Array Name: wavelet_11k    units: index f(Hz) Accel(G) NHS Delay(sec)');
    
        output_name='wavelet_11k';
        assignin('base', output_name, wavelet_11k);  
   
    end        
end


if(p==9) % Sound Files
    
    iflag=1;
    
    if(n==1)
        filename='apache.wav';
    end        
    if(n==2)
        filename='sweep.wav';
    end 
    if(n==3)
        filename='transformer.mp3';
    end        
    if(n==4)
        filename= 'tuningfork440.mp3';         
    end 
    
    [signal, Fs] = audioread(filename);
    player = audioplayer(signal, Fs);
    play(player)
    pause(max(size(signal))/Fs);

end


try

    if(iflag==0)
        msgbox(out1);
        disp(out1);
    end

end


% --- Executes on button press in pushbutton_LMS.
function pushbutton_LMS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_LMS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_read_LMS_ascii_text;    
set(handles.s,'Visible','on'); 


% --- Executes during object creation, after setting all properties.
function pushbutton_read_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in listbox_ascii.
function listbox_ascii_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ascii (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ascii contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ascii


% --- Executes during object creation, after setting all properties.
function listbox_ascii_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ascii (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_ascii,'Value');

if(n==1)
    handles.s=vibrationdata_read_ascii_text;       
end
if(n==2)
    handles.s=vibrationdata_read_LMS_ascii_text;      
end
if(n==3)
    handles.s=vibrationdata_read_csv;
end

 
set(handles.s,'Visible','on'); 
