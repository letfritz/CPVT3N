%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Dados de entrada carregados com informações da interface
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% GERAL

% Aceleração da gravidade
GERAL.g = str2double(handles.txGravidade.String);%9.8;

% Constante de Stefan-Boltzmann [W/(m².K^4)]
GERAL.constSB = 5.670367*10^(-8);

% Condutividade térmica do ar [W/mK]
GERAL.k_ar = str2double(handles.txAr.String);%0.023;

%% COLETOR

% Número de célular fotovoltaicas no módulo (Pode ser de 60 à 120)
COLETOR.num_cell = str2double(handles.txNumcell.String);%90;

% Fator de concentração (Pode ser de 600 à 1200)
COLETOR.CF = str2double(handles.txFc.String);%900;

% Área padrão de um módulo CPV/T [m2]
COLETOR.comprimento = str2double(handles.txComp.String);%5.94;
COLETOR.largura = str2double(handles.txLag.String);%2.43;
COLETOR.A_modulo = COLETOR.comprimento*COLETOR.largura;

% Área padrão de uma célula do módulo CPV/T [m2]
COLETOR.A_cell = 81*10^-6;

% Espessura da placa de alumínio [m]
COLETOR.Lplaca = str2double(handles.txLplaca.String);%0.004;

% Eficiência correspondente ao fator de concentração escolhido
% (existe uma curva para isso)
COLETOR.efic_ref = str2double(handles.txEfic_ref.String);%0.35;

% Eficiência Óptica
COLETOR.efic_opt = str2double(handles.txEfic_opt.String);%0.85;

% Eficiência do inversor [%]
COLETOR.efic_inversor = str2double(handles.txEfic_inv.String);%0.9;

% Eficiência de um módulo
% (Este valor leva em consideração o arranjo das células)
COLETOR.efic_modulo = str2double(handles.txEfic_mod.String);%0.9;

% Fator considerado pelas imperfeições do sistema
COLETOR.fator_imperfeicao = str2double(handles.txFt_imp.String);%0.9;

% Coeficiente de temperatura dependente do tipo de célula [1/ºC]
COLETOR.coef_temperatura = str2double(handles.txCf_temp.String);%-0.0016;

% Fator de perda das correntes parasitas dependendo da radiação
COLETOR.p_par = str2double(handles.txFt_par.String);%0.023;

% Fator de emissividade da célula
COLETOR.emiss = str2double(handles.txEmiss.String);%0.85;

% Quantidade de calor gerado internamente pelo equipamento [kW]
COLETOR.Q_gerado = 0.0;

% Coeficiente convectivo médio para célula [W/(m².K)]
% [A miniature concentrating photovoltaic and thermal system]
COLETOR.coef_ConvMedio = str2double(handles.txConvmedio.String);%5;

%% RESERVATÓRIO

% Temperatura inicial da agua
RESERVATORIO.Tagua_orig = str2double(handles.txTempH2O.String)*ones(1,3)...
    +273; %30

% Temperatura da água que vem da rede de abastecimento
RESERVATORIO.TL = str2double(handles.txTempnew.String)+273; %23

% Diâmetro da tubulação [m] (lado da célula, Renno)
RESERVATORIO.d = str2double(handles.txDim.String);%0.05;

% Condutividade Térmica [W/mK]
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
        
% Massa de água
allItems = get(handles.pmVolume,'string');
selectedIndex = get(handles.pmVolume,'Value');
selectedItem = allItems{selectedIndex};
RESERVATORIO.massa = (str2double(selectedItem)/3)*ones(3,1);

% Temperatura de operação do termostato
RESERVATORIO.Termostato = 50 + 273;

%% Modo de simualção
selecionado = get(handles.uipQtdmodulos, 'SelectedObject');
if strcmpi(get(selecionado, 'String'), 'Apenas 1')
    qtdModulos = 1;
elseif strcmpi(get(selecionado, 'String'), 'Máximo possível')
    qtdModulos = 0;
elseif strcmpi(get(selecionado, 'String'), 'Testar:')
    modo = 2;
    qtdModulos = str2double(handles.etQtdmodulos.String);
end
