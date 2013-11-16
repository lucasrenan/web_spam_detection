% ============================== Naive Bayes ==============================
%
% Arquivo principal de chamada para rodar naive bayes.
% Obs:
%   . Para atributos discretos, deve se escalar chamando a função: nb_escalarAtributos
%   . Para atributos contínuos, não é necessário
%   . Para classificar uma nova matriz de teste, diferente da matriz de treino,
%     deve-se chamar a nb_escalarAtributos para a base de treino, e com o range retornado
%     chamar a nb_escalarAtributos para classificar a matriz de teste com o mesmo range.
% =========================================================================

%% Inicializacao
clear ; close all; clc;

% Carrega os dados do arquivo
disp('Carregando os dados... Aguarde.');
fflush(stdout);
data = load('base.txt');

% Separa os atribuos na matriz X, e Y
x = data(:, 1:end-1 ); 
Y = data(:, end );

disp('Calculando as probabilidades.');
fflush(stdout);

%--------------- Escalar a matriz com dados continuos ----------------------
% Colocar a matriz em escala entre ranges
% Retornar a matriz escalada e o range utilizado para escalar uma nova a matriz de teste não escalada
range = 0;
[X,range] = nb_escalarAtributos(x,5, range);

%Descobrir os elementos unicos na matriz
uniq = unique(X);

%Tamanho de X e Y
tam_Y = size(Y,1);
tam_X = size(X,2);

%------------------- Calcular as probabilidade -----------------------------
%Calcular a probabilidade que acontece a classe 1 e 0
p1 = sum(Y)/tam_Y; %prob classe 1
p0 = (tam_Y - sum(Y))/tam_Y; % prob classe 0

%Calcular a probabilidade dos elementos para cada classe
[prob0, prob1] = nb_calcProbabilidade(uniq,Y,X);

%------------------- Classificar as amostras -------------------------------
disp('Classificar as amostras.');
fflush(stdout);
%Classificar os atributos
[y] = nb_classificarAtributos(X,uniq, prob0, prob1, p0, p1);

%------------------- Exibir Resultados -------------------------------------
fprintf('Resultados Obtidos com o Naive Bayes:\n');
fflush(stdout);

%Acuracia do algoritmo
ac = (sum(Y == y)/tam_Y) * 100;
fprintf('Acuracia: %f\n', ac);

% Encontra os valores de TP, FP e FN para calculos
[TP, FP, FN] = valoresTblConfusao(Y, y);

%Precisao 
pcs = (TP/(TP+FP)) * 100;
fprintf('Precisao: %f\n', pcs);

%Revocacao
rev = (TP/(TP+FN)) * 100;
fprintf('Revocacao: %f\n', rev);

%F-medida
fmed = 2 * (rev*pcs)/(rev+pcs);
fprintf('F-Medida: %f\n', fmed);

