function [X] = nb_escalarAtributos(Z)
% Função nb_escalarAtributos
%   Escala os atributos distintos em uma escala
%
% Entrada:
%  Z  = Matriz de Atributos
%
% Saída:
%  X = Atributos das amostras escaladas.
% ============================================================

%Definir a escala dos atributos.
for i = 1:size(Z,1) %linhas
	for n = 1:size(Z,2) %Colunas
		att = Z(i,n);
    	if ( att >= -1 && att < -0.9)
    		Z(i,n) = -1;
    	elseif ( att >= -0.9 && att < -0.8)
    		Z(i,n) = -0.9;
    	elseif ( att >= -0.8 && att < -0.7)
    		Z(i,n) = -0.8;
		elseif ( att >= -0.7 && att < -0.6)
    		Z(i,n) = -0.7;
    	elseif ( att >= -0.6 && att < -0.5)
    		Z(i,n) = -0.6;
    	elseif ( att >= -0.5 && att < -0.4)
    		Z(i,n) = -0.5;
    	elseif (att >= -0.4 && att < -0.3)
    		Z(i,n) = -0.4;
    	elseif ( att >= -0.3 && att < -0.2)
    		Z(i,n) = -0.3;
    	elseif ( att >= -0.2 && att < -0.1)
    		Z(i,n) = -0.2;
    	elseif ( att >= -0.1 && att < 0)
    		Z(i,n) = -0.1;
    	elseif ( att >= 0 && att < 0.1)
    		Z(i,n) = 0.1;
    	elseif ( att > 0 && att <= 0.1)
    		Z(i,n) = 0.1;
    	elseif ( att > 0.1 && att <= 0.2)
    		Z(i,n) = 0.2;
    	elseif ( att > 0.2 && att <= 0.3)
    		Z(i,n) = 0.3;
    	elseif ( att > 0.3 && att <= 0.4)
    		Z(i,n) = 0.4;
    	elseif ( att > 0.4 && att <= 0.5)
    		Z(i,n) = 0.5;
    	elseif ( att > 0.5 && att <= 0.6)
    		Z(i,n) = 0.6;
    	elseif ( att > 0.6 && att <= 0.7)
    		Z(i,n) = 0.7;
    	elseif ( att > 0.7 && att <= 0.8)
    		Z(i,n) = 0.8;
    	elseif ( att > 0.8 && att <= 0.9)
    		Z(i,n) = 0.9;
    	else
    		Z(i,n) = 1;
    	end
    end
end

X = Z;


% ============================================================

end