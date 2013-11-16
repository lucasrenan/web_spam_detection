function [X, range] = nb_escalarAtributos(Z, qtdeBag, range)
% Função nb_escalarAtributos
%   Escala os atributos distintos em uma escala
%
% Entrada:
%  Z      = Matriz de Atributos
%  qdeBag = Quantidade de "cestas" que devem ser divididas as amostras.
%  range  = Determinar a escala dos atributos, atributo de entrada e saída
%           Caso  0, irá calcular o range 
%           Caso <> 0, usará o range já calculado, que deve ser passado como parâmetro.
%
% Saída:
%  X     = Atributos das amostras escaladas.
%  range = Saída do range calculado, deve ser usado para escalar novas amostras
% ============================================================

%Definir a escala dos atributos para escalar a matriz pela primeira vez
if (range == 0)
    range = iqr(Z);
end

for i = 1:size(Z,1) %linhas
    for n = 1:size(Z,2) %Colunas
        att = Z(i,n);
        %Separar em cestas dependendo do range
        bag = range(:,n);
        for j = 1:qtdeBag
            if (att >= range(:,n) * j)
                bag = range(:,n) * j;    
        end
        Z(i,n) = bag;
    end
end

%Retornar a matriz escalada em cestas
X = Z;


% ============================================================

end