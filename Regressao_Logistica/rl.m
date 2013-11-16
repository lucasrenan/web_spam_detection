% ============================== Regressão Logística ======================
%
% Arquivo principal de chamada para rodar regressão logística.
%
% =========================================================================

%% Inicializacao
clear ; close all; clc

% Carrega os dados do arquivo
disp('Carregando os dados... Aguarde.');
fflush(stdout);
data = load('base.txt');

% Separa os atribuos na matriz X, e Y
x = data(:, 1:size(data,2)-1 ); 
y = data(:, size(data,2) );

%------------------- Reduzir as amostras -----------------------------
%Reduzir os atributos atavés do uso do PCA
disp('Reduzir quantidade de amostras com PCA.');
fflush(stdout);
X = reduzirAtributos(x);

% Adicionar 1 na primeira coluna
[m, n] = size(X);
X = [ones(m, 1) X];

%------------------- Calcular o theta otimo ---------------------------
disp('Calcular o theta ótimo.');
fflush(stdout);
%  Inicializar os theta(pesos) que serao ajustados
theta_inicial = zeros(n + 1, 1);

%  Encontrar o theta otimo
op = optimset('GradObj', 'on');
[theta, custo] = fminunc(@(t)(rl_funcaoCusto(t, X, y)), theta_inicial, op);

%------------------- Classificar as amostras ---------------------------
disp('Classificar as amostras.');
fflush(stdout);
%  Calcula a acuracia do modelo sobre a base de treinamento.
Y = rl_predicao(theta, X);

%------------------- Exibir resultados ---------------------------------
fprintf('Resultados Obtidos com a Regressão Logística:\n');
fflush(stdout);
%Acuracia do algoritmo
ac = (sum(Y == y)/size(y,1)) * 100;
fprintf('Acuracia: %f\n', ac);

% Encontra os valores de TP, FP e FN para calculos
[TP, FP, FN] = valoresTblConfusao(Y, y);

%precisao
pcs = (TP/(TP+FP)) * 100;
fprintf('Precisao: %f\n', pcs);

%revocacao
rev = (TP/(TP+FN)) * 100;
fprintf('Revocacao: %f\n', rev);

%f-medida
fmed = 2 * (rev*pcs)/(rev+pcs);  
fprintf('F-Medida: %f\n', fmed);

