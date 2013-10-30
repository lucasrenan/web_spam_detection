function p = predicaoRL(theta, X)
% Função predicaoRL
% 	Classifica se a amostra é da classe 1 ou 0
%
% Entrada:
%  X       = Matriz com os atributos e amostras da base
%  theta   = theta calculado
%
% Saída:
%  p = Atributos das amostras classificados em 1 ou 0
% ============================================================

%Inicializar variaveis
m = size(X, 1); % Tamanho das amostras de X
p = zeros(m, 1);

% Calcular a sigmoidal
sig = sigmoid( X * theta );

% Classificar as amostras
for i=1:m 
	if ( sig(i)  >= 0.5)
		p(i) = 1;
	else
		p(i) = 0;
end;

% =========================================================================


end
