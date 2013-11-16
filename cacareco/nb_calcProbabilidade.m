function [prob0, prob1] = nb_calcProbabilidade(uniq,Y,X)
% Função nb_calcProbabilidade:
% 	Calcula a probabilidade de ocorrencia dos atributos na classe 0 e classe 1
%
% Entrada:
%  uniq    = Vetor com elementos unicos da base de teste
%  Y       = Matriz de classes das amostras
%  X       = Matriz de amostras
%
% Saída:
%  prob0 = Matriz de probabilidade dos atributos para a classe 0
%  prob1 = Matriz de probabilidade dos atributos para a classe 1
% ============================================================

%Inicializar variaveis de controle
prob_0 = [];
prob_1 = [];

tam_X = size(X,2);

%Salvar os index onde acontece cada classe
index_0 = find(Y == 0);
index_1 = find(Y == 1);

%Separar os atributos das amostras de acordo com a classe
atribX0 = X(index_0,:);%atributos que sao da classe 0
atribX1 = X(index_1,:);%atributos que sao da classe 1

%Calcular o tamanho das matrizes separadas.
tam_0 = size(atribX0,1);
tam_1 = size(atribX1,1);

%Calcular a prob dos elementos da matriz X e salvar em uma matriz já separada por classe
for i = 1:tam_X
	for n = 1:size(uniq,1)
    	prob_0(n,i) = sum(uniq(n,1) == atribX0(:,i));
    	prob_1(n,i) = sum(uniq(n,1) == atribX1(:,i));
    end
end

%Armarzenar a probabilidade que os elementos aparecem.
prob0 = prob_0/tam_0;
prob1 = prob_1/tam_1;



% ============================================================

end
