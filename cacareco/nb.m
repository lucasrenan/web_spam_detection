%% Inicializacao
clear ; close all; clc;

% Carrega os dados do arquivo
data = load('base.txt');
% Separa os atribuos na matriz X, e Y
x = data(:, 1:end-1 ); 
Y = data(:, end );

% Colocar a matriz em escala entre ranges
% Retornar a matriz escalada e o range utilizado
range = 0;
[X,range] = nb_escalarAtributos(x,5, range);

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

% Encontra os valores de TP, FP e FN para calculos
[TP, FP, FN] = valoresTblConfusao(Y, y);

%precisao 
pcs = (TP/(TP+FP)) * 100;
fprintf('Precisao: %f\n', pcs);

%revocacao
rev = (TP/(TP+FN)) * 100;
fprintf('Revocacao: %f\n', rev);

%f-medida
fmed = 2 * (rev*pcs)/(rev+pcs);
fprintf('F-Medida: %f\n', fmed);