%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Interface de erro entre dimensão dos arquivos das curvas
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = errorCurve(varargin)
% ERRORCURVE MATLAB code for errorCurve.fig
%      ERRORCURVE, by itself, creates a new ERRORCURVE or raises the existing
%      singleton*.
%
%      H = ERRORCURVE returns the handle to a new ERRORCURVE or the handle to
%      the existing singleton*.
%
%      ERRORCURVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ERRORCURVE.M with the given input arguments.
%
%      ERRORCURVE('Property','Value',...) creates a new ERRORCURVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before errorCurve_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to errorCurve_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help errorCurve

% Last Modified by GUIDE v2.5 24-Jul-2021 19:52:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @errorCurve_OpeningFcn, ...
                   'gui_OutputFcn',  @errorCurve_OutputFcn, ...
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


% --- Executes just before errorCurve is made visible.
function errorCurve_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to errorCurve (see VARARGIN)

% Choose default command line output for errorCurve
handles.output = hObject;

% Definindo cor
set ( gcf, 'Color', [1 1 1] )

% Colocando Logo
axes(handles.imagLogo)
imshow('cpvt3n.gif')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes errorCurve wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = errorCurve_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
