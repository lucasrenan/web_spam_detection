%% Inicializacao
clear ; close all; clc;

fprintf('Por favor aguarde um momento. Carregando os dados...\n\n');

% Carrega os dados do arquivo
data = load('base.txt');
% Separa os atribuos na matriz X, e Y
X = data(:, size(data,2)-1 ); 
Y = data(:, size(data,2) );

%Descobrir os elementos unicos na matriz
uniq = unique(X);

%Tamanho de X e Y
tam_Y = size(Y,1);
tam_X = size(X,2);

%Calcular a probabilidade que acontece a classe 1 e 0
p1 = sum(Y)/tam_Y; %prob classe 1
p0 = (tam_Y - sum(Y))/tam_Y; % prob classe 0

%Salvar os index onde acontece cada classe
index_0 = find(Y == 0);
index_1 = find(Y == 1);

%Separar os atributos das amostras de acordo com a classe
atribX0 = X(index_0,:);%atributos que sao da classe 0
atribX1 = X(index_1,:);%atributos que sao da classe 1

%Calcular a probabilidade dos elementos.
[prob0, prob1] = calcProbabilidade(tam_X,uniq,atribX0,atribX1);


%Classificar os atributos
[y] = classificarAtributos(X,uniq, prob0, prob1, p0, p1);
hy = [y, Y];
ac = sum(Y == y)/tam_Y