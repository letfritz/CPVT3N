%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Código para exportar matriz de saída dos resultados
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 27/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ORGANIZANDO MATRIZ DE RESULTADOS
    % DNI [kW/m²]
    for n = 1:maxPontos
        OUTPUT.result{n,1} = CURVA.vDNI(n,1);
    end
    
    % Temperatura[ºC]
    for n = 1:maxPontos
        OUTPUT.result{n,2} = CURVA.vTemperatura(n,1);
    end
    
    % TemperaturaConsumo[ºC]
    for n = 1:maxPontos
        OUTPUT.result{n,3} = CURVA.T_consumo(n,1);
    end
    
    % CargaAgua[L]
    for n = 1:maxPontos
        OUTPUT.result{n,4} = CURVA.vAguaL(n,1);
    end
    
    % GeracaoEletrica[kW]
    for n = 1:maxPontos
        OUTPUT.result{n,5} = ELE.P_modulo_real(n,1);
    end
    
    %GeracaoTermica[kWt]
    for n = 1:maxPontos
        OUTPUT.result{n,6} = TER.Q_modulo_real(n,1);
    end
    
    %TemperaturaTs1[ºC]
    for n = 1:maxPontos
        OUTPUT.result{n,7} = RESERVATORIO.Tagua(n,1) - ...
            273*ones(length(RESERVATORIO.Tagua(n,1)),1);
    end
    
    %TemperaturaTs2[ºC]
    for n = 1:maxPontos
        OUTPUT.result{n,8} = RESERVATORIO.Tagua(n,2) - ...
            273*ones(length(RESERVATORIO.Tagua(n,1)),1);
    end
    
    %TemperaturaTs3[ºC]
    for n = 1:maxPontos
        OUTPUT.result{n,9} = RESERVATORIO.Tagua(n,3) - ...
            273*ones(length(RESERVATORIO.Tagua(n,1)),1);
    end
    
    %TemperaturaSaidaColetor[ºC]
    for n = 1:maxPontos
        OUTPUT.result{n,10} = TER.Ts(n,1);
    end
    
    %TemperaturaPlaca[ºC]
    for n = 1:maxPontos
        OUTPUT.result{n,11} = TER.T_placa(n,1);
    end
    
    %TemperaturaCelula[ºC]
    for n = 1:maxPontos
        OUTPUT.result{n,12} = TER.T_cell(n,1);
    end
    
    % VazãoMássica [kg/s]
    for n = 1:maxPontos
        OUTPUT.result{n,13} = TER.mass_flow(n,1);
    end
    
    % EficiênciaCélula [%]
    for n = 1:maxPontos
        OUTPUT.result{n,14} = TER.efic_cell(n,1);
    end
    
    % CoeficienteTermicoCelula
    for n = 1:maxPontos
        OUTPUT.result{n,15} = TER.coef_termico(n,1);
    end

    % Unindo informação e cabeçalho
    output = [OUTPUT.col_CPVT;OUTPUT.result];

%% EXPORTANDO RESULTADOS
    % Planilha com dados
    info = {'As colunas de geração térmica e elétrica, vazão mássica', ...
        ', temperatura de saída do coletor e temperatura da placa são', ...
        'referentes a um único módulo CPVT. Já as colunas de ', ...
        'temperatura do reservatório estratificado referem-se a ', ...
        'quantidade de ', num2str(qtdModulos), 'módulos associados ao', ...
        ' reservatório injetando a mesma condição de vazão mássica e ', ...
        'sobre mesma condição ambiente.'};
    xlswrite([OUTPUT.filename '\Resultados.xlsx'],info,1);
    xlswrite([OUTPUT.filename '\Resultados.xlsx'],output,2);
    
    % Workspace
    save([OUTPUT.filename '\TER.mat']);
    save([OUTPUT.filename '\ELE.mat']);
    save([OUTPUT.filename '\RESERVATORIO.mat']);
    save([OUTPUT.filename '\CURVA.mat']);
    save([OUTPUT.filename '\COLETOR.mat']);
    save([OUTPUT.filename '\GERAL.mat']);
    save([OUTPUT.filename '\maxPontos.mat']);
    save([OUTPUT.filename '\granularidade.mat']);
    save([OUTPUT.filename '\qtdModulos.mat']);
    