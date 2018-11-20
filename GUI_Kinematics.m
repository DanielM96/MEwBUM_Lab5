function varargout = GUI_Kinematics(varargin)
% GUI_KINEMATICS MATLAB code for GUI_Kinematics.fig
%      GUI_KINEMATICS, by itself, creates a new GUI_KINEMATICS or raises the existing
%      singleton*.
%
%      H = GUI_KINEMATICS returns the handle to a new GUI_KINEMATICS or the handle to
%      the existing singleton*.
%
%      GUI_KINEMATICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_KINEMATICS.M with the given input arguments.
%
%      GUI_KINEMATICS('Property','Value',...) creates a new GUI_KINEMATICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Kinematics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Kinematics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Kinematics

% Last Modified by GUIDE v2.5 12-Nov-2018 14:06:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Kinematics_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Kinematics_OutputFcn, ...
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


% --- Executes just before GUI_Kinematics is made visible.
function GUI_Kinematics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Kinematics (see VARARGIN)

% Choose default command line output for GUI_Kinematics
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Kinematics wait for user response (see UIRESUME)
% uiwait(handles.figure1);
isLaunchedFromParent = evalin('base','exist(''isCalledFromFanAndSaw'',''var'') == 1');
if ~isLaunchedFromParent
    msgbox('To GUI mo¿na uruchomiæ tylko z poziomu GUI_FanAndSaw.','B³¹d','error');
    delete(handles.figure1);
else
    accData = evalin('base','accData');
    Fs = evalin('base','Fs');
    t = evalin('base','t');
    timeEnd = evalin('base','timeEnd');
    cutoff = evalin('base','cutoff');
    
    accData = hipassFilter(accData,cutoff);
    accData = accData - mean(accData);
    g = 9.81;
%     g = 1;
    
    pause(0.05);
    tic;
    % tu bêd¹ wykresy
    axes(handles.axes1_acceleration);
    % plot(t,accData(1:length(t)));
    plot(t,g*accData);
    title('Przyspieszenie');
    xlabel('Czas [s]');
    ylabel('Wartoœæ [m/s^2]');
    xlim([ 0 timeEnd ]);
    zoom on;
    
    axes(handles.axes2_velocity);
%     velocity = iomega(filtData,1/Fs,3,2);
    velocity = detrend(cumtrapz(t,accData),'linear');
    velocity = velocity - mean(velocity);
    % plot(t,velocity(1:length(t)));
    plot(t,g*velocity);
    title('Prêdkoœæ');
    xlabel('Czas [s]');
    ylabel('Wartoœæ [mm/s]');
    xlim([ 0 timeEnd ]);
    zoom on;
    
    axes(handles.axes3_displacement);
%     displacement = iomega(filtData,1/Fs,3,1);
    displacement = detrend(cumtrapz(t,velocity),'linear');
    displacement = displacement - mean(displacement);
    % plot(t,displacement(1:length(t)));
    plot(t,g*displacement);
    title('Przemieszczenie');
    xlabel('Czas [s]');
    ylabel('Wartoœæ [mm]');
    xlim([ 0 timeEnd ]);
    zoom on;
    
    genTime = toc;
    
    statusBar = sprintf('Wygenerowano wykresy (%.2f s).',genTime);
    set(handles.text1_status,'String',statusBar);
end

% --- Outputs from this function are returned to the command line.
function varargout = GUI_Kinematics_OutputFcn(hObject, eventdata, handles) 
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
evalin('base','clear');
delete(handles.figure1);
