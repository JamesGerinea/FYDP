% Code for interfacing with camera taken from
% http://www.mathworks.com/support/solutions/en/data/1-1CBPW/

% This code requires PsychToolBox for controlling the projector
% http://psychtoolbox.org/PsychtoolboxDownload 
% and the MATLAB Image Acquisition Toolbox

function varargout = MyCameraGUI(varargin)
    % MYCAMERAGUI M-file for MyCameraGUI.fig
    %      MYCAMERAGUI, by itself, creates a new MYCAMERAGUI or raises the existing
    %      singleton*.
    %
    %      H = MYCAMERAGUI returns the handle to a new MYCAMERAGUI or the handle to
    %      the existing singleton*.
    %
    %      MYCAMERAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in MYCAMERAGUI.M with the given input arguments.
    %
    %      MYCAMERAGUI('Property','Value',...) creates a new MYCAMERAGUI or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before MyCameraGUI_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to MyCameraGUI_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help MyCameraGUI

    % Last Modified by GUIDE v2.5 26-Sep-2013 14:42:43

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @MyCameraGUI_OpeningFcn, ...
                       'gui_OutputFcn',  @MyCameraGUI_OutputFcn, ...
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


% --- Executes just before MyCameraGUI is made visible.
function MyCameraGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MyCameraGUI (see VARARGIN)

% Choose default command line output for MyCameraGUI
    handles.output = hObject;

    % Turn off the scren options that run tests before each projection
    Screen('Preference','SkipSyncTests', 1);
    Screen('Preference','VisualDebugLevel', 0);
    % Create video object
    % Putting the object into manual trigger mode and then
    % starting the object will make GETSNAPSHOT return faster
    % since the connection to the camera will already have
    % been established. Some cameras take awhile to warm up.
    handles.video = videoinput('winvideo', 1); %Use the imaqhwinfo function to determine the adaptors available on your system.
    set(handles.video,'TimerPeriod', 0.05, ...
    'TimerFcn',['if(~isempty(gco)),'...
    'handles=guidata(gcf);'... % Update handles
    'image(getsnapshot(handles.video));'... % Get picture using GETSNAPSHOT and put it into axes using IMAGE
    'set(handles.cameraAxes,''ytick'',[],''xtick'',[]),'... % Remove tickmarks and labels that are inserted when using IMAGE
    'else '...
    'delete(imaqfind);'... % Clean up - delete any image acquisition objects
    'end']);
    triggerconfig(handles.video,'manual');
    handles.video.FramesPerTrigger = Inf; % Capture frames until we manually stop it

    %Initialize capture Image button to be disabled (wait for user to start
    %cam)
    set(handles.captureImage,'Enable','off');
    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes MyCameraGUI wait for user response (see UIRESUME)
    uiwait(handles.MyCameraGUI);


% --- Outputs from this function are returned to the command line.
function varargout = MyCameraGUI_OutputFcn(hObject, eventdata, handles)
    % varargout cell array for returning output args (see VARARGOUT);
    % hObject handle to figure
    % eventdata reserved - to be defined in a future version of MATLAB
    % handles structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    handles.output = hObject;
    varargout{1} = handles.output;

% --- Executes on button press in startStopCamera.
function startStopCamera_Callback(hObject, eventdata, handles)
    % hObject handle to startStopCamera (see GCBO)
    % eventdata reserved - to be defined in a future version of MATLAB
    % handles structure with handles and user data (see GUIDATA)

    % Start/Stop Camera
    if strcmp(get(handles.startStopCamera,'String'),'Start Camera')
    % Camera is off. Change button string and start camera.
    set(handles.startStopCamera,'String','Stop Camera')
    start(handles.video)
    set(handles.captureImage,'Enable','on');
    else
    % Camera is on. Stop camera and change button string.
    set(handles.startStopCamera,'String','Start Camera')
    stop(handles.video)
    set(handles.captureImage,'Enable','off');
    end


% --- Executes on button press in captureImage.
function captureImage_Callback(hObject, eventdata, handles)
    % hObject handle to captureImage (see GCBO)
    % eventdata reserved - to be defined in a future version of MATLAB
    % handles structure with handles and user data (see GUIDATA)
    % frame = getsnapshot(handles.video);
    
    % Use Screen function from PsychToolBox to project specified image
    % onto secondary monitor
    % From PsychToolBox Doc: 
    %screenindex 0 -> use all available screen
    %screenindex 1 -> use primary display
    %screenindex 2 -> use secondary display
    %...etc
    screenIndex = 0;
    [w(1) sRect]=Screen('OpenWindow', screenIndex, 0,[],32,2);
    A = imread_rgb('eagle.jpg'); %HARD CODED
    A = imresize(A, [800,1280]); %HARD CODED
    screen('PutImage',w(1),A);
    Screen('Flip', w(1));
    pause(3.0); %HARD CODED
    frame = get(get(handles.cameraAxes,'children'),'cdata'); % The current displayed frame
    imwrite(frame,'testFrame.bmp'); %HARD CODED
    %save('testframe.mat', 'frame');
    screen('CloseAll');
    disp('Frame saved to file ''testFrame.bmp'''); %HARD CODED


% --- Executes when user attempts to close MyCameraGUI.
function MyCameraGUI_CloseRequestFcn(hObject, eventdata, handles)
    % hObject    handle to MyCameraGUI (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Remove any Image Acuisition objects
    % Note: not doing this and leaving the cam open when closing form will
    % cause you to lose reference of the cam object, and MATLAB must be
    % restarted.
    delete(hObject);
    delete(imaqfind);
