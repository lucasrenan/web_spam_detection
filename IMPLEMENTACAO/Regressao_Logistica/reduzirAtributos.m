function Z = reduzirAtributos(x)
% Função reduzirAtributos:
% 	Normaliza, e reduz a quantidade de atributos usando PCA
%
% Entrada:
%  x = Amostras da base
%
% Saída:
%  Z = Matriz com amotras e atributos reduzidos.
% ============================================================

% Normalizar os valores de X
[X_norm] = normalizarAtributos(x);

% Diminuir a quantidade de atributos usando PCA
[U, S] = pca(X_norm);

%Calcular o K com variancia de 99%
for K = 1:size(S,1)
	pos = sum(diag(S(:,1:K)) ) / sum(diag(S));
	if (pos >= 0.99)
		break;
	end
end

%Selecionar os atributos de acordo com K calculado
Z = zeros(size(X_norm, 1), K);

%Reduzir os atributos de acordo com K
Ur = U(:,1:K);
Z = X_norm * Ur;

% ============================================================
end