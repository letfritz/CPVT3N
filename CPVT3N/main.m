%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/t�rmico 
%          considerando reservat�rio estratificado em 3 n�veis
% ARQUIVO: C�digo principal em MATLAB
% NOME: LET�CIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVIS�O: 27/07/2021
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
    % Gerando matriz para computar a sa�da dos dados
    OUTPUT = getConfigOutput(maxPontos);

%% CPV/T SIMULA��O

    [RESERVATORIO,TER,ELE,qtdModulos] = CPVT(maxPontos,COLETOR,CURVA,...
        GERAL,RESERVATORIO,granularidade,qtdModulos);
    
%% EXPORTANDO DADOS DE SA�DA SA�DA

    getOutput();
