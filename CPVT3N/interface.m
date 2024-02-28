%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Interface principal com dados de entrada para o programa
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = interface(varargin)
% INTERFACE MATLAB code for interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface

% Last Modified by GUIDE v2.5 27-Jul-2021 19:42:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
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


% --- Executes just before interface is made visible.
function interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interface (see VARARGIN)

% Choose default command line output for interface
handles.output = hObject;

% Definindo cor
set ( gcf, 'Color', [1 1 1] )

% Colocando Logo
axes(handles.imagLogo)
imshow('cpvt3n.gif')

% Tornando painel 2 invisível
set(handles.uipInput2, 'Visible', 'Off')

% Carregando dados no popupmenu
data = {'1100', '3000', '5000', '25000'};
set(handles.pmVolume, 'string', data)

% Seleciona a opção de um módulo CPVT
set(handles.uipQtdmodulos, 'SelectedObject', handles.rbUm);

% Configurando caixa de status
set(handles.txStatus, 'Visible', 'Off');

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pbPlay.
function pbPlay_Callback(hObject, eventdata, handles)
% hObject    handle to pbPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Iniciando código
%COLETOR.num_cell = str2double(get(handles.txNumcell, 'String'));
guidata( hObject, handles );

% Verificando coerência dos dados de curvas
getCurva();
if (length(CURVA.vDNI) == length(CURVA.vTemperatura)) && ...
        (length(CURVA.vDNI) == length(CURVA.vAguaL)) && ...
        (length(CURVA.vDNI) == length(CURVA.T_consumo))
    % Verificando se quantidade de CPVT é um número
    selecionado = get(handles.uipQtdmodulos, 'SelectedObject');
    if strcmpi(get(selecionado, 'String'), 'Testar:')
        if isnumeric(str2double(handles.etQtdmodulos.String))
            set(handles.etQtdmodulos, 'String', floor(str2double(handles.etQtdmodulos.String)))
            set(handles.txStatus, 'String', 'Simulação em processo. Por favor, aguarde...')
            set(handles.txStatus, 'Visible', 'On')
            main();
            set(handles.txStatus, 'String', 'Simulação concluída com sucesso!')
            pause(10)
            set(handles.txStatus, 'Visible', 'Off')
        else
            errorQtdmodulos;
        end
    else
        set(handles.etQtdmodulos, 'String', floor(str2double(handles.etQtdmodulos.String)))
        set(handles.txStatus, 'String', 'Simulação em processo. Por favor, aguarde...')
        set(handles.txStatus, 'Visible', 'On')
        pause(3)
        main();
        set(handles.txStatus, 'String', 'Simulação concluída com sucesso!')
        pause(10)
        set(handles.txStatus, 'Visible', 'Off')
    end
else
    errorCurve;
end


% --- Executes on button press in pbInfo.
function pbInfo_Callback(hObject, eventdata, handles)
% hObject    handle to pbInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf, 'Visible', 'Off')
info;


% --- Executes on button press in pbCpvt.
function pbCpvt_Callback(hObject, eventdata, handles)
% hObject    handle to pbCpvt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf, 'Visible', 'Off')
cpvtinfo;


% --- Executes on slider movement.
function sNumcell_Callback(hObject, eventdata, handles)
% hObject    handle to sNumcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
numcell = floor(get(hObject, 'Value')) + 60;
set(handles.txNumcell, 'String', numcell);


% --- Executes during object creation, after setting all properties.
function sNumcell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sNumcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sFc_Callback(hObject, eventdata, handles)
% hObject    handle to sNumcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
FC = floor(get(hObject, 'Value')) + 600;
set(handles.txFc, 'String', FC);

% --- Executes during object creation, after setting all properties.
function sFc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sNumcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sEfic_ref_Callback(hObject, eventdata, handles)
% hObject    handle to sNumcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
efic_ref = (get(hObject, 'Value'))/10 + 0.31;
set(handles.txEfic_ref, 'String', efic_ref);

% --- Executes during object creation, after setting all properties.
function sEfic_ref_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sNumcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sEfic_opt_Callback(hObject, eventdata, handles)
% hObject    handle to sNumcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
efic_opt = (get(hObject, 'Value'))/10 + 0.20;
set(handles.txEfic_opt, 'String', efic_opt);

% --- Executes during object creation, after setting all properties.
function sEfic_opt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sNumcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sEfic_inv_Callback(hObject, eventdata, handles)
% hObject    handle to sNumcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
efic_inv = get(hObject, 'Value') + 0.30;
set(handles.txEfic_inv, 'String', efic_inv);

