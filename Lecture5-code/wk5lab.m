function varargout = wk5lab(varargin)
% WK5LAB MATLAB code for wk5lab.fig
%      WK5LAB, by itself, creates a new WK5LAB or raises the existing
%      singleton*.
%
%      H = WK5LAB returns the handle to a new WK5LAB or the handle to
%      the existing singleton*.
%
%      WK5LAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WK5LAB.M with the given input arguments.
%
%      WK5LAB('Property','Value',...) creates a new WK5LAB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wk5lab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wk5lab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wk5lab

% Last Modified by GUIDE v2.5 30-Mar-2019 11:41:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wk5lab_OpeningFcn, ...
                   'gui_OutputFcn',  @wk5lab_OutputFcn, ...
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


% --- Executes just before wk5lab is made visible.
function wk5lab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wk5lab (see VARARGIN)

% Choose default command line output for wk5lab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%Clear variables and console log
clear;
clc;
global imageCheck detectEdge;
imageCheck = 0;


% UIWAIT makes wk5lab wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = wk5lab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function Dropdownmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dropdownmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in loadImage.
function loadImage_Callback(hObject, eventdata, handles)
global image imageCheck grayscaled;
[fileName,pathName,filterIndex]=uigetfile({'*.png;*.jpg;*.bmp;*.tif;';'*.*'},'Select Image to Open');
if (filterIndex ~= 0)
    try 
        selected = fullfile(pathName,fileName);
        image = imread(selected);
        if size(image,3)==3
            grayscaled = rgb2gray(image);
        else
            grayscaled = image;
        end
        axes(handles.axes1);
        imshow(image);
        imageCheck = 1;
        cla(handles.axes2);
    catch
        warning('Loading failed, please try again!');
    end
end

% --- Executes on button press in detectEdge.
function detectEdge_Callback(hObject, eventdata, handles)
global imageCheck detectType;
if (imageCheck == 1)
    switch get(handles.Dropdownmenu,'Value')
        case 1
            detectType = 'Prewitt';
        case 2
            detectType = 'Sobel';
        case 3
            detectType = 'log';
        case 4
            detectType = 'Canny';
        case 5
            detectType = 'Roberts';
        case 6
            detectType = 'zerocross';
    end
    %detectEdge(handles,get(handles.slider1,'Value'),get(handles.slider2,'Value'));
    detectEdge(handles,-1,-1);
else
    msgbox('Please load an image before attempting any operations', 'Image Not Loaded','error');
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
threshold = get(hObject,'Value');
radius = get(handles.slider2,'Value');
detectEdge(handles,threshold,radius);

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
radius = get(hObject,'Value');
threshold = get(handles.slider1,'Value');
detectEdge(handles,threshold,radius);

% --- Executes on selection change in Dropdownmenu.
function Dropdownmenu_Callback(hObject, eventdata, handles)
% hObject    handle to Dropdownmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Dropdownmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Dropdownmenu

function detectEdge(handles, threshold, radius)
global image grayscaled detectType;
if (threshold == -1)
    imageOut = edge(grayscaled,detectType);
else
    imageOut = edge(grayscaled, detectType, threshold);
end
axes(handles.axes2);
imshow(imageOut);
if (radius == -1)
    
else
radiusMin = uint8(radius-4);
radiusMax = uint8(radius+4);
if (radiusMin <= 0)
    radiusMin = 1;
end
[C, A] = imfindcircles(imageOut,[radiusMin,radiusMax], 'ObjectPolarity', 'bright','Sensitivity', 0.93);
viscircles(C, A, 'Color','b');
axes(handles.axes1);
imshow(image);
viscircles(C, A, 'Color', 'b');
end
