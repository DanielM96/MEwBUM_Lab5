function varargout = GUI_FanAndSaw(varargin)
% GUI_FANANDSAW MATLAB code for GUI_FanAndSaw.fig
%      GUI_FANANDSAW, by itself, creates a new GUI_FANANDSAW or raises the existing
%      singleton*.
%
%      H = GUI_FANANDSAW returns the handle to a new GUI_FANANDSAW or the handle to
%      the existing singleton*.
%
%      GUI_FANANDSAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_FANANDSAW.M with the given input arguments.
%
%      GUI_FANANDSAW('Property','Value',...) creates a new GUI_FANANDSAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_FanAndSaw_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_FanAndSaw_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_FanAndSaw

% Last Modified by GUIDE v2.5 12-Nov-2018 12:35:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_FanAndSaw_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_FanAndSaw_OutputFcn, ...
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


% --- Executes just before GUI_FanAndSaw is made visible.
function GUI_FanAndSaw_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_FanAndSaw (see VARARGIN)

% Choose default command line output for GUI_FanAndSaw
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_FanAndSaw wait for user response (see UIRESUME)
% uiwait(handles.figure1);
evalin('base','clear; clc');
global selectedObject selectedState availableOptions optionsFan optionsSaw fanData sawData Fs;
selectedObject = 1;
selectedState = 1;
optionsFan = { 'Poziom 1 (najwolniejszy)', 'Poziom 2', 'Poziom 3 (najszybszy)', 'Rozpêd + hamowanie' };
optionsSaw = { 'Czujnik w górnej czêœci pi³y', 'Czujnik w dolnej czêœci pi³y' };

availableOptions = optionsFan;

Fs = 25000;

% tablica danych
fanData = { 'fan1.mat' 'fan2.mat' 'fan3.mat' 'fan_cycle.mat' };
sawData = { 'saw1.mat' 'saw2.mat' };


% --- Outputs from this function are returned to the command line.
function varargout = GUI_FanAndSaw_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1_exit.
function pushbutton1_exit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);

% --------------------------------------------------------------------
function Menu_Help_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Help_Matlab_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Matlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
doc;

% --------------------------------------------------------------------
function Help_About_Callback(hObject, eventdata, handles)
% hObject    handle to Help_About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({ 'GUI_FanAndSaw','','Funkcje: ','',...
    '- wczytywanie danych pomiarowych dla wentylatora i pi³y,',...
    '- filtracja górnoprzepustowa danych pomiarowych,',...
    '- analiza prêdkoœci i przemieszczeñ na podstawie przyspieszeñ.',},...
    'GUI_FanAndSaw - informacje','help');


