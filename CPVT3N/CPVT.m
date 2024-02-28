%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Código iterativo com a simulação do CPVT
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 27/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [RESERVATORIO,TER,ELE,qtdModulos] = CPVT(maxPontos,COLETOR,...
    CURVA,GERAL,RESERVATORIO,granularidade,qtdModulos)
    
    %% QUANTIDADE MÁXIMA DE CPV/T POR RESERVATÓRIO
    % Pode ter reservatório associado a mais de um módulo CPV/T
    
    % ENCONTRA QUANTIDADE DE MÓDULOS POR RESERVATÓRIO
    if qtdModulos == 0
        qtdModulos = getQtdModulos(CURVA,COLETOR,RESERVATORIO,GERAL,...
            maxPontos,granularidade);
    end
    
    %% ESTRATIFICAÇÃO DE 1 RESERVATÓRIO
    % Teste com número máximo de módulos CPVT encontrados
    [RESERVATORIO,Ts,Q_modulo_real,T_placa,T_cell,efic_cell,...
        coef_termico,mass_flow] = getReservatorio(RESERVATORIO,COLETOR,...
        GERAL,CURVA,qtdModulos,maxPontos,granularidade);
    
    % Validação do resultado
    while isreal(RESERVATORIO.Tagua(maxPontos,1)) == 0 && (qtdModulos > 1)
        qtdModulos = qtdModulos - 1;
        [RESERVATORIO,Ts,Q_modulo_real,T_placa,T_cell,efic_cell,...
            coef_termico,mass_flow] = getReservatorio(RESERVATORIO,...
            COLETOR,GERAL,CURVA,qtdModulos,maxPontos,granularidade);
    end
    
    % Organizando os dados da parte térmica de um módulo CPV/T
    TER.Ts = Ts;
    TER.Q_modulo_real = Q_modulo_real;
    TER.T_placa = T_placa;
    TER.T_cell = T_cell;
    TER.efic_cell = efic_cell;
    TER.coef_termico = coef_termico;
    TER.mass_flow = mass_flow;
    
    %% ENERGIA ELÉTRICA DE UM MÓDULO
    [ELE] = getEnegiaEletrica(COLETOR,CURVA,TER,granularidade);
    
end