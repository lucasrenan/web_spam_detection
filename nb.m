
%% Inicializacao
clear ; close all; clc

fprintf('Carregando os dados...\n\n');

% Carrega os dados do arquivo
load('carData.mat');

%Descobrir os elementos unicos na matriz
uniq = unique(X);

%Tamanho de X e Y
tam_Y = size(Y,1);
tam_X = size(X,2);

%Calcular a probabilidade que acontece a classe 1 e 0
p0 = sum(Y)/tam_Y; %prob classe bom
p1 = (tam_Y - sum(Y))/tam_Y; % prob classe ruim

%Salvar os index onde acontece cada classe
index_0 = find(Y == 0);
index_1 = find(Y == 1);

%Separar os atributos das amostras de acordo com a classe
probX0 = X(index_0,:);%atributos que sao da classe 0
probX1 = X(index_1,:);%atributos que sao da classe 1

%Calcular o tamanho das matrizes separadas.
tam_0 = size(probX0,1);
tam_1 = size(probX1,1);

prob0 = [];
prob1 = [];

%Calcular a prob dos elementos da matriz X e salvar em uma matriz já separada por classe
for i = 1:tam_X
	for n = 1:size(uniq,1)
    	prob0(n,i) = sum(uniq(n,1) == probX0(:,i));
    	prob1(n,i) = sum(uniq(n,1) == probX1(:,i));
    end
end

%Armarzenar a probabilidade que os elementos aparecem.
prod0 = prob0/tam_0;
prod1 = prob1/tam_1;


%Verificar algoritmo
for k = 1:size(X,1)%linhas
	tot_0 = 1;
	tot_1 = 1;
	for j = 1: size(X,2)%colunas
		index = find(X(k,j) == uniq); %Encontrar o indice onde ocorre o atributo
		%if (prod0(index,j) == 0) % aplicar suavizacao nos casos que sao 0
		%   prod0(index,j) = 1/size( unique( X(:,j) ),1);
		%end
		%if (prod1(index,j) == 0) % aplicar suavizacao nos casos que sao 0
		%   prod1(index,j) = 1/size( unique( X(:,j) ),1);
		%end
		tot_0 = tot_0 * prod0(index,j); %Armazenar os valores de prob do atributo na classe 0
		tot_1 = tot_1 * prod1(index,j); %Armazenar os valores de prob do atributo na classe 1
	end
	px0 = (tot_0) * p0;
	px1 = (tot_1) * p1;

	%Determinar qual classe pertence
	if (px0 > px1)
		hx(k,1) = 0;
	else
		hx(k,1) = 1;
	end
end


hy = [hx, Y]
ac = sum(Y == hx)/tam_Y