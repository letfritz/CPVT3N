%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/t�rmico 
%          considerando reservat�rio estratificado em 3 n�veis
% ARQUIVO: C�digo para o c�lculo do n�mero de Prandtl
% NOME: LET�CIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVIS�O: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Viscosidade Cinem�tica

function Pr = getPrandtl(T)
    
    % N�mero de Prandtl
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