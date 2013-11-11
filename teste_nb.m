%% Inicializacao
clear ; close all; clc;

% Carrega os dados do arquivo
data = load('base.txt');
% Separa os atribuos na matriz X, e Y
x = data(:, 1:end-1 ); 
Y = data(:, end );


x_teste = x(1:396,:);%10%
x_treino = x(397:end,:); %90%

y_teste = Y(1:396,:);%10%
y_treino = Y(397:end,:); %90%

% Colocar a matriz em escala entre ranges
range = 0;
[X,range] = nb_escalarAtributos(x_treino,10, range);

%Descobrir os elementos unicos na matriz
uniq = unique(X);

%Tamanho de X e Y
tam_Y = size(y_treino,1);
tam_X = size(X,2);

%Calcular a probabilidade que acontece a classe 1 e 0
p1 = sum(y_treino)/tam_Y; %prob classe 1
p0 = (tam_Y - sum(y_treino))/tam_Y; % prob classe 0

%Calcular a probabilidade dos elementos.
[prob0, prob1] = nb_calcProbabilidade(uniq,y_treino,X);

[X_teste, range] =   nb_escalarAtributos(x_teste,10, range);
%Classificar os atributos
[y] = nb_classificarAtributos(X_teste,uniq, prob0, prob1, p0, p1);

%Acuracia do algoritmo
ac = (sum(y_teste == y)/size(y,1)) * 100;
fprintf('Acuracia: %f\n', ac);

% Encontra os valores de TP, FP e FN para calculos
[TP, FP, FN] = valoresTblConfusao(y_teste, y);

%precisao 
pcs = (TP/(TP+FP)) * 100;
fprintf('Precisao: %f\n', pcs);

%revocacao
rev = (TP/(TP+FN)) * 100;
fprintf('Revocacao: %f\n', rev);

%f-medida
fmed = 2 * (rev*pcs)/(rev+pcs);
fprintf('F-Medida: %f\n', fmed);