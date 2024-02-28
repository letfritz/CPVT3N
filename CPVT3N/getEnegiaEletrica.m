%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/t�rmico 
%          considerando reservat�rio estratificado em 3 n�veis
% ARQUIVO: C�digo de energia el�trica de um �nico m�dulo CPVT
% NOME: LET�CIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVIS�O: 27/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ELE] = getEnegiaEletrica(COLETOR,CURVA,TER,granularidade)

    % Pot�ncia de uma �nica c�lula por dia [kWh/xmin]
    ELE.P_cell = COLETOR.efic_opt*COLETOR.A_cell*COLETOR.CF*...
        COLETOR.fator_imperfeicao*TER.efic_cell.*CURVA.vDNI;
    
    % Pot�ncia El�trica Real de uma c�lula [kWh/xmin]
    ELE.P_cell_real = TER.coef_termico.*ELE.P_cell;
    
    % Pot�ncia el�trica liberada pelo m�dulo [kWh/xmin]
    ELE.P_modulo = COLETOR.num_cell*COLETOR.efic_modulo*ELE.P_cell_real;
    
    % Perdas da corrente parasita gerada pelo m�dulo por dia [kWh/xmin]
    ELE.Perdas_par = COLETOR.p_par*COLETOR.A_cell*COLETOR.CF*...
        COLETOR.num_cell*CURVA.vDNI;
    
    % Pot�ncia el�trica de um m�dulo considerando as perdas [kWh/xmin]
    ELE.P_modulo_real = (ELE.P_modulo-ELE.Perdas_par)*...
        COLETOR.efic_inversor;
    
    % Converter minutos em horas
    tempo = 60/granularidade;
    
    % Energia el�trica de um m�dulo [kW]
    ELE.P_modulo_real_total = sum(ELE.P_modulo_real)/tempo;
    
end