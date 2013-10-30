%% Inicializacao
clear ; close all; clc;

fprintf('Por favor aguarde um momento. Carregando os dados...\n\n');

% Carrega os dados do arquivo
data = load('base.txt');
% Separa os atribuos na matriz X, e Y
x = data(:, 1:end-1 ); 
Y = data(:, end );

%  Antes de aplicar o PCA, normalize os valores de X
[X_norm] = normalizarAtributos(x);

%  Executa o PCA
[U, S] = pca(X_norm);

%Calcular o K 
for K = 1:size(S,1)
	pos = sum(diag(S(:,1:K)) ) / sum(diag(S));
	if (pos >= 0.99)
		break;
	end
end

%K = 50;
Z = projetarDados(X_norm, U, K);

%Padronizar nome de variavel
X = Z;

X = x;
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
% ARRUMAR FUNCAO ABAIXO, POIS ESSE ESQUEMA DE UNIQ TA RETORNANDO MTO GRANDE POR SER NUMEROS CONTINUOS.
% TEM QUE PENSAR EM OUTRO JEITO
[prob0, prob1] = nb_calcProbabilidade(tam_X,uniq,atribX0,atribX1);

fprintf('Prob calculada.\n\n');

% codig 2 aqui
