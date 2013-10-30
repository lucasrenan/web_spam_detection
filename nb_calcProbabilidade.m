function [prob0, prob1] = nb_calcProbabilidade(tam_X,uniq,atribX0,atribX1)
% Função nb_calcProbabilidade:
% 	Calcula a probabilidade de ocorrencia dos atributos na classe 0 e classe 1
%
% Entrada:
%  tam_X   = Função que recebe tamanho dos atributos X
%  uniq    = Vetor de elementos unicos da base de teste
%  atribX0 = Atributos das amostras que são da classe 0
%  atribX1 = Atributos das amostras que são da classe 1
%
% Saída:
%  prob0 = Matriz de probabilidade dos atributos para a classe 0
%  prob1 = Matriz de probabilidade dos atributos para a classe 1
% ============================================================

%Inicializar variaveis de controle
prob_0 = [];
prob_1 = [];

%Calcular o tamanho das matrizes separadas.
tam_0 = size(atribX0,1);
tam_1 = size(atribX1,1);
tam_X
size(uniq,1)
%Calcular a prob dos elementos da matriz X e salvar em uma matriz já separada por classe
%for i = 1:tam_X
	%for n = 1:size(uniq,1)
    	%prob_0(n,i) = sum(uniq(n,1) == atribX0(:,i));
    	%prob_1(n,i) = sum(uniq(n,1) == atribX1(:,i));
    %	i 
    %	n
    %end
%end

%Armarzenar a probabilidade que os elementos aparecem.
%prob0 = prob_0/tam_0;
%prob1 = prob_1/tam_1;



% ============================================================

end
