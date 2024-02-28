%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/térmico 
%          considerando reservatório estratificado em 3 níveis
% ARQUIVO: Código para o cálculo do número de Prandtl
% NOME: LETÍCIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVISÃO: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Viscosidade Cinemática

function Pr = getPrandtl(T)
    
    % Número de Prandtl
    if (T <= 300)
        Pr = 0.785-0.00026*T;
    elseif (T > 300) && (T <= 350)
        Pr = 0.749-0.00014*T;
    elseif (T > 350) && (T <= 400)
        Pr = 0.77-0.0002*T;
    elseif (T > 400)
        Pr = 0.722-8.0*(10^(-5))*T;
    end
    
end