% --- Executes on selection change in popupmenu1_state.
function popupmenu1_state_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1_state (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1_state contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1_state
global selectedState;
selectedState = get(hObject,'Value');

contents = cellstr(get(hObject,'String'));
statusBar = sprintf('Wybrany stan obiektu: %s.',contents{get(hObject,'Value')});
set(handles.text1_status,'String',statusBar);

% --- Executes during object creation, after setting all properties.
function popupmenu1_state_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1_state (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton2_draw.
function pushbutton2_draw_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2_draw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fanData sawData selectedObject selectedState Fs t timeEnd accData;

tic;
switch selectedObject
    case 1
        currentData = fanData{selectedState};
        
    case 2
        currentData = sawData{selectedState};
end
accData = load(currentData);
accData = accData.x;
loadTime = toc;
statusBar = sprintf('Wczytywanie zakoñczone (%.2f s).',loadTime);
set(handles.text1_status,'String',statusBar);

pause(0.5);
statusBar = sprintf('Generowanie wykresów...');
set(handles.text1_status,'String',statusBar);

%% wykresy
% wektor czasu
timeEnd = length(accData)/Fs;
t = 1/Fs:1/Fs:timeEnd;

pause(0.05);
tic;
% tu bêd¹ wykresy
axes(handles.axes1_timeview);
plot(t,accData);
title('Przebieg czasowy');
xlabel('Czas [s]');
ylabel('Amplituda');
xlim([ 0 timeEnd ]);
zoom on;

% FFT
N = length(accData);
df = Fs/N;
f = 0:df:Fs/2;
acc_fft = fft(accData);
acc_fft = abs(acc_fft);
acc_fft = acc_fft(1:N/2+1);
acc_fft = acc_fft/(N/2);

axes(handles.axes2_spectre);
plot(f,acc_fft);
title('Widmo sygna³u');
xlabel('Czêstotliwoœæ [Hz]');
ylabel('Amplituda');
zoom on;

axes(handles.axes3_spectrogram);
spectrogram(accData,[],[],[],Fs);
zoom on;

genTime = toc;

statusBar = sprintf('Wygenerowano wykresy (%.2f s).',genTime);
set(handles.text1_status,'String',statusBar);

% --- Executes when selected object is changed in uibuttongroup1_target.
function uibuttongroup1_target_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1_target 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global selectedObject selectedState optionsFan optionsSaw;
isChangedFromFanToSaw = false;

switch eventdata.NewValue
    case handles.radiobutton1_fan % wentylator
        selectedObject = 1;
        availableOptions = optionsFan;
        statusBar = sprintf('Wybrany obiekt: wentylator.');
        set(handles.text1_status,'String',statusBar);
        
    case handles.radiobutton2_saw % pi³a
        selectedObject = 2;
        availableOptions = optionsSaw;
        if selectedState > 2 % prze³¹czanie wentylator -> pi³a
            selectedState = 1;
            isChangedFromFanToSaw = true;
        end
        statusBar = sprintf('Wybrany obiekt: pi³a.');
        set(handles.text1_status,'String',statusBar);
end
set(handles.popupmenu1_state,'String',availableOptions);
if isChangedFromFanToSaw
    set(handles.popupmenu1_state,'Value',selectedState);
end


% --- Executes on button press in pushbutton3_a_v_d.
function pushbutton3_a_v_d_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3_a_v_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global accData Fs t timeEnd;
assignin('base','accData',accData);
assignin('base','Fs',Fs);
assignin('base','t',t);
assignin('base','timeEnd',timeEnd);
assignin('base','isCalledFromFanAndSaw',true);
GUI_Kinematics;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global cutoff t timeEnd Fs accData;
cutoff = get(hObject,'Value');
set(handles.edit1_freq,'String',num2str(cutoff));

pause(0.05);
statusBar = sprintf('Filtrowanie sygna³u (czêstotliwoœæ odciêcia: %d Hz)...',cutoff);
set(handles.text1_status,'String',statusBar);
filteredData = hipassFilter(accData,cutoff);

pause(0.5);
statusBar = sprintf('Generowanie wykresów...');
set(handles.text1_status,'String',statusBar);
tic;

axes(handles.axes1_timeview);
plot(t,filteredData);
title('Przebieg czasowy');
xlabel('Czas [s]');
ylabel('Amplituda');
xlim([ 0 timeEnd ]);
zoom on;

% FFT
N = length(filteredData);
df = Fs/N;
f = 0:df:Fs/2;
acc_fft = fft(filteredData);
acc_fft = abs(acc_fft);
acc_fft = acc_fft(1:N/2+1);
acc_fft = acc_fft/(N/2);

axes(handles.axes2_spectre);
plot(f,acc_fft);
title('Widmo sygna³u');
xlabel('Czêstotliwoœæ [Hz]');
ylabel('Amplituda');
zoom on;

axes(handles.axes3_spectrogram);
spectrogram(filteredData,20000,10000,20000,Fs);
zoom on;

genTime = toc;

statusBar = sprintf('Wygenerowano wykresy (%.2f s).',genTime);
set(handles.text1_status,'String',statusBar);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
slider_min = 30;
slider_max = 300;
set(hObject,'Min',slider_min);
set(hObject,'Max',slider_max);
set(hObject,'Value',slider_min);
set(hObject,'SliderStep',[ 1/27 0.5 ]);


function edit1_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_freq as text
%        str2double(get(hObject,'String')) returns contents of edit1_freq as a double


% --- Executes during object creation, after setting all properties.
function edit1_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton4_filter.
function pushbutton4_filter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global accData t timeEnd Fs;
cutoff = 30;

pause(0.05);
statusBar = sprintf('Filtrowanie sygna³u (czêstotliwoœæ odciêcia: %d Hz)...',cutoff);
set(handles.text1_status,'String',statusBar);
filteredData = hipassFilter(accData);

pause(0.5);
statusBar = sprintf('Generowanie wykresów...');
set(handles.text1_status,'String',statusBar);
tic;

axes(handles.axes1_timeview);
plot(t,filteredData);
title('Przebieg czasowy');
xlabel('Czas [s]');
ylabel('Amplituda');
xlim([ 0 timeEnd ]);
zoom on;

% FFT
N = length(filteredData);
df = Fs/N;
f = 0:df:Fs/2;
acc_fft = fft(filteredData);
acc_fft = abs(acc_fft);
acc_fft = acc_fft(1:N/2+1);
acc_fft = acc_fft/(N/2);

axes(handles.axes2_spectre);
plot(f,acc_fft);
title('Widmo sygna³u');
xlabel('Czêstotliwoœæ [Hz]');
ylabel('Amplituda');
zoom on;

axes(handles.axes3_spectrogram);
spectrogram(filteredData,20000,10000,20000,Fs);
zoom on;

genTime = toc;

statusBar = sprintf('Wygenerowano wykresy (%.2f s).',genTime);
set(handles.text1_status,'String',statusBar);

% --- Executes on button press in pushbutton5_clear.
function pushbutton5_clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global accData t timeEnd Fs;

pause(0.5);
statusBar = sprintf('Generowanie wykresów bez filtrowania...');
set(handles.text1_status,'String',statusBar);
tic;

axes(handles.axes1_timeview);
plot(t,accData);
title('Przebieg czasowy');
xlabel('Czas [s]');
ylabel('Amplituda');
xlim([ 0 timeEnd ]);
zoom on;

% FFT
N = length(accData);
df = Fs/N;
f = 0:df:Fs/2;
acc_fft = fft(accData);
acc_fft = abs(acc_fft);
acc_fft = acc_fft(1:N/2+1);
acc_fft = acc_fft/(N/2);

axes(handles.axes2_spectre);
plot(f,acc_fft);
title('Widmo sygna³u');
xlabel('Czêstotliwoœæ [Hz]');
ylabel('Amplituda');
zoom on;

axes(handles.axes3_spectrogram);
spectrogram(accData,20000,10000,20000,Fs);
zoom on;

genTime = toc;

statusBar = sprintf('Wygenerowano wykresy (%.2f s).',genTime);
set(handles.text1_status,'String',statusBar);
