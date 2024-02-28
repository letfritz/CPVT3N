%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Código que carrega as curvas de entrada no programa
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IRRADIÂNCIA
CURVA.vDNI = xlsread('CURVA/DNI.xlsx');

%% CURVA DE TEMPERATURA
CURVA.vTemperatura = xlsread('CURVA/TemperaturaAmbiente.xlsx');

%% CURVA DE CONSUMO
CURVA.T_consumo = xlsread('CURVA/TemperaturaConsumo.xlsx');

%% CONSUMO DE ÁGUA
CURVA.vAguaL = xlsread('CURVA/ConsumoAgua.xlsx');
