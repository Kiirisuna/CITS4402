function varargout = wk4lab(varargin)
%wk4lab M-file for wk4lab.fig
%      wk4lab, by itself, creates a new wk4lab or raises the existing
%      singleton*.
%
%      H = wk4lab returns the handle to a new wk4lab or the handle to
%      the existing singleton*.
%
%      wk4lab('Property','Value',...) creates a new wk4lab using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to wk4lab_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      wk4lab('CALLBACK') and wk4lab('CALLBACK',hObject,...) call the
%      local function named CALLBACK in wk4lab.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wk4lab

% Last Modified by GUIDE v2.5 21-Mar-2019 22:28:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wk4lab_OpeningFcn, ...
                   'gui_OutputFcn',  @wk4lab_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before wk4lab is made visible.
function wk4lab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for wk4lab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Clear variables and console log
clear;
clc;
global imageCheck;
imageCheck = 0;


% --- Outputs from this function are returned to the command line.
function varargout = wk4lab_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function edit_Pass1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Pass1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Pass1 as text
%        str2double(get(hObject,'String')) returns contents of edit_Pass1 as a double


% --- Executes during object creation, after setting all properties.
function edit_Pass1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Pass1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_Pass2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Pass2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Pass2 as text
%        str2double(get(hObject,'String')) returns contents of edit_Pass2 as a double


% --- Executes during object creation, after setting all properties.
function edit_Pass2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Pass2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_Boost_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Boost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Boost as text
%        str2double(get(hObject,'String')) returns contents of edit_Boost as a double


% --- Executes during object creation, after setting all properties.
function edit_Boost_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Boost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Load_Image.
% Open file select box with default file type as image files
% Check if image needs to be grayscaled
% Load image onto left axes if image file, else warning!
function Load_Image_Callback(hObject, eventdata, handles)
global image imageCheck;
[fileName,pathName,filterIndex]=uigetfile({'*.png;*.jpg;*.bmp;*.tif;';'*.*'},'Select Image to Open');
if (filterIndex ~= 0)
    try 
        selected = fullfile(pathName,fileName);
        im = imread(selected);
        if size(im,3)==3
            image = rgb2gray(im);
        else
            image = im;
            end
        axes(handles.axes1);
        imshow(image);
        imageCheck = 1;
        cla(handles.axes2);
    catch
        warning('Loading failed, please try again!');
    end
end


% --- Executes on button press in histogram_Equalize.
% Check for image
% Apply histeq and output image on the right axes
function histogram_Equalize_Callback(hObject, eventdata, handles)
global image imageCheck;
if (imageCheck == 1)
    im_hist = histeq(image);
    axes(handles.axes2);
    imshow(im_hist);  
else
    msgbox('Please load an image before attempting any operations', 'Image Not Loaded','error');
end


% --- Executes on button press in high_Boost.
% Check for image
% Boost high freq. component of the image
% highBoost = (boostFactor - 1) * originalImage + highPass
% Output image on the right axes
function high_Boost_Callback(hObject, eventdata, handles)
global image imageCheck;
if (imageCheck == 1)
    boost = str2double(get(handles.edit_Boost,'String'));
    if (boost < 1)
        msgbox('Please select an integer above 1 for boosting factor', 'Boost Factor Incompatibility','error');
    end
    lowFilter = imgaussfilt(image,5);
    highFilter = image - lowFilter;
    highBoost = (boost - 1) * image + highFilter;
    axes(handles.axes2);
    imshow(highBoost);
else
    msgbox('Please load an image before attempting any operations', 'Image Not Loaded','error');
end


% --- Executes on button press in high_Pass.
% Check for image
% highPass = originalImage - lowPass
% Output image on the right axes
function high_Pass_Callback(hObject, eventdata, handles)
global image imageCheck;
if (imageCheck == 1)
    lowFilter = imgaussfilt(image, 5);
    highFilter = image - lowFilter;
    axes(handles.axes2);
    imshow(highFilter);
else
    msgbox('Please load an image before attempting any operations', 'Image Not Loaded','error');
end


% --- Executes on button press in low_Pass.
% Check for image
% Use the given sigma and filter parameters from the text boxes
% Apply Gaussian filter and output image on the right axes
function low_Pass_Callback(hObject, eventdata, handles)
global image imageCheck;
if (imageCheck == 1)
    fSize = str2double(get(handles.edit_Pass2,'String'));
    if (fSize <= 0 || rem(fSize,2) == 0)
        msgbox('Please select a positive odd integer for filter size','Filter Size Incompatibility','error');
    end
    sigma = str2double(get(handles.edit_Pass1,'String'));
    if (sigma <= 0)
        msgbox('Please select a positive integer for sigma','Sigma Value Incompatibility','error');
    end
    lowFilter = imgaussfilt(image,sigma,'Filtersize',fSize);
    axes(handles.axes2);
    imshow(lowFilter);
else
    msgbox('Please load an image before attempting any operations', 'Image Not Loaded','error');
end
