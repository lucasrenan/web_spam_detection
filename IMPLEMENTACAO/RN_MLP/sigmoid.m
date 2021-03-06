function g = sigmoid(z)
% Função sigmoid
% 	Calcula a funcao sigmoidal
%
% Entrada:
%  z  = Valores a ser calculados
%
% Saída:
%  g = Valor da sigmoidal
% ============================================================


% Inicializar variaveis
g = zeros(size(z));

% Calcular sigmoidal
g = 1 ./ ( 1 +  exp(-z)  );

% =============================================================

end
