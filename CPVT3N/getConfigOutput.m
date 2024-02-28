%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/t�rmico 
%          considerando reservat�rio estratificado em 3 n�veis
% ARQUIVO: C�digo de cria��o de matriz de resultados
% NOME: LET�CIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVIS�O: 27/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [OUTPUT] = getConfigOutput(maxPontos)
    % Diret�rio dos resultados
    OUTPUT.filename = [pwd '\Resultado'];
    
    % Cabe�alho dos resultados
    OUTPUT.col_CPVT={'DNI[kW/m�]','Temperatura[�C]',...
        'TemperaturaConsumo[�C]','CargaAgua[L]','GeracaoEletrica[kW]',...
        'GeracaoTermica[kWt]','TemperaturaTs1[�C]','TemperaturaTs2[�C]',...
        'TemperaturaTs3[�C]','TemperaturaSaidaColetor[�C]',...
        'TemperaturaPlaca[�C]','TemperaturaCelula[�C]',...
        'Vaz�oM�ssica [kg/s]','Efici�nciaC�lula [%]',...
        'CoeficienteTermicoCelula'};

    % Matriz dos resultados
    OUTPUT.result = repmat({'0'},maxPontos,length(OUTPUT.col_CPVT));
end
