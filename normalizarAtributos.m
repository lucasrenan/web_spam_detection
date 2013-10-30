function [X_norm] = normalizarAtributos(X)
% Função normalizarAtributos:
% 	Normalizar as amotras de X com media = 0 e desvio padrao = 1
%
% Entrada:
%  X = Amostras da base
%
% Saída:
%  X_norm = Matriz normalizada
% =============================================================

% Calcular a media
media = mean(X);
X_norm = bsxfun(@minus, X, media);

%Calcular o desvio padrao
desvio = std(X_norm);
X_norm = bsxfun(@rdivide, X_norm, desvio);

% =============================================================
end
