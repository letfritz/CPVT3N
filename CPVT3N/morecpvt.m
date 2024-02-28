%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Interface com informações sobre os dados de entrada do CPV/T
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = morecpvt(varargin)
% MORECPVT MATLAB code for morecpvt.fig
%      MORECPVT, by itself, creates a new MORECPVT or raises the existing
%      singleton*.
%
%      H = MORECPVT returns the handle to a new MORECPVT or the handle to
%      the existing singleton*.
%
%      MORECPVT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MORECPVT.M with the given input arguments.
%
%      MORECPVT('Property','Value',...) creates a new MORECPVT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before morecpvt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to morecpvt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help morecpvt

% Last Modified by GUIDE v2.5 23-Jul-2021 22:53:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @morecpvt_OpeningFcn, ...
                   'gui_OutputFcn',  @morecpvt_OutputFcn, ...
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


% --- Executes just before morecpvt is made visible.
function morecpvt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to morecpvt (see VARARGIN)

% Choose default command line output for morecpvt
handles.output = hObject;

% Definindo cor
set ( gcf, 'Color', [1 1 1] )

% Colocando Logo
axes(handles.imagLogo)
imshow('cpvt3n.gif')

% Update handles structure
guidata(hObject, handles);

% Configurando painel
    
    


% UIWAIT makes morecpvt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = morecpvt_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lbInfo.
function lbInfo_Callback(hObject, eventdata, handles)
% hObject    handle to lbInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lbInfo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lbInfo


% --- Executes during object creation, after setting all properties.
function lbInfo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lbInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
