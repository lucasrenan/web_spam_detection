%% Inicializacao
clear ; close all; clc

fprintf('Por favor aguarde. Estamos carregando os dados...\n\n');

% Carrega os dados do arquivo
data = load('base.txt');

% Separa os atribuos na matriz X, e Y
x = data(:, 1:size(data,2)-1 ); 
y = data(:, size(data,2) );

%Reduzir os atributos
Z = reduzirAtributos(x);

%Padronizar o nome da variavel
X = Z;

%  Adicionar 1 na primeira coluna
[m, n] = size(X);

X = [ones(m, 1) X];

%  Inicializar os parametros que serao ajustados
theta_inicial = zeros(n + 1, 1);

%  Calcular o custo inicial e o gradiente
[custo, grad] = funcaoCusto(theta_inicial, X, y);

%  Encontrar o theta otimo
[theta, custo] = ...
	fminunc(@(t)(funcaoCusto(t, X, y)), theta_inicial);

%  Calcula a acuracia do modelo sobre a base de treinamento.
p = predicaoRL(theta, X);

fprintf('Acuracia na base de treinamento: %f\n', mean(double(p == y)) * 100);

%% Finalizacao
clear; close all;