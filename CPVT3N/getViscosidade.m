%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROJETO: CPVT3N - Modelagem no concentrador fotovoltaico/t�rmico 
%          considerando reservat�rio estratificado em 3 n�veis
% ARQUIVO: C�digo para o c�lculo da viscosidade cin�tica
% NOME: LET�CIA FRITZ HENRIQUE
% E-mail: leticiafritz@id.uff.br
% ULTIMA REVIS�O: 26/07/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [vArf,uArf] = getViscosidade(T)
    
    % Viscosidade Cin�tica
    if (T <= 300)
        vArf = 8.90258*(10^(-8))*T-1.0813*10^(-5);
    elseif (T > 300) && (T <= 350)
        vArf = 1.006*(10^(-7))*T-1.4285*10^(-5);
    elseif (T > 350) && (T <= 400)
        vArf = 1.09805*(10^(-7))*T-1.7507*10^(-5);
    elseif (T > 400)
        vArf = 1.19506*(10^(-7))*T-2.1388*10^(-5);
    end
    
    % Viscosidade Din�mica
    if (T <= 300)
        uArf = 3.46*10^(-6)+5*10^(-8)*T;
    elseif (T > 300) && (T <= 350)
        uArf = 4.3*10^(-6)+4.72*10^(-8)*T;
    elseif (T > 350) && (T <= 400)
        uArf = 5.49*10^(-6)+4.38*10^(-8)*T;
    elseif (T > 400)
        uArf = 6.53*10^(-6)+4.12*10^(-8)*T;
    end
    
end