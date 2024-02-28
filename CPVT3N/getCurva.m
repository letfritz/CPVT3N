%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/t�rmico 
%          considerando reservat�rio estratificado em 3 n�veis
% ARQUIVO: C�digo que carrega as curvas de entrada no programa
% NOME: LET�CIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVIS�O: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IRRADI�NCIA
CURVA.vDNI = xlsread('CURVA/DNI.xlsx');

%% CURVA DE TEMPERATURA
CURVA.vTemperatura = xlsread('CURVA/TemperaturaAmbiente.xlsx');

%% CURVA DE CONSUMO
CURVA.T_consumo = xlsread('CURVA/TemperaturaConsumo.xlsx');

%% CONSUMO DE �GUA
CURVA.vAguaL = xlsread('CURVA/ConsumoAgua.xlsx');
