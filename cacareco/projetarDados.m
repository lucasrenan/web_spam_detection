function Z = projetarDados(X, U, K)
% Função projetarDados:
% 	Reduzir a quantidade de atributos com o K calculado
%
% Entrada:
%  X = Amostras da base
%  U = Autovetores
%  K = Selecionar K atributos
%
% Saída:
%  Z = Matriz com atributos reduzidos.
% =============================================================

% Inicializa variavel de retorno.
Z = zeros(size(X, 1), K);

%Reduzir os atributos de acordo com K
Ur = U(:,1:K);
Z = X * Ur;

% =============================================================

end
