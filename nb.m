%% Inicializacao
clear ; close all; clc;

% Carrega os dados do arquivo
data = load('base.txt');
% Separa os atribuos na matriz X, e Y
x = data(:, 1:end-1 ); 
Y = data(:, end );

% Colocar a matriz em escala entre ranges
X = nb_escalarAtributos(x,10);

%Descobrir os elementos unicos na matriz
uniq = unique(X);

%Tamanho de X e Y
tam_Y = size(Y,1);
tam_X = size(X,2);

%Calcular a probabilidade que acontece a classe 1 e 0
p1 = sum(Y)/tam_Y; %prob classe 1
p0 = (tam_Y - sum(Y))/tam_Y; % prob classe 0

%Calcular a probabilidade dos elementos.
[prob0, prob1] = nb_calcProbabilidade(uniq,Y,X);

%Classificar os atributos
[y] = nb_classificarAtributos(X,uniq, prob0, prob1, p0, p1);

%Acuracia do algoritmo
ac = (sum(Y == y)/tam_Y) * 100;
fprintf('Acuracia: %f\n', ac);

% Calcular a Predicao, Revocacao, e F-Medida


