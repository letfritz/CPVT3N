%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Código para cálculo da difusividade térmica
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [alfaArf,densidade,Cp,k] = getDifusividade(T)
    
    % Condutividade térmica [W/mK]
    if (T <= 300)
        k = 8.92*(10^(-5))*T-0.01296;
    elseif (T > 300) && (T <= 350)
        k = 8.6*(10^(-5))*T-0.012;
    elseif (T > 350) && (T <= 400)
        k = 8.4*(10^(-5))*T-0.0113;
    elseif (T > 400)
        k = 8.0*(10^(-5))*T-0.0097;
    end
    
    % Densidade [kg/m³]
    if (T <= 300)
        densidade = 2.5612-0.00467*T;
    elseif (T > 300) && (T <= 350)
        densidade = 2.1598-0.00333*T;
    elseif (T > 350) && (T <= 400)
        densidade = 1.8623-0.00248*T;
    elseif (T > 400)
        densidade = 1.6479-0.00194*T;
    end
    
    % Calor específico [kJ/kg.K]
    if (T <= 300)
        Cp = 1001+0.02*T;
    elseif (T > 300) && (T <= 350)
        Cp = 995+0.04*T;
    elseif (T > 350) && (T <= 400)
        Cp = 974+0.1*T;
    elseif (T > 400)
        Cp = 958+0.14*T;
    end
    
    % Difusividade Térmica
    alfaArf = k/(densidade*Cp);
    
end