function varargout = midtermProj(varargin)
% MIDTERMPROJ MATLAB code for midtermProj.fig
%      MIDTERMPROJ, by itself, creates a new MIDTERMPROJ or raises the existing
%      singleton*.
%
%      H = MIDTERMPROJ returns the handle to a new MIDTERMPROJ or the handle to
%      the existing singleton*.
%
%      MIDTERMPROJ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MIDTERMPROJ.M with the given input arguments.
%
%      MIDTERMPROJ('Property','Value',...) creates a new MIDTERMPROJ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before midtermProj_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to midtermProj_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help midtermProj

% Last Modified by GUIDE v2.5 25-Sep-2017 16:15:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @midtermProj_OpeningFcn, ...
                   'gui_OutputFcn',  @midtermProj_OutputFcn, ...
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


% --- Executes just before midtermProj is made visible.
function midtermProj_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to midtermProj (see VARARGIN)

% Choose default command line output for midtermProj
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes midtermProj wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = midtermProj_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in loadBtn.
function loadBtn_Callback(hObject, eventdata, handles)
[fn pn]= uigetfile({'*.jpg; *.jpeg; *.png; *.bmp;'},'Select Image');
if isequal(fn,0)
   disp('User selected Cancel');
else 
   disp(['User selected ', fullfile(pn,fn)]);
end
imageSelect = imread(strcat(pn,fn));
%assignin('caller','image',imageSelect);
global im
im=imageSelect;
global image
image = imageSelect;
imshow(imageSelect,'Parent',handles.axes1);


% --- Executes on button press in saveBtn.
function saveBtn_Callback(hObject, eventdata, handles)
% hObject    handle to saveBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ima=getimage(handles.axes1);
imwrite(ima,'saved.png');
msgbox('Image saved successfully!', 'SUCCESS', 'custom', ima);

% --- Executes on button press in cropBtn.
function cropBtn_Callback(hObject, eventdata, handles)
% hObject    handle to cropBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function brightLvl_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global image
b = (image) + get(hObject, 'Value');
imshow(b,'Parent',handles.axes1);

% --- Executes during object creation, after setting all properties.
function brightLvl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brightLvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on selection change in flipMenu.
function flipMenu_Callback(hObject, eventdata, handles)
global image
global im
i = getimage(handles.axes1);
str = get(hObject, 'String');
val = get(hObject, 'Value');
switch str{val}
    case 'FLIP ORIG'
        imshow(im, 'Parent', handles.axes1);
        image=im;
    case 'FLIP 45'
        x = imrotate(i,45,'loose','bilinear');
        x1 = ~imrotate(true(size(i)),45,'loose','bilinear');
        x(x1&~imclearborder(x1)) = 255;
        imshow(x,'Parent',handles.axes1);
        image=x;
    case 'FLIP 90'
        x = imrotate(i,90,'loose','bilinear');
        x1 = ~imrotate(true(size(i)),90,'loose','bilinear');
        x(x1&~imclearborder(x1)) = 255;
        imshow(x,'Parent',handles.axes1);
        image=x;
    case 'FLIP 180'
        x = imrotate(i,180,'loose','bilinear');
        x1 = ~imrotate(true(size(i)),180,'loose','bilinear');
        x(x1&~imclearborder(x1)) = 255;
        imshow(x,'Parent',handles.axes1);
        image=x;
end

% --- Executes during object creation, after setting all properties.
function flipMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flipMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
