%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/t�rmico 
%          considerando reservat�rio estratificado em 3 n�veis
% ARQUIVO: C�digo de quantidade de m�dulos que cabem em um reservat�rio
% NOME: LET�CIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVIS�O: 27/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function qtdModulos = getQtdModulos(CURVA,COLETOR,RESERVATORIO,GERAL,...
    maxPontos,granularidade)

    %% PAR�METROS CONSTRUTIVOS
        
    % �rea do trocador de calor [m�]
    Ac = 2*pi*(RESERVATORIO.d/2)*COLETOR.largura;
    
    % �rea da placa
    Ap = COLETOR.A_modulo; %COLETOR.A_cell*COLETOR.num_cell;
    
    % Condutividade T�rmica do Cobre [J/s.m.K]
    kcob = 398;
    
    % Tens�o de circuito aberto
    Voc = 2.5847+0.085283*log(COLETOR.CF);
    Voc_0 = 2.5847+0.085283*log(1);
    
    %% ESTRATIFICA��O DA �GUA
    qtdModulos = 1;
    status = 1;
    while (status == 1)
        qtdModulos = qtdModulos+1;
        minuto = 1;
        
        % Energia El�trica da Resist�ncia que esquenta a �gua do n�vel 1
        RESERVATORIO.Q_eleVetor = 0;
        
        % Temperatura inicial da agua
        RESERVATORIO.Tagua = RESERVATORIO.Tagua_orig;
        
        % Temperatura do reservat�rio
        RESERVATORIO.T(1) = RESERVATORIO.Tagua(1,1);
        RESERVATORIO.T(2:3) = RESERVATORIO.T(1);
        RESERVATORIO.T(4) = CURVA.vTemperatura(1,1)+273+2;
        
        % Temperatura de sa�da inicial
        Ts = zeros(maxPontos+1,1);
        
        % Temperatura da placa
        T_placa = CURVA.vTemperatura(1,1)+273;
        
        % Temperatura da C�lula
        T_cell = zeros(maxPontos,1);
        T_cell(1,1) = CURVA.vTemperatura(1,1)+273;
        
        % Vaz�o
        mass_flow = zeros(maxPontos,1);
        
        % Volume de �gua extraido
        mConsumoL = zeros(maxPontos,2);
        
        % Perdas de Temperatura por Condu��o
        perda = zeros(maxPontos,3);
        
        % Energia t�rmica gerada
        Q_modulo_real = zeros(maxPontos,1);
        
        while (minuto <= maxPontos) && (status == 1)

            % Massa total de �gua que passa pelo coletor [kg]
            mpontoc = qtdModulos*mass_flow(minuto,1)*60*granularidade;
            % Massa que entra no reservat�rio n�o pode ser maior que passa
            % de um dos n�veis
            if mpontoc > RESERVATORIO.massa(1,1)
                status = 0;
            end
            
            % Massa de �gua nos n�veis
            massaNivel = zeros(1,4);
            
            % Temperatura ambiente [K]
            Ta = CURVA.vTemperatura(minuto,1)+273;
            
            % Temperatura da c�lula [K]
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
            
            % Efici�ncia da c�lula fotovoltaica
            efic_cell = COLETOR.efic_ref+...
                ((-0.09167+0.005787*log(COLETOR.CF))/100)*...
                (T_cell(minuto,1)-273-25);
            
            % Coeficiente de pot�ncia t�rmico
            coef_termico = 1+COLETOR.coef_temperatura*...
                (T_cell(minuto,1)-273-25);
            
            % Efici�ncia do m�dulo concentrador fotovoltaico
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
            
            % Quando o reservat�rio abastece a demanda de �gua
            if (CURVA.vAguaL(minuto,1)>0)
                % Considerando que os reservat�rios operam em conjunto
                mConsumoL(minuto,1) = CURVA.vAguaL(minuto,1);
                if (CURVA.T_consumo(minuto,1)+273)>RESERVATORIO.TL
                    [CURVA,RESERVATORIO,mConsumoL,massaNivel] = ...
                        getConsumoAgua(CURVA,RESERVATORIO,mConsumoL,...
                        massaNivel,minuto);
                end
            end

            % Temperatura do recipiente do reservat�rio
            Tabsoluta = (Ta+RESERVATORIO.T(minuto,1))/2;

            if ((RESERVATORIO.T(minuto,4)>Ta) || (minuto==1))
                % N�mero de Rayleigh
                beta = 1/Tabsoluta;
                [alfaArf,~,~] = getDifusividade((Ta+...
                    RESERVATORIO.T(minuto,4))/2);
                [vArf,~] = getViscosidade((Ta+RESERVATORIO.T(minuto,4))/2);
                RaD = GERAL.g*beta*(RESERVATORIO.T(minuto,4)-Ta)*...
                    (RESERVATORIO.D_ext^3)/(vArf*alfaArf);
                
                % N�mero de Prandtl
                Pr = getPrandtl(RESERVATORIO.T(minuto,4));
                
                % N�mero de Nusselt
                NuD = (0.387+((0.387*RaD^(1/6))/...
                    ((1+((0.492/Pr)^(9/16)))^(8/27))))^2;
                
                % Convec��o Natural ao redor do Reservat�rio
                h4 = (NuD*GERAL.k_ar)/RESERVATORIO.D_ext;
                
                % Coeficiente de perda global do reservat�rio
                Ures = 1/((RESERVATORIO.r(1)/RESERVATORIO.k(1))...
                    *log(RESERVATORIO.r(2)/RESERVATORIO.r(1))+...
                    (RESERVATORIO.r(1)/RESERVATORIO.k(2))...
                    *log(RESERVATORIO.r(3)/RESERVATORIO.r(2))+...
                    (RESERVATORIO.r(1)/RESERVATORIO.k(3))...
                    *log(RESERVATORIO.r(4)/RESERVATORIO.r(3))+...
                    (RESERVATORIO.r(1)/RESERVATORIO.r(4))*(1/h4));
            end

            % Taxa radial de trasfer�ncia de calor no regime estacion�rio
            Aint = 2*pi*RESERVATORIO.r(1)*RESERVATORIO.LTubo;
            qr = (Ures/3)*(Aint/3);
            
            % Calor Espec�fico da �gua
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

            % Estratifica��o do Reservatorio
            RESERVATORIO = getEstratificacao(RESERVATORIO,massaNivel,...
                mpontoc,Ts,perda,minuto);
            
            %% ATUALIZA��O DA TEMPERATURA DO MATERIAL DO RESERVAT�RIO

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

            %% EQUA��ES DA POT�NCIA T�RMICA DO FLUIDO DE SAIDA DO COLETOR

            % Pot�ncia t�rmica ideal do m�dulo [kW]
            Q_modulo = (1-efic_PV)*COLETOR.efic_opt*COLETOR.CF*...
                CURVA.vDNI(minuto,1)*COLETOR.fator_imperfeicao*...
                COLETOR.A_cell*COLETOR.num_cell;
            
            % Pot�ncia t�rmica dispersada devido a radia��o e convec��o[kW]
            Q_perdido = ((COLETOR.coef_ConvMedio*...
                (T_cell(minuto,1)-Ta)+COLETOR.emiss*GERAL.constSB*...
                (((T_cell(minuto,1))^4)-(Ta^4)))*COLETOR.A_cell*...
                COLETOR.num_cell)/1000;
            
            % Pot�ncia t�rmica liberada pelo m�dulo com as perdas [kW]
            Q_modulo_real(minuto,1) = (Q_modulo-Q_perdido+...
                COLETOR.Q_gerado);
            if Q_modulo_real(minuto,1)<0
                Q_modulo_real(minuto,1) = 0;
            end
            
            %% C�LCULO DA TEMPERATURA DE SA�DA DO COLETOR
            
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
                    
                % Temperatura de sa�da do fluido para uma c�lula
                % (1kW = 1000J/s)
                relacaoDNI = CURVA.vDNI(minuto,1)/mean(CURVA.vDNI);
                if relacaoDNI<0.8 % M�nimo � 88 �C
                    relacaoDNI = 0.895;
                elseif relacaoDNI>1.5 % M�ximo � 165 �C
                    relacaoDNI = 1.5;
                end
                Ts(minuto+1,1) = 373*relacaoDNI; % 110 �C
                
                % Vaz�o m�ssica [kg/s]
                mass_flow(minuto+1,1) = Q_modulo_real(minuto,1)/...
                    (cpH2O*(Ts(minuto+1,1)-...
                    RESERVATORIO.Tagua(minuto+1,3)));

                %% C�lculo do Coeficiente convectivo da �gua
                    % Mass Flow Rate [kg/s]
                    velocidade = mass_flow(minuto+1,1)/...
                        (densidade*pi*(RESERVATORIO.d^2)/4);
                    mass_flow(minuto+1,1) = densidade*velocidade*...
                        (pi*(RESERVATORIO.d/2)^2);

                    % N�mero de Reynolds
                    Reynolds = (4*mass_flow(minuto+1,1))/...
                        (uH2O*pi*RESERVATORIO.d);

                    % N�mero de Nusselt
                    Nusselt = 0.023*(Reynolds^0.8*PrH2O^.4);

                    % Coeficiente convectivo da �gua
                    h_agua = (Nusselt*condutividade)/(RESERVATORIO.d);
                
                %% Temperatura da placa [K]
                T_placa(minuto+1,1) = (RESERVATORIO.Tagua(minuto+1,3)-...
                    exp((h_agua*Ac)/((mass_flow(minuto+1,1)/6)*...
                    (cpH2O)))*Ts(minuto+1,1))/...
                    (1-exp((h_agua*Ac)/((mass_flow(minuto+1,1)/6)*...
                    (cpH2O))));
                
                %% Temperatura de sa�da do coletor
                Ts(minuto+1,1) = T_placa(minuto+1,1)-...
                    ((T_placa(minuto+1,1)-RESERVATORIO.Tagua(minuto,3))/...
                    (exp((h_agua*Ac)/((mass_flow(minuto+1,1))*(cpH2O)))));
                % Temperatura da placa [K]
                T_placa(minuto+1,1) = (RESERVATORIO.Tagua(minuto+1,3)-...
                    exp((h_agua*Ac)/((mass_flow(minuto+1,1)/6)*...
                    (cpH2O)))*Ts(minuto+1,1))/...
                    (1-exp((h_agua*Ac)/((mass_flow(minuto+1,1)/6)*...
                    (cpH2O))));
                
                %% Nova Energia T�rmica
                Q_modulo_real(minuto,1) = mass_flow(minuto+1,1)*cpH2O*...
                    (Ts(minuto+1,1)-RESERVATORIO.Tagua(minuto+1,3))/1000;
                
            else
                Ts(minuto+1,1) = 0;
                T_placa(minuto+1,1) = T_cell(minuto,1);
            end
            
            % Verficando crit�rio de parada
            %   1. Temperatura da Placa n�o pode exceder 220 �C
            %   2. Temperatura de Sa�da do coletor n�o pode exceder 110�C
            %   3. Temperatura do N�vel 1 n�o pode exceder 100 �C
            %   3. Temperatura do N�vel 3 n�o pode exceder 50 �C
            if ((T_placa(minuto+1,1)>493) || (Ts(minuto+1,1)>383) || ...
                    (RESERVATORIO.Tagua(minuto+1,3)>373) || ...
                    (RESERVATORIO.Tagua(minuto+1,3)>373))
                status = 0;
            end

            minuto = minuto+1;
        end
        
    end
    
    % Corre��o da capacidade
    qtdModulos = qtdModulos - 1;
    
end