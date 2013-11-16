function [X, range] = nb_escalarAtributos(Z, qtdeBag, range)
% Função nb_escalarAtributos
%   Escala os atributos distintos em uma escala
%
% Entrada:
%  Z      = Matriz de Atributos
%  qdeBag = Quantidade de sacolas que devem ser divididas as amostras.
%
% Saída:
%  X = Atributos das amostras escaladas.
% ============================================================

%Definir a escala dos atributos.
if (range == 0)
    range = iqr(Z);
end

for i = 1:size(Z,1) %linhas
    for n = 1:size(Z,2) %Colunas
        att = Z(i,n);
        %Separar em sacolas dependendo do range
        bag = range(:,n);
        for j = 1:qtdeBag
            if (att >= range(:,n) * j)
                bag = range(:,n) * j;    
        end
        Z(i,n) = bag;
    end
end

%Retornar a matriz escalada em sacolas
X = Z;


% ============================================================

end