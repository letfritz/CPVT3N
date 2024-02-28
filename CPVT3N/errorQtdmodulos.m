%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Interface de erro de número de módulos não inteiro
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = errorQtdmodulos(varargin)
% ERRORQTDMODULOS MATLAB code for errorQtdmodulos.fig
%      ERRORQTDMODULOS, by itself, creates a new ERRORQTDMODULOS or raises the existing
%      singleton*.
%
%      H = ERRORQTDMODULOS returns the handle to a new ERRORQTDMODULOS or the handle to
%      the existing singleton*.
%
%      ERRORQTDMODULOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ERRORQTDMODULOS.M with the given input arguments.
%
%      ERRORQTDMODULOS('Property','Value',...) creates a new ERRORQTDMODULOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before errorQtdmodulos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to errorQtdmodulos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help errorQtdmodulos

% Last Modified by GUIDE v2.5 27-Jul-2021 19:49:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @errorQtdmodulos_OpeningFcn, ...
                   'gui_OutputFcn',  @errorQtdmodulos_OutputFcn, ...
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


% --- Executes just before errorQtdmodulos is made visible.
function errorQtdmodulos_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to errorQtdmodulos (see VARARGIN)

% Choose default command line output for errorQtdmodulos
handles.output = hObject;

% Definindo cor
set ( gcf, 'Color', [1 1 1] )

% Colocando Logo
axes(handles.imagLogo)
imshow('cpvt3n.gif')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes errorQtdmodulos wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = errorQtdmodulos_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
