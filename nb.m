%% Inicializacao
clear ; close all; clc;

fprintf('Por favor aguarde um momento. Carregando os dados...\n\n');

% Carrega os dados do arquivo
data = load('base.txt');
% Separa os atribuos na matriz X, e Y
x = data(:, 1:end-1 ); 
Y = data(:, end );

%  Normalizar os valores de X
[X_norm] = normalizarAtributos(x);


%acho que ficou melhor sem reduzir os dados com pca
%  Executa o PCA
%[U, S] = pca(X_norm);

%Calcular o K 
%for K = 1:size(S,1)
%	pos = sum(diag(S(:,1:K)) ) / sum(diag(S));
%	if (pos >= 0.99)
%		break;
%	end
%end

%K = 137;
%Z = projetarDados(X_norm, U, K);

% Colocar a matriz normalizada em escala entre ranges
X = nb_escalarAtributos(X_norm);

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
[prob0, prob1] = nb_calcProbabilidade(tam_X,uniq,atribX0,atribX1);

%Classificar os atributos
[y] = nb_classificarAtributos(X,uniq, prob0, prob1, p0, p1);

%Acuracia do algoritmo
ac = (sum(Y == y)/tam_Y) * 100;
fprintf('Acuracia: %f\n', ac);


