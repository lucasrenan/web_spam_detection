function [J, grad] = funcaoCusto(theta, X, y)
% Função funcaoCusto:
% 	Calcular o custo de usar theta para ajustar X
%
% Entrada:
%  theta = regulazidor
%  X     = Amostras da base
%  y     = Classes da base
%
% Saída:
%  J    = Custo
%  grad = Gradiente
% ============================================================

% Initializa variaveis
m = length(y); % numero de exemplos de treinamento
J = 0; % Custo
grad = zeros(size(theta)); % gradiente

% Calcular a sigmoidal
sig = sigmoid( X * theta);

%Calcular o custo
J = sum( ( -y .* log( sig ) ) - (( 1 .- y) .* log( 1 .- sig ) )  ) / m;

% Calcular o gradiente
grad =  ( X.' *( sig.- y ) )./ m;

% ============================================================

end
