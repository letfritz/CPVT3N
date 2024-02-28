%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Código de energia elétrica de um único módulo CPVT
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 27/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ELE] = getEnegiaEletrica(COLETOR,CURVA,TER,granularidade)

    % Potência de uma única célula por dia [kWh/xmin]
    ELE.P_cell = COLETOR.efic_opt*COLETOR.A_cell*COLETOR.CF*...
        COLETOR.fator_imperfeicao*TER.efic_cell.*CURVA.vDNI;
    
    % Potência Elétrica Real de uma célula [kWh/xmin]
    ELE.P_cell_real = TER.coef_termico.*ELE.P_cell;
    
    % Potência elétrica liberada pelo módulo [kWh/xmin]
    ELE.P_modulo = COLETOR.num_cell*COLETOR.efic_modulo*ELE.P_cell_real;
    
    % Perdas da corrente parasita gerada pelo módulo por dia [kWh/xmin]
    ELE.Perdas_par = COLETOR.p_par*COLETOR.A_cell*COLETOR.CF*...
        COLETOR.num_cell*CURVA.vDNI;
    
    % Potência elétrica de um módulo considerando as perdas [kWh/xmin]
    ELE.P_modulo_real = (ELE.P_modulo-ELE.Perdas_par)*...
        COLETOR.efic_inversor;
    
    % Converter minutos em horas
    tempo = 60/granularidade;
    
    % Energia elétrica de um módulo [kW]
    ELE.P_modulo_real_total = sum(ELE.P_modulo_real)/tempo;
    
end