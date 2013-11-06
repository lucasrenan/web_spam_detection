%% Inicializacao
clear ; close all; clc

% Carrega os dados do arquivo
data = load('base.txt');

% Separa os atribuos na matriz X, e Y
x = data(:, 1:size(data,2)-1 ); 
y = data(:, size(data,2) );

%Reduzir os atributos
Z = reduzirAtributos(x);

%Padronizar o nome da variavel
X = Z;

% Adicionar 1 na primeira coluna
[m, n] = size(X);
X = [ones(m, 1) X];

%  Inicializar os parametros que serao ajustados
theta_inicial = zeros(n + 1, 1);

%  Calcular o custo inicial e o gradiente
[custo, grad] = rl_funcaoCusto(theta_inicial, X, y);

%  Encontrar o theta otimo
[theta, custo] = ...
	fminunc(@(t)(rl_funcaoCusto(t, X, y)), theta_inicial);

%  Calcula a acuracia do modelo sobre a base de treinamento.
Y = rl_predicao(theta, X);

%Acuracia do algoritmo
ac = (sum(Y == y)/size(y,1)) * 100;
fprintf('Acuracia: %f\n', ac);

% Calcular a Predicao, Revocacao, e F-Medida