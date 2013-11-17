function [J, grad] = rl_funcaoCusto(theta, X, y)
% Função rl_funcaoCusto:
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

%Inicializa os valores
m = length(y); 
J = 0;
grad = zeros(size(theta));
lambda = 0.8;

% Sigmoid
sig = rl_sigmoid( X * theta);
theta_2 = theta;
theta_2(1) = 0;

% Calcular o custo
reg_c = (lambda  * sum(  theta(2:size(theta)) .^2 ) )/ (2 * m);
J = (sum( ( -y .* log( sig ) ) - (( 1 - y) .* log( 1 - sig ) )  ) / m ) + reg_c ;

% Calcular o gradiente
reg = (theta_2 * lambda) / m;
gra = ( X.' *( sig - y ) )./ m;
grad = gra + reg;


% ============================================================

end
