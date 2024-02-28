%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Código de quantidade de módulos que cabem em um reservatório
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 27/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function qtdModulos = getQtdModulos(CURVA,COLETOR,RESERVATORIO,GERAL,...
    maxPontos,granularidade)

    %% PARÂMETROS CONSTRUTIVOS
        
    % Área do trocador de calor [m²]
    Ac = 2*pi*(RESERVATORIO.d/2)*COLETOR.largura;
    
    % Área da placa
    Ap = COLETOR.A_modulo; %COLETOR.A_cell*COLETOR.num_cell;
    
    % Condutividade Térmica do Cobre [J/s.m.K]
    kcob = 398;
    
    % Tensão de circuito aberto
    Voc = 2.5847+0.085283*log(COLETOR.CF);
    Voc_0 = 2.5847+0.085283*log(1);
    
    %% ESTRATIFICAÇÃO DA ÁGUA
    qtdModulos = 1;
    status = 1;
    while (status == 1)
        qtdModulos = qtdModulos+1;
        minuto = 1;
        
        % Energia Elétrica da Resistência que esquenta a água do nível 1
        RESERVATORIO.Q_eleVetor = 0;
        
        % Temperatura inicial da agua
        RESERVATORIO.Tagua = RESERVATORIO.Tagua_orig;
        
        % Temperatura do reservatório
        RESERVATORIO.T(1) = RESERVATORIO.Tagua(1,1);
        RESERVATORIO.T(2:3) = RESERVATORIO.T(1);
        RESERVATORIO.T(4) = CURVA.vTemperatura(1,1)+273+2;
        
        % Temperatura de saída inicial
        Ts = zeros(maxPontos+1,1);
        
        % Temperatura da placa
        T_placa = CURVA.vTemperatura(1,1)+273;
        
        % Temperatura da Célula
        T_cell = zeros(maxPontos,1);
        T_cell(1,1) = CURVA.vTemperatura(1,1)+273;
        
        % Vazão
        mass_flow = zeros(maxPontos,1);
        
        % Volume de água extraido
        mConsumoL = zeros(maxPontos,2);
        
        % Perdas de Temperatura por Condução
        perda = zeros(maxPontos,3);
        
        % Energia térmica gerada
        Q_modulo_real = zeros(maxPontos,1);
        
        while (minuto <= maxPontos) && (status == 1)

            % Massa total de água que passa pelo coletor [kg]
            mpontoc = qtdModulos*mass_flow(minuto,1)*60*granularidade;
            % Massa que entra no reservatório não pode ser maior que passa
            % de um dos níveis
            if mpontoc > RESERVATORIO.massa(1,1)
                status = 0;
            end
            
            % Massa de água nos níveis
            massaNivel = zeros(1,4);
            
            % Temperatura ambiente [K]
            Ta = CURVA.vTemperatura(minuto,1)+273;
            
            % Temperatura da célula [K]
            if CURVA.vDNI(minuto,1)<0.1
                T_cell(minuto,1) = Ta+...
                    (Voc-Voc_0)/...
                    abs(-0.006424+0.00036233*log(COLETOR.CF)*100);
            else
                T_cell(minuto,1) = T_placa(minuto,1)+...
                    (((Q_modulo-Q_perdido+COLETOR.Q_gerado)*...
                    COLETOR.Lplaca)/(6*kcob*Ac))+...
                    (Voc-Voc_0)/abs(-0.006424+0.00036233*...
                    log(COLETOR.CF)*100);
                T_cell_aux = [COLETOR.emiss*GERAL.constSB*Ap,0,0,...
                    (COLETOR.coef_ConvMedio*Ap+...
                    (6*kcob*Ac/COLETOR.Lplaca)),...
                    -((Q_modulo)+COLETOR.coef_ConvMedio*Ap*Ta+...
                    COLETOR.emiss*GERAL.constSB*Ap*(Ta^4)+...
                    ((6*kcob*Ac/COLETOR.Lplaca)*T_placa(minuto,1)))];
                try
                    T_cell_aux = roots(T_cell_aux);
                    for n = 1:4
                        if isreal(T_cell_aux(n))
                            if (T_cell_aux(n)>Ta && T_cell_aux(n)<600)
                                T_cell(minuto,1) = T_cell_aux(n) + ...
                                    (Voc-Voc_0)/abs(-0.006424+...
                                    0.00036233*log(COLETOR.CF)*100);
                            end
                        end
                    end
                catch
                    status = 0;
                    T_cell(minuto,1) = T_placa(minuto,1)+...
                        (((Q_modulo-Q_perdido+COLETOR.Q_gerado)*...
                        COLETOR.Lplaca)/(6*kcob*Ac))+...
                        (Voc-Voc_0)/abs(-0.006424+0.00036233*...
                        log(COLETOR.CF)*100);
                end
            end
            
            % Eficiência da célula fotovoltaica
            efic_cell = COLETOR.efic_ref+...
                ((-0.09167+0.005787*log(COLETOR.CF))/100)*...
                (T_cell(minuto,1)-273-25);
            
            % Coeficiente de potência térmico
            coef_termico = 1+COLETOR.coef_temperatura*...
                (T_cell(minuto,1)-273-25);
            
            % Eficiência do módulo concentrador fotovoltaico
            efic_PV = efic_cell*COLETOR.efic_modulo*coef_termico;
            
            % Proveniente do coletor
            if Ts(minuto,1)>=RESERVATORIO.Tagua(minuto,1)
                RESERVATORIO.Fc(1,1) = 1;
                RESERVATORIO.Fc(2,1) = 0;
                RESERVATORIO.Fc(3,1) = 0;
            elseif ((Ts(minuto,1)<RESERVATORIO.Tagua(minuto,1)) && ...
                    (Ts(minuto,1)>RESERVATORIO.Tagua(minuto,2)))
                RESERVATORIO.Fc(1,1) = 0;
                RESERVATORIO.Fc(2,1) = 1;
                RESERVATORIO.Fc(3,1) = 0;
            elseif (Ts(minuto,1)<RESERVATORIO.Tagua(minuto,2))
                RESERVATORIO.Fc(1,1) = 0;
                RESERVATORIO.Fc(2,1) = 0;
                RESERVATORIO.Fc(3,1) = 1;
            end
            
            % Proveniente da bomba de abastecimento
            if RESERVATORIO.TL>RESERVATORIO.Tagua(minuto,1)
                RESERVATORIO.FL(1,1) = 1;
                RESERVATORIO.FL(2,1) = 0;
                RESERVATORIO.FL(3,1) = 0;
            elseif (RESERVATORIO.TL<=RESERVATORIO.Tagua(minuto,1)) && ...
                    (RESERVATORIO.TL>RESERVATORIO.Tagua(minuto,2))
                RESERVATORIO.FL(1,1) = 0;
                RESERVATORIO.FL(2,1) = 1;
                RESERVATORIO.FL(3,1) = 0;
            elseif RESERVATORIO.TL<=RESERVATORIO.Tagua(minuto,2)
                RESERVATORIO.FL(1,1) = 0;
                RESERVATORIO.FL(2,1) = 0;
                RESERVATORIO.FL(3,1) = 1;
            end
            
            % Quando o reservatório abastece a demanda de água
            if (CURVA.vAguaL(minuto,1)>0)
                % Considerando que os reservatórios operam em conjunto
                mConsumoL(minuto,1) = CURVA.vAguaL(minuto,1);
                if (CURVA.T_consumo(minuto,1)+273)>RESERVATORIO.TL
                    [CURVA,RESERVATORIO,mConsumoL,massaNivel] = ...
                        getConsumoAgua(CURVA,RESERVATORIO,mConsumoL,...
                        massaNivel,minuto);
                end
            end

            % Temperatura do recipiente do reservatório
            Tabsoluta = (Ta+RESERVATORIO.T(minuto,1))/2;

            if ((RESERVATORIO.T(minuto,4)>Ta) || (minuto==1))
                % Número de Rayleigh
                beta = 1/Tabsoluta;
                [alfaArf,~,~] = getDifusividade((Ta+...
                    RESERVATORIO.T(minuto,4))/2);
                [vArf,~] = getViscosidade((Ta+RESERVATORIO.T(minuto,4))/2);
                RaD = GERAL.g*beta*(RESERVATORIO.T(minuto,4)-Ta)*...
                    (RESERVATORIO.D_ext^3)/(vArf*alfaArf);
                
                % Número de Prandtl
                Pr = getPrandtl(RESERVATORIO.T(minuto,4));
                
                % Número de Nusselt
                NuD = (0.387+((0.387*RaD^(1/6))/...
                    ((1+((0.492/Pr)^(9/16)))^(8/27))))^2;
                
                % Convecção Natural ao redor do Reservatório
                h4 = (NuD*GERAL.k_ar)/RESERVATORIO.D_ext;
                
                % Coeficiente de perda global do reservatório
                Ures = 1/((RESERVATORIO.r(1)/RESERVATORIO.k(1))...
                    *log(RESERVATORIO.r(2)/RESERVATORIO.r(1))+...
                    (RESERVATORIO.r(1)/RESERVATORIO.k(2))...
                    *log(RESERVATORIO.r(3)/RESERVATORIO.r(2))+...
                    (RESERVATORIO.r(1)/RESERVATORIO.k(3))...
                    *log(RESERVATORIO.r(4)/RESERVATORIO.r(3))+...
                    (RESERVATORIO.r(1)/RESERVATORIO.r(4))*(1/h4));
            end

            % Taxa radial de trasferência de calor no regime estacionário
            Aint = 2*pi*RESERVATORIO.r(1)*RESERVATORIO.LTubo;
            qr = (Ures/3)*(Aint/3);
            
            % Calor Específico da Água
            try
                [~,cp1,~,~,~] = getEqAgua(RESERVATORIO.Tagua(minuto,1));
                cp1 = cp1/RESERVATORIO.massa(1,1);
                [~,cp2,~,~,~] = getEqAgua(RESERVATORIO.Tagua(minuto,2));
                cp2 = cp2/RESERVATORIO.massa(2,1);
                [~,cp3,~,~,~] = getEqAgua(RESERVATORIO.Tagua(minuto,3));
                cp3 = cp3/RESERVATORIO.massa(3,1);
            catch
                status = 0;
                cp1 = 4200/RESERVATORIO.massa(1,1);
                cp2 = 4200/RESERVATORIO.massa(1,1);
                cp3 = 4200/RESERVATORIO.massa(1,1);
            end
            
            % Coeficiente de Perda Global
            perda(minuto,1)=(qr/cp1)*(Tabsoluta-...
                RESERVATORIO.Tagua(minuto,1))/100;
            perda(minuto,2)=(qr/cp2)*(Tabsoluta-...
                RESERVATORIO.Tagua(minuto,2))/100;
            perda(minuto,3)=(qr/cp3)*(Tabsoluta-...
                RESERVATORIO.Tagua(minuto,3))/100;

            % Estratificação do Reservatorio
            RESERVATORIO = getEstratificacao(RESERVATORIO,massaNivel,...
                mpontoc,Ts,perda,minuto);
            
            %% ATUALIZAÇÃO DA TEMPERATURA DO MATERIAL DO RESERVATÓRIO

            RESERVATORIO.T(minuto+1,1) = ...
                sum(RESERVATORIO.Tagua(minuto,:))/3;
            RESERVATORIO.T(minuto+1,2) = RESERVATORIO.T(minuto,1)-...
                qr*log10(RESERVATORIO.r(2)/RESERVATORIO.r(1))/...
                (2*pi*RESERVATORIO.LTubo*RESERVATORIO.k(1));
            RESERVATORIO.T(minuto+1,3) = RESERVATORIO.T(minuto,2)-...
                (qr*log10(RESERVATORIO.r(3)/RESERVATORIO.r(2)))/...
                (2*pi*RESERVATORIO.LTubo*RESERVATORIO.k(2));
            RESERVATORIO.T(minuto+1,4) = RESERVATORIO.T(minuto,3)-...
                qr*log10(RESERVATORIO.r(4)/RESERVATORIO.r(3))/...
                (2*pi*RESERVATORIO.LTubo*RESERVATORIO.k(3));

            %% EQUAÇÕES DA POTÊNCIA TÉRMICA DO FLUIDO DE SAIDA DO COLETOR

            % Potência térmica ideal do módulo [kW]
            Q_modulo = (1-efic_PV)*COLETOR.efic_opt*COLETOR.CF*...
                CURVA.vDNI(minuto,1)*COLETOR.fator_imperfeicao*...
                COLETOR.A_cell*COLETOR.num_cell;
            
            % Potência térmica dispersada devido a radiação e convecção[kW]
            Q_perdido = ((COLETOR.coef_ConvMedio*...
                (T_cell(minuto,1)-Ta)+COLETOR.emiss*GERAL.constSB*...
                (((T_cell(minuto,1))^4)-(Ta^4)))*COLETOR.A_cell*...
                COLETOR.num_cell)/1000;
            
            % Potência térmica liberada pelo módulo com as perdas [kW]
            Q_modulo_real(minuto,1) = (Q_modulo-Q_perdido+...
                COLETOR.Q_gerado);
            if Q_modulo_real(minuto,1)<0
                Q_modulo_real(minuto,1) = 0;
            end
            
            %% CÁLCULO DA TEMPERATURA DE SAÍDA DO COLETOR
            
            % Temperatura da placa [K]
            T_placa(minuto+1,1) = T_cell(minuto,1)-...
                Q_modulo_real(minuto,1)/(6*kcob*Ac/COLETOR.Lplaca);

            if CURVA.vDNI(minuto,1)>0.1
                try
                    % Condutividade do substrato [kW/m*K]
                    [densidade,cpH2O,uH2O,condutividade,PrH2O] = ...
                        getEqAgua(RESERVATORIO.Tagua(minuto,3));
                catch
                    status = 0;
                end
                    
                % Temperatura de saída do fluido para uma célula
                % (1kW = 1000J/s)
                relacaoDNI = CURVA.vDNI(minuto,1)/mean(CURVA.vDNI);
                if relacaoDNI<0.8 % Mínimo é 88 ºC
                    relacaoDNI = 0.895;
                elseif relacaoDNI>1.5 % Máximo é 165 ºC
                    relacaoDNI = 1.5;
                end
                Ts(minuto+1,1) = 373*relacaoDNI; % 110 ºC
                
                % Vazão mássica [kg/s]
                mass_flow(minuto+1,1) = Q_modulo_real(minuto,1)/...
                    (cpH2O*(Ts(minuto+1,1)-...
                    RESERVATORIO.Tagua(minuto+1,3)));

                %% Cálculo do Coeficiente convectivo da água
                    % Mass Flow Rate [kg/s]
                    velocidade = mass_flow(minuto+1,1)/...
                        (densidade*pi*(RESERVATORIO.d^2)/4);
                    mass_flow(minuto+1,1) = densidade*velocidade*...
                        (pi*(RESERVATORIO.d/2)^2);

                    % Número de Reynolds
                    Reynolds = (4*mass_flow(minuto+1,1))/...
                        (uH2O*pi*RESERVATORIO.d);

                    % Número de Nusselt
                    Nusselt = 0.023*(Reynolds^0.8*PrH2O^.4);

                    % Coeficiente convectivo da água
                    h_agua = (Nusselt*condutividade)/(RESERVATORIO.d);
                
                %% Temperatura da placa [K]
                T_placa(minuto+1,1) = (RESERVATORIO.Tagua(minuto+1,3)-...
                    exp((h_agua*Ac)/((mass_flow(minuto+1,1)/6)*...
                    (cpH2O)))*Ts(minuto+1,1))/...
                    (1-exp((h_agua*Ac)/((mass_flow(minuto+1,1)/6)*...
                    (cpH2O))));
                
                %% Temperatura de saída do coletor
                Ts(minuto+1,1) = T_placa(minuto+1,1)-...
                    ((T_placa(minuto+1,1)-RESERVATORIO.Tagua(minuto,3))/...
                    (exp((h_agua*Ac)/((mass_flow(minuto+1,1))*(cpH2O)))));
                % Temperatura da placa [K]
                T_placa(minuto+1,1) = (RESERVATORIO.Tagua(minuto+1,3)-...
                    exp((h_agua*Ac)/((mass_flow(minuto+1,1)/6)*...
                    (cpH2O)))*Ts(minuto+1,1))/...
                    (1-exp((h_agua*Ac)/((mass_flow(minuto+1,1)/6)*...
                    (cpH2O))));
                
                %% Nova Energia Térmica
                Q_modulo_real(minuto,1) = mass_flow(minuto+1,1)*cpH2O*...
                    (Ts(minuto+1,1)-RESERVATORIO.Tagua(minuto+1,3))/1000;
                
            else
                Ts(minuto+1,1) = 0;
                T_placa(minuto+1,1) = T_cell(minuto,1);
            end
            
            % Verficando critério de parada
            %   1. Temperatura da Placa não pode exceder 220 ºC
            %   2. Temperatura de Saída do coletor não pode exceder 110ºC
            %   3. Temperatura do Nível 1 não pode exceder 100 ºC
            %   3. Temperatura do Nível 3 não pode exceder 50 ºC
            if ((T_placa(minuto+1,1)>493) || (Ts(minuto+1,1)>383) || ...
                    (RESERVATORIO.Tagua(minuto+1,3)>373) || ...
                    (RESERVATORIO.Tagua(minuto+1,3)>373))
                status = 0;
            end

            minuto = minuto+1;
        end
        
    end
    
    % Correção da capacidade
    qtdModulos = qtdModulos - 1;
    
end