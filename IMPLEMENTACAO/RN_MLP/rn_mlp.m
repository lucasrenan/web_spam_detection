% ============== Redes Neurais MultiLayer Perceptron ======================
%
% Arquivo principal de chamada para rodar redes neurais
%
% =========================================================================

%% Inicializacao
clear ; close all; clc;

disp('Carregando os dados... Aguarde.');
%fflush(stdout);

% Carrega os dados da base
data = load('../base.txt');
X = data(:, 1:end-1 );
Y = data(:, end );

%------------------- Inicializar variaveis -----------------------------
%Normalizar a base
X = normalizarAtributos(X);

[m, n] = size(X);

%% Inicializar Parâmetros
tam_cam_entrada  = n;  % quantidade de neuronios na camada de entrada
tam_cam_inter    = 20; % quantidade de neuronios na camada intermediaria
tam_cam_saida    = 1;  % quantidade de neuronios na camada de saida

%Carregar thetas predefinidos para a base de dados
disp('Carregar os thetas pre-definidos. Caso deseje, descomente o código para ser gerado randomico.');
%fflush(stdout);
theta_inicial = load('theta_ini');

%Caso deseje, os thetas podem ser carregados de forma randomica, descomente  o código abaixo
%disp('Gerando thetas randômicos.');
%fflush(stdout);
%theta_1 = 0.1*(1-2*rand(tam_cam_entrada+1,tam_cam_inter));
%theta_2 = 0.1*(1-2*rand(tam_cam_inter+1,tam_cam_saida));
%theta_inicial = [theta_1(:) ; theta_2(:)];


%------------------- Calcular o theta otimo ------------------------------
disp('Calcular o theta ótimo.');
%fflush(stdout);
%Encontrar o theta otimo
op = optimset('GradObj', 'on', 'LargeScale', 'off');
[theta, custo, exit_flag] = ...
  fminunc(@(t)(rn_JDeltha(t,X, Y, tam_cam_entrada, tam_cam_inter,tam_cam_saida)), theta_inicial, op);

%------------------- Classificar as amostras -----------------------------

disp('Classificar as amostras.');
%fflush(stdout);
%Separar os thetas das camadas
theta_1 = reshape( theta(1:tam_cam_inter * (tam_cam_entrada + 1)), (tam_cam_entrada + 1), tam_cam_inter );
theta_2 = reshape( theta((1 + (tam_cam_inter * (tam_cam_entrada + 1))):end), (tam_cam_inter + 1) , tam_cam_saida);

%Classificar
p = rn_predicao(theta_1, theta_2, X);

%------------------- Exibir resultados ---------------------------------
fprintf('Resultados Obtidos com as Redes Neurais Artificiais - MultiLayer Perceptron:\n');
%fflush(stdout);
%Acuracia do algoritmo
ac = (sum(Y == p)/size(p,1)) * 100;
fprintf('Acuracia: %f\n', ac);

% Encontra os valores de TP, FP e FN para calculos
[TP, FP, FN] = valoresTblConfusao(Y, p);

%precisao
pcs = (TP/(TP+FP)) * 100;
fprintf('Precisao: %f\n', pcs);

%revocacao
rev = (TP/(TP+FN)) * 100;
fprintf('Revocacao: %f\n', rev);

%f-medida
fmed = 2 * (rev*pcs)/(rev+pcs);
fprintf('F-Medida: %f\n', fmed);
