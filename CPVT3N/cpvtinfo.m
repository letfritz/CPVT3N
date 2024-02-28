%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Interface com modelo do CPVT e do reservatório estratificado
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = cpvtinfo(varargin)
% CPVTINFO MATLAB code for cpvtinfo.fig
%      CPVTINFO, by itself, creates a new CPVTINFO or raises the existing
%      singleton*.
%
%      H = CPVTINFO returns the handle to a new CPVTINFO or the handle to
%      the existing singleton*.
%
%      CPVTINFO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CPVTINFO.M with the given input arguments.
%
%      CPVTINFO('Property','Value',...) creates a new CPVTINFO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cpvtinfo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cpvtinfo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cpvtinfo

% Last Modified by GUIDE v2.5 21-Jul-2021 20:08:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cpvtinfo_OpeningFcn, ...
                   'gui_OutputFcn',  @cpvtinfo_OutputFcn, ...
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


% --- Executes just before cpvtinfo is made visible.
function cpvtinfo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cpvtinfo (see VARARGIN)

% Choose default command line output for cpvtinfo
handles.output = hObject;

% Definindo cor
set ( gcf, 'Color', [1 1 1] )

% Colocando Logo
axes(handles.imagLogo)
imshow('cpvt3n.gif')

% Colocando imagem do CPVT
axes(handles.imagCpvt)
imshow('modeloCPVT.gif')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cpvtinfo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cpvtinfo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pbBack.
function pbBack_Callback(hObject, eventdata, handles)
% hObject    handle to pbBack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf, 'Visible', 'Off')
interface;


% --- Executes on button press in pbCpvt.
function pbCpvt_Callback(hObject, eventdata, handles)
% hObject    handle to tbcpvt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbcpvt
% Contruir setup do painel para o CPVT
axes(handles.imagCpvt)
imshow('modeloCPVT.gif')
set(handles.uipanel, 'Title', 'CPV/T');
set(handles.uipanel, 'ForegroundColor', [0 0 1]);
set(handles.uipanel, 'HighlightColor', [0 0 1]);


% --- Executes on button press in pbRes.
function pbRes_Callback(hObject, eventdata, handles)
% hObject    handle to tbRes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tbRes
% Contruir setup do painel para o Reservatório
axes(handles.imagCpvt)
imshow('modeloRes.gif')
set(handles.uipanel, 'Title', 'Reservatório');
set(handles.uipanel, 'ForegroundColor', [1 0 0]);
set(handles.uipanel, 'HighlightColor', [1 0 0]);
