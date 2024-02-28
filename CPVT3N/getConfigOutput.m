%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Código de criação de matriz de resultados
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 27/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [OUTPUT] = getConfigOutput(maxPontos)
    % Diretório dos resultados
    OUTPUT.filename = [pwd '\Resultado'];
    
    % Cabeçalho dos resultados
    OUTPUT.col_CPVT={'DNI[kW/m²]','Temperatura[ºC]',...
        'TemperaturaConsumo[ºC]','CargaAgua[L]','GeracaoEletrica[kW]',...
        'GeracaoTermica[kWt]','TemperaturaTs1[ºC]','TemperaturaTs2[ºC]',...
        'TemperaturaTs3[ºC]','TemperaturaSaidaColetor[ºC]',...
        'TemperaturaPlaca[ºC]','TemperaturaCelula[ºC]',...
        'VazãoMássica [kg/s]','EficiênciaCélula [%]',...
        'CoeficienteTermicoCelula'};

    % Matriz dos resultados
    OUTPUT.result = repmat({'0'},maxPontos,length(OUTPUT.col_CPVT));
end
