function [y] = nb_classificarAtributos(X,uniq,prob0,prob1, p1, p0)
% Função nb_classificarAtributos
% 	Classifica de acordo com as probabilidades se a amostra é da classe 1 ou 0
%
% Entrada:
%  X       = Matriz com os atributos e amostras da base
%  uniq    = Vetor de elementos unicos da base de teste
%  prob0   = Matriz de probabilidade dos atributos para a classe 0
%  prob1   = Matriz de probabilidade dos atributos para a classe 1
%  p1      = Probabilidade da classe 1
%  p0      = Probabilidade da classe 0
%
% Saída:
%  y = Atributos das amostras classificados em 1 ou 0
% ============================================================

% Inicializar variáveis
y = [];

%Classificar as amostras
for k = 1:size(X,1)%linhas
	tot_0 = 1;
	tot_1 = 1;
	for j = 1: size(X,2)%colunas
		index = find(X(k,j) == uniq); %Encontrar o indice onde ocorre o atributo
		if (prod0(index,j) == 0) % aplicar suavizacao nos casos que sao 0
		   prod0(index,j) = 1/size( unique( X(:,j) ),1);
		end
		if (prod1(index,j) == 0) % aplicar suavizacao nos casos que sao 0
		   prod1(index,j) = 1/size( unique( X(:,j) ),1);
		end
		tot_0 = tot_0 * prob0(index,j); %Armazenar os valores de prob do atributo na classe 0
		tot_1 = tot_1 * prob1(index,j); %Armazenar os valores de prob do atributo na classe 1
	end
	% Multiplicar pela probabilidade das classes.
	px0 = (tot_0) * p0;
	px1 = (tot_1) * p1;

	%Determinar qual classe pertence
	if (px0 > px1)
		y(k,1) = 0;
	else
		y(k,1) = 1;
	end
end

% ============================================================

end
