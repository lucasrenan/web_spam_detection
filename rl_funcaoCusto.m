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

m = length(y); % numero de exemplos de treinamento

% Voce precisa retornar as seguintes variaveis corretamente
J = 0;
grad = zeros(size(theta));
% Initializa variaveis
lambda = 0.8;
sig = rl_sigmoid( X * theta);

theta_2 = theta;
theta_2(1) = 0;

reg_c = (lambda  * sum(  theta(2:size(theta)) .^2 ) )/ (2 * m);
J = (sum( ( -y .* log( sig ) ) - (( 1 .- y) .* log( 1 .- sig ) )  ) / m ) + reg_c ;

reg = (theta_2 * lambda) / m;
gra = ( X.' *( sig.- y ) )./ m;
grad = gra + reg;


% ============================================================

end
