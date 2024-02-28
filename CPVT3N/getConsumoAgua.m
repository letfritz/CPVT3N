%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/t�rmico 
%          considerando reservat�rio estratificado em 3 n�veis
% ARQUIVO: C�digo para identificar a demanda de �gua retirada de cada n�vel
% NOME: LET�CIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVIS�O: 27/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [CURVA,RESERVATORIO,mConsumoL,massaNivel] = ...
    getConsumoAgua(CURVA,RESERVATORIO,mConsumoL,massaNivel,minuto)

    % Uso da resist�ncia para esquentar �gua
    RESERVATORIO.Res = zeros(4,1);
    if (RESERVATORIO.Tagua(minuto,1)<(CURVA.T_consumo(minuto,1)+273))
        RESERVATORIO.Res(1,1) = 1;
        RESERVATORIO.Res(2,1) = 1;
        RESERVATORIO.Res(3,1) = 1;
        RESERVATORIO.Res(4,1) = 1;
    elseif (RESERVATORIO.Tagua(minuto,2)<(CURVA.T_consumo(minuto,1)+273))
        RESERVATORIO.Res(2,1) = 1;
        RESERVATORIO.Res(3,1) = 1;
        RESERVATORIO.Res(4,1) = 1;
    elseif (RESERVATORIO.Tagua(minuto,3)<(CURVA.T_consumo(minuto,1)+273))
        RESERVATORIO.Res(3,1) = 1;
        RESERVATORIO.Res(4,1) = 1;
    elseif (RESERVATORIO.TL<(CURVA.T_consumo(minuto,1)+273))
        RESERVATORIO.Res(4,1) = 1;
    end
    
    %% N�vel 1
    if (RESERVATORIO.Res(1,1) == 0)
        if ((RESERVATORIO.Tagua(minuto,1) > ...
                (CURVA.T_consumo(minuto,1)+273)))
            massaNivel(1,1) = mConsumoL(minuto,1)*...
                ((CURVA.T_consumo(minuto,1)+273-RESERVATORIO.TL)/...
                (RESERVATORIO.Tagua(minuto,1)-RESERVATORIO.TL));
        else
            massaNivel(1,1) = mConsumoL(minuto,1);
        end
    else
        % Energia gasta para esquentar a �gua
        [denH2O,cpH2O,~,~,~] = getEqAgua(RESERVATORIO.Tagua(minuto,1));
        RESERVATORIO.Q_eleVetor(minuto,1) = RESERVATORIO.massa(1,1)*...
            (cpH2O/(RESERVATORIO.massa(1,1)*denH2O/1000))*...
            (RESERVATORIO.Termostato-RESERVATORIO.Tagua(minuto,1))/1;
        % Considerando que a �gua est� na temperatura do termostato
        if ((RESERVATORIO.Termostato > (CURVA.T_consumo(minuto,1)+273)))
            massaNivel(1,1) = mConsumoL(minuto,1)*...
                ((CURVA.T_consumo(minuto,1)+273-RESERVATORIO.TL)/...
                (RESERVATORIO.Termostato-RESERVATORIO.TL));
        else
            massaNivel(1,1) = mConsumoL(minuto,1);
        end
    end
    
    % Massa dos N�veis
    if (massaNivel(1,1)>RESERVATORIO.massa(1,1))
        if (RESERVATORIO.Res(1,1)==0)
            massaNivel(1,2) = (massaNivel(1,1)-RESERVATORIO.massa(1,1))*...
                (RESERVATORIO.Tagua(minuto,1)/...
                RESERVATORIO.Tagua(minuto,2));
        else
            massaNivel(1,2) = (massaNivel(1,1)-RESERVATORIO.massa(1,1))*...
                (RESERVATORIO.Termostato/RESERVATORIO.Tagua(minuto,2));
        end
        massaNivel(1,1) = RESERVATORIO.massa(1,1);
    end
    
    %% N�vel 2
    if (massaNivel(1,2)>0)
        if ((RESERVATORIO.Res(1,1) == 0) && (RESERVATORIO.Res(2,1) == 0))
            massaNivel(1,2) = massaNivel(1,2)*...
                ((CURVA.T_consumo(minuto,1)+273-RESERVATORIO.TL)/...
                (RESERVATORIO.Tagua(minuto,2)-RESERVATORIO.TL));
        else
            [denH2O,cpH2O,~,~,~] = getEqAgua(RESERVATORIO.Tagua(minuto,2));
            RESERVATORIO.Q_eleVetor(minuto,1) = RESERVATORIO.massa(2,1)*...
                (cpH2O/(RESERVATORIO.massa(1,1)*denH2O/1000))*...
                (RESERVATORIO.Termostato-RESERVATORIO.Tagua(minuto,2))/1;
            % Considerando que a �gua est� na temperatura do termostato
            if ((RESERVATORIO.Termostato > ...
                    (CURVA.T_consumo(minuto,1)+273)))
                massaNivel(1,2) = massaNivel(1,2)*...
                    ((CURVA.T_consumo(minuto,1)+273-RESERVATORIO.TL)/...
                    (RESERVATORIO.Termostato-RESERVATORIO.TL));
            else
                massaNivel(1,2) = massaNivel(1,2);
            end
        end

        % Massa dos N�veis
        if (massaNivel(1,2)>RESERVATORIO.massa(2,1))
            if (RESERVATORIO.Res(2,1) == 0)
                massaNivel(1,3) = (massaNivel(1,2)-...
                    RESERVATORIO.massa(2,1))*...
                    (RESERVATORIO.Tagua(minuto,2)/...
                    RESERVATORIO.Tagua(minuto,3));
            else
                massaNivel(1,3) = (massaNivel(1,2)-...
                    RESERVATORIO.massa(2,1))*(RESERVATORIO.Termostato/...
                    RESERVATORIO.Tagua(minuto,3));
            end
            massaNivel(1,2) = RESERVATORIO.massa(2,1);
        end
    end
    
    %% N�vel 3
    if (massaNivel(1,3)>0)
        if ((RESERVATORIO.Res(2,1) == 0) && (RESERVATORIO.Res(3,1) == 0))
            massaNivel(1,3) = massaNivel(1,3)*...
                ((CURVA.T_consumo(minuto,1)+273-RESERVATORIO.TL)/...
                (RESERVATORIO.Tagua(minuto,3)-RESERVATORIO.TL));
        else
            [denH2O,cpH2O,~,~,~] = getEqAgua(RESERVATORIO.Tagua(minuto,3));
            RESERVATORIO.Q_eleVetor(minuto,1) = RESERVATORIO.massa(3,1)*...
                (cpH2O/(RESERVATORIO.massa(1,1)*denH2O/1000))*...
                (RESERVATORIO.Termostato-RESERVATORIO.Tagua(minuto,3))/1;
            if ((RESERVATORIO.Termostato > ...
                    (CURVA.T_consumo(minuto,1)+273)))
                massaNivel(1,3) = massaNivel(1,3)*...
                    ((CURVA.T_consumo(minuto,1)+273-RESERVATORIO.TL)/...
                    (RESERVATORIO.Termostato-RESERVATORIO.TL));
            else
                massaNivel(1,3) = massaNivel(1,3);
            end
        end

        % Massa dos N�veis
        if (massaNivel(1,3)>RESERVATORIO.massa(3,1))
            if (RESERVATORIO.Res(3,1) == 0)
                massaNivel(1,4) = (massaNivel(1,3)-...
                    RESERVATORIO.massa(3,1))*...
                    (RESERVATORIO.Tagua(minuto,3)/RESERVATORIO.TL);
            else
                massaNivel(1,4) = (massaNivel(1,3)-...
                    RESERVATORIO.massa(3,1))*(RESERVATORIO.Termostato/...
                    RESERVATORIO.TL);            
            end
            massaNivel(1,3) = RESERVATORIO.massa(3,1);
        end
    end
    
    %% N�vel 4
    if (massaNivel(1,4)>0)
        if ((RESERVATORIO.Res(3,1) == 0) && (RESERVATORIO.Res(4,1) == 0))
            massaNivel(1,4) = massaNivel(1,3)*...
                ((CURVA.T_consumo(minuto,1)+273-RESERVATORIO.TL)/...
                (RESERVATORIO.Tagua(minuto,3)-RESERVATORIO.TL));
        else
            [denH2O,cpH2O,~,~,~] = getEqAgua(RESERVATORIO.TL);
            RESERVATORIO.Q_eleVetor(minuto,1) = massaNivel(1,4)*...
                (cpH2O/(RESERVATORIO.massa(1,1)*denH2O/1000))*...
                (RESERVATORIO.Termostato-RESERVATORIO.TL)/1;
            % Considerando que a �gua est� na temperatura do termostato
            if ((RESERVATORIO.Termostato > ...
                    (CURVA.T_consumo(minuto,1)+273)))
                massaNivel(1,4) = massaNivel(1,4)*...
                    ((CURVA.T_consumo(minuto,1)+273-RESERVATORIO.TL)/...
                    (RESERVATORIO.Termostato-RESERVATORIO.TL));
            else
                massaNivel(1,4) = massaNivel(1,4);
            end
        end
    end
    
end
