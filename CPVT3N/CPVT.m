%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/t�rmico 
%          considerando reservat�rio estratificado em 3 n�veis
% ARQUIVO: C�digo iterativo com a simula��o do CPVT
% NOME: LET�CIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVIS�O: 27/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [RESERVATORIO,TER,ELE,qtdModulos] = CPVT(maxPontos,COLETOR,...
    CURVA,GERAL,RESERVATORIO,granularidade,qtdModulos)
    
    %% QUANTIDADE M�XIMA DE CPV/T POR RESERVAT�RIO
    % Pode ter reservat�rio associado a mais de um m�dulo CPV/T
    
    % ENCONTRA QUANTIDADE DE M�DULOS POR RESERVAT�RIO
    if qtdModulos == 0
        qtdModulos = getQtdModulos(CURVA,COLETOR,RESERVATORIO,GERAL,...
            maxPontos,granularidade);
    end
    
    %% ESTRATIFICA��O DE 1 RESERVAT�RIO
    % Teste com n�mero m�ximo de m�dulos CPVT encontrados
    [RESERVATORIO,Ts,Q_modulo_real,T_placa,T_cell,efic_cell,...
        coef_termico,mass_flow] = getReservatorio(RESERVATORIO,COLETOR,...
        GERAL,CURVA,qtdModulos,maxPontos,granularidade);
    
    % Valida��o do resultado
    while isreal(RESERVATORIO.Tagua(maxPontos,1)) == 0 && (qtdModulos > 1)
        qtdModulos = qtdModulos - 1;
        [RESERVATORIO,Ts,Q_modulo_real,T_placa,T_cell,efic_cell,...
            coef_termico,mass_flow] = getReservatorio(RESERVATORIO,...
            COLETOR,GERAL,CURVA,qtdModulos,maxPontos,granularidade);
    end
    
    % Organizando os dados da parte t�rmica de um m�dulo CPV/T
    TER.Ts = Ts;
    TER.Q_modulo_real = Q_modulo_real;
    TER.T_placa = T_placa;
    TER.T_cell = T_cell;
    TER.efic_cell = efic_cell;
    TER.coef_termico = coef_termico;
    TER.mass_flow = mass_flow;
    
    %% ENERGIA EL�TRICA DE UM M�DULO
    [ELE] = getEnegiaEletrica(COLETOR,CURVA,TER,granularidade);
    
end