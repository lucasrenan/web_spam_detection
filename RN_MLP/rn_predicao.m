function p = rn_predicao(theta_1, theta_2, X)
% Função rl_predicao
% 	Classifica se a amostra é da classe 1 ou 0
%
% Entrada:
%  X         = Matriz com os atributos e amostras da base
%  theta_1   = theta calculado da camada de entrada para a intermediaria
%  theta_2   = theta calculado da camada intermediaria para a de saida
%
% Saída:
%  p = Atributos das amostras classificados em 1 ou 0
% ============================================================

%Inicializar variaveis
[m, n] = size(X);
media = 0.5;

%Aplicar sigmoid nas camadas
a1 = [ones(m , 1)  X];
a2 = sigmoid(a1 * theta_1);
a2 = [ones(m , 1)  a2];
a3 = sigmoid(a2 * theta_2);

m = size(a3, 1); 
p = zeros(m, 1);

sig = a3;
%Classificar as amostras
for i=1:m 
  if ( sig(i)  >= media)
    p(i) = 1;
  else
    p(i) = 0;
  end
end;


%============================================================
end