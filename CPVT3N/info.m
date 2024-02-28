%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Interface com informações gerais do programa
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = info(varargin)
% INFO MATLAB code for info.fig
%      INFO, by itself, creates a new INFO or raises the existing
%      singleton*.
%
%      H = INFO returns the handle to a new INFO or the handle to
%      the existing singleton*.
%
%      INFO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INFO.M with the given input arguments.
%
%      INFO('Property','Value',...) creates a new INFO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before info_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to info_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help info

% Last Modified by GUIDE v2.5 22-Jul-2021 10:27:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @info_OpeningFcn, ...
                   'gui_OutputFcn',  @info_OutputFcn, ...
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


% --- Executes just before info is made visible.
function info_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to info (see VARARGIN)

% Choose default command line output for info
handles.output = hObject;

% Definindo cor
set ( gcf, 'Color', [1 1 1] )

% Colocando Logo
axes(handles.imagLogo)
imshow('cpvt3n.gif')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes info wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = info_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pbVisitar.
function pbVisitar_Callback(hObject, eventdata, handles)
% hObject    handle to pbVisitar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
url = 'https://www.sciencedirect.com/science/article/abs/pii/S0196890420309201';
web(url, '-browser')