% --- Executes during object creation, after setting all properties.
function sEfic_inv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sNumcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sEfic_mod_Callback(hObject, eventdata, handles)
% hObject    handle to sNumcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
efic_mod = get(hObject, 'Value') + 0.30;
set(handles.txEfic_mod, 'String', efic_mod);

% --- Executes during object creation, after setting all properties.
function sEfic_mod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sNumcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in pbGo.
function pbGo_Callback(hObject, eventdata, handles)
% hObject    handle to pbGo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

status1 = get(handles.uipInput1, 'Visible');
status2 = get(handles.uipInput2, 'Visible');
% Navegando entre paineis
if strcmpi(status1,'on')
    set(handles.uipInput1, 'Visible', 'Off')
    set(handles.uipInput2, 'Visible', 'On')
end

if strcmpi(status2,'on')
    set(handles.uipInput1, 'Visible', 'On')
    set(handles.uipInput2, 'Visible', 'Off')
end


% --- Executes on slider movement.
function sFt_imp_Callback(hObject, eventdata, handles)
% hObject    handle to sFt_imp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ft_imp = get(hObject, 'Value');
set(handles.txFt_imp, 'String', ft_imp);

% --- Executes during object creation, after setting all properties.
function sFt_imp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sFt_imp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sEmiss_Callback(hObject, eventdata, handles)
% hObject    handle to sEmiss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
emiss = get(hObject, 'Value') + 0.30;
set(handles.txEmiss, 'String', emiss);


% --- Executes during object creation, after setting all properties.
function sEmiss_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sEmiss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pbMore1.
function pbMore1_Callback(hObject, eventdata, handles)
% hObject    handle to pbMore1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
morecpvt;


% --- Executes on slider movement.
function sTempH2O_Callback(hObject, eventdata, handles)
% hObject    handle to sTempH2O (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
tempH2O = floor(get(hObject, 'Value'));
set(handles.txTempH2O, 'String', tempH2O);

% --- Executes during object creation, after setting all properties.
function sTempH2O_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sTempH2O (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sTempnew_Callback(hObject, eventdata, handles)
% hObject    handle to sTempnew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
tempnew = floor(get(hObject, 'Value'));
set(handles.txTempnew, 'String', tempnew);

% --- Executes during object creation, after setting all properties.
function sTempnew_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sTempnew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sGranularidade_Callback(hObject, eventdata, handles)
% hObject    handle to sGranularidade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
granu = floor(get(hObject, 'Value'));
set(handles.txGranularidade, 'String', granu);

% --- Executes during object creation, after setting all properties.
function sGranularidade_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sGranularidade (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in pmVolume.
function pmVolume_Callback(hObject, eventdata, handles)
% hObject    handle to pmVolume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pmVolume contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pmVolume
allItems = get(handles.pmVolume,'string');
selectedIndex = get(handles.pmVolume,'Value');
selectedItem = allItems{selectedIndex};
if strcmpi(selectedItem,'1100')
    set(handles.txDim_in, 'String', '0.680');
    set(handles.txAltura, 'String', '2.650');
elseif strcmpi(selectedItem,'3000')
    set(handles.txDim_in, 'String', '1.300');
    set(handles.txAltura, 'String', '2.650');
elseif strcmpi(selectedItem,'5000')
    set(handles.txDim_in, 'String', '1.640');
    set(handles.txAltura, 'String', '2.650');
elseif strcmpi(selectedItem,'25000')
    set(handles.txDim_in, 'String', '3.170');
    set(handles.txAltura, 'String', '2.830');
end

% --- Executes during object creation, after setting all properties.
function pmVolume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pmVolume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbmoreRes.
function pbmoreRes_Callback(hObject, eventdata, handles)
% hObject    handle to pbmoreRes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
moreRes;


% --- Executes on button press in rbUm.
function rbUm_Callback(hObject, eventdata, handles)
% hObject    handle to rbUm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbUm
set(handles.etQtdmodulos, 'Enable', 'Off');

% --- Executes on button press in rbMaximo.
function rbMaximo_Callback(hObject, eventdata, handles)
% hObject    handle to rbMaximo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbMaximo
set(handles.etQtdmodulos, 'Enable', 'Off');


function etQtdmodulos_Callback(hObject, eventdata, handles)
% hObject    handle to etQtdmodulos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of etQtdmodulos as text
%        str2double(get(hObject,'String')) returns contents of etQtdmodulos as a double


% --- Executes during object creation, after setting all properties.
function etQtdmodulos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to etQtdmodulos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rbTentar.
function rbTentar_Callback(hObject, eventdata, handles)
% hObject    handle to rbTentar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbTentar
set(handles.etQtdmodulos, 'Enable', 'On');
