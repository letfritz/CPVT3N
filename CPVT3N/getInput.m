%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/t�rmico 
%          considerando reservat�rio estratificado em 3 n�veis
% ARQUIVO: Dados de entrada carregados com informa��es da interface
% NOME: LET�CIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVIS�O: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% GERAL

% Acelera��o da gravidade
GERAL.g = str2double(handles.txGravidade.String);%9.8;

% Constante de Stefan-Boltzmann [W/(m�.K^4)]
GERAL.constSB = 5.670367*10^(-8);

% Condutividade t�rmica do ar [W/mK]
GERAL.k_ar = str2double(handles.txAr.String);%0.023;

%% COLETOR

% N�mero de c�lular fotovoltaicas no m�dulo (Pode ser de 60 � 120)
COLETOR.num_cell = str2double(handles.txNumcell.String);%90;

% Fator de concentra��o (Pode ser de 600 � 1200)
COLETOR.CF = str2double(handles.txFc.String);%900;

% �rea padr�o de um m�dulo CPV/T [m2]
COLETOR.comprimento = str2double(handles.txComp.String);%5.94;
COLETOR.largura = str2double(handles.txLag.String);%2.43;
COLETOR.A_modulo = COLETOR.comprimento*COLETOR.largura;

% �rea padr�o de uma c�lula do m�dulo CPV/T [m2]
COLETOR.A_cell = 81*10^-6;

% Espessura da placa de alum�nio [m]
COLETOR.Lplaca = str2double(handles.txLplaca.String);%0.004;

% Efici�ncia correspondente ao fator de concentra��o escolhido
% (existe uma curva para isso)
COLETOR.efic_ref = str2double(handles.txEfic_ref.String);%0.35;

% Efici�ncia �ptica
COLETOR.efic_opt = str2double(handles.txEfic_opt.String);%0.85;

% Efici�ncia do inversor [%]
COLETOR.efic_inversor = str2double(handles.txEfic_inv.String);%0.9;

% Efici�ncia de um m�dulo
% (Este valor leva em considera��o o arranjo das c�lulas)
COLETOR.efic_modulo = str2double(handles.txEfic_mod.String);%0.9;

% Fator considerado pelas imperfei��es do sistema
COLETOR.fator_imperfeicao = str2double(handles.txFt_imp.String);%0.9;

% Coeficiente de temperatura dependente do tipo de c�lula [1/�C]
COLETOR.coef_temperatura = str2double(handles.txCf_temp.String);%-0.0016;

% Fator de perda das correntes parasitas dependendo da radia��o
COLETOR.p_par = str2double(handles.txFt_par.String);%0.023;

% Fator de emissividade da c�lula
COLETOR.emiss = str2double(handles.txEmiss.String);%0.85;

% Quantidade de calor gerado internamente pelo equipamento [kW]
COLETOR.Q_gerado = 0.0;

% Coeficiente convectivo m�dio para c�lula [W/(m�.K)]
% [A miniature concentrating photovoltaic and thermal system]
COLETOR.coef_ConvMedio = str2double(handles.txConvmedio.String);%5;

%% RESERVAT�RIO

% Temperatura inicial da agua
RESERVATORIO.Tagua_orig = str2double(handles.txTempH2O.String)*ones(1,3)...
    +273; %30

% Temperatura da �gua que vem da rede de abastecimento
RESERVATORIO.TL = str2double(handles.txTempnew.String)+273; %23

% Di�metro da tubula��o [m] (lado da c�lula, Renno)
RESERVATORIO.d = str2double(handles.txDim.String);%0.05;

% Condutividade T�rmica [W/mK]
RESERVATORIO.k(1) = str2double(handles.txCamada1.String);%372;
RESERVATORIO.k(2) = str2double(handles.txCamada2.String);%0.035;
RESERVATORIO.k(3) = str2double(handles.txCamada3.String);%372;

% Raio [m]
RESERVATORIO.r(1) = (str2double(handles.txDim_in.String)/2);
RESERVATORIO.r(2) = RESERVATORIO.r(1) + 0.0040;
RESERVATORIO.r(3) = RESERVATORIO.r(2) + 0.0300;
RESERVATORIO.r(4) = RESERVATORIO.r(3) + 0.0040;
RESERVATORIO.D_ext = 2*RESERVATORIO.r(4);

% Altura
RESERVATORIO.LTubo = str2double(handles.txAltura.String);
        
% Massa de �gua
allItems = get(handles.pmVolume,'string');
selectedIndex = get(handles.pmVolume,'Value');
selectedItem = allItems{selectedIndex};
RESERVATORIO.massa = (str2double(selectedItem)/3)*ones(3,1);

% Temperatura de opera��o do termostato
RESERVATORIO.Termostato = 50 + 273;

%% Modo de simual��o
selecionado = get(handles.uipQtdmodulos, 'SelectedObject');
if strcmpi(get(selecionado, 'String'), 'Apenas 1')
    qtdModulos = 1;
elseif strcmpi(get(selecionado, 'String'), 'M�ximo poss�vel')
    qtdModulos = 0;
elseif strcmpi(get(selecionado, 'String'), 'Testar:')
    modo = 2;
    qtdModulos = str2double(handles.etQtdmodulos.String);
end
