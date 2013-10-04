function varargout = GUI(varargin)
% GUI M-file for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 21-Sep-2013 20:20:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

%video object for the camera
%this is hardcoded so it must be changed when switching projectors
global vid;
global capNum;
vid = videoinput('winvideo', 1, 'RGB24_1280x720');
src = getselectedsource(vid);
%vid = videoinput('winvideo', 1, 'YUY2_1024x768');
%src = getselectedsource(vid);
vid.FramesPerTrigger = 1;
vid.ReturnedColorspace = 'rgb';
triggerconfig(vid, 'manual');
vid.TriggerRepeat = Inf;

Screen('Preference','SkipSyncTests', 1);
Screen('Preference','VisualDebugLevel', 0);

capNum = 0;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonCapture.
function pushbuttonCapture_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCapture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%src = getselectedsource(vid);
global vid;
global capNum;

capNum = capNum + 1;
%A = imread_rgb('eagle.jpg');
% Set calibration parameters.
%A = imresize(A, [800,1280]);
%projValue   = 255;   % Gray code intensity
%screenIndex = 1;     % index of projector display (1 = first, 2 = second).
% Get projector display properties.
% Note: Assumes the Matlab Psychotoolbox is installed.
%window = screen('OpenWindow',screenIndex,projValue*[1 1 1]); 
%rect   = screen('Rect',window); clc;
%[w2 rect2]=Screen('OpenWindow', 2, 0,[],32,2);
%screen('MATLABToFront');

%I = projValue*ones(height,width,'uint8');
%C = uint8(projValue*(checkerboard(64,4,4) > 0.5));
%I((1:size(C,1))+(2*64)*1,(1:size(C,2))+(2*64)*2) = C;
%screen('PutImage',w2,A);
%screen('Flip',w2); 
%fullscreen(A,2);
%trigger(vid);
%imwrite(getdata(vid), strcat('zomg', num2str(capNum), '.jpg'));
%A = imread_rgb(strcat('zomg', num2str(capNum), '.jpg'));
%A = imresize(A, [900,1600]);
%[w1 rect1]=Screen('OpenWindow', 1, 0,[],32,2);
%screen('MATLABToFront');
%screen('PutImage',w1,A);
%screen('Flip',w1); 
%pause(3.0);
%screen('CloseAll');

    [w(1) sRect]=Screen('OpenWindow', 2, 0,[],32,2);
    A = imread_rgb('eagle.jpg');
    A = imresize(A, [800,1280]);
    screen('PutImage',w(1),A);
    Screen('Flip', w(1));
    pause(3.0);
    trigger(vid);
    imwrite(getdata(vid), strcat('zomg', num2str(capNum), '.jpg'));
    
    figure;
    imshow(strcat('zomg', num2str(capNum), '.jpg'));

    screen('CloseAll');
    %[w(2) sRect]=Screen('OpenWindow', 2, 0,[],32,2);
    %A = imread_rgb('eagle.jpg');
    %A = imresize(A, [800,1280]);
    %screen('PutImage',w(2),A);
    %Screen('Flip', w(2));


% --- Executes on button press in pushbuttonStartAcq.
function pushbuttonStartAcq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStartAcq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid;
start(vid);

% --- Executes on button press in pushbuttonStopAcq.
function pushbuttonStopAcq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStopAcq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid;
stop(vid);
