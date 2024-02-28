%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Código principal em MATLAB
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 27/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% DADOS DE ENTRADA
    % Dados de entrada carregados na interface
    getInput();
    % Curvas de entrada carregadas na pasta "\Curva"
    getCurva();
    % Granularidade da curva
    granularidade = str2double(handles.txGranularidade.String);
    % Total de pontos das curvas
    maxPontos = length(CURVA.vDNI);
    % Gerando matriz para computar a saída dos dados
    OUTPUT = getConfigOutput(maxPontos);

%% CPV/T SIMULAÇÃO

    [RESERVATORIO,TER,ELE,qtdModulos] = CPVT(maxPontos,COLETOR,CURVA,...
        GERAL,RESERVATORIO,granularidade,qtdModulos);
    
%% EXPORTANDO DADOS DE SAÍDA SAÍDA

    getOutput();
