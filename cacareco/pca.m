function [U, S] = pca(X)
% Função pca:
% 	Executa a analise de componentes principais na base de dados X
%
% Entrada:
%  X = Amostras da base
%
% Saída:
%  U = Autovetores
%  S = Autovalores
% =============================================================

% Tamanho de X
[m, n] = size(X);

% Inicializar variaveis
U = zeros(n);
S = zeros(n);

%Calcular sigma
sigma = (X' * X)/m;

% Aplicar SVD
[U, S, V] = svd(sigma);

% =============================================================

end
