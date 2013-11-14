%% Inicializacao
clear ; close all; clc;

fprintf('Carregando os dados...\n\n');

% Carrega os dados da base
data = load('base.txt');
%X = data(:, 1:end-1 ); 
%Y = data(:, end );
load('base_rl.mat');

%X = x;
Y=y;
[m, n] = size(X);
m
n
%% Seta parametros
tam_cam_entrada  = n;                    % quantidade de neuronios na camada de entrada 
tam_cam_saida    = 1;                    % quantidade de neuronios na camada de saida
tam_cam_inter    = tam_cam_entrada * 2;  % quantidade de neuronios na camada intermediaria
num_cam          = 3;                    % quantidades de camadas   
lambda = 0;
                          
 
%Inicialização do theta inicial com valores proximos de zero
theta_1 = rand(n + 1, tam_cam_inter);
theta_2 = rand(tam_cam_inter + 1, tam_cam_saida); 

theta_inicial = [theta_1(:) ; theta_2(:)];
%theta_inicial = [theta_1(:)' theta_2(:)']


%================================= Funcao FMIUNC ========================================
opcoes = optimset('GradObj', 'on', 'MaxIter', '100');

[theta, custo] = ...
  fminunc(@(t)(JDeltha(t,X, Y, tam_cam_entrada, tam_cam_inter,tam_cam_saida)), theta_inicial, opcoes);

custo
%classificar

theta_1 = reshape( theta(1:tam_cam_inter * (tam_cam_entrada + 1)), (tam_cam_entrada + 1), tam_cam_inter );
theta_2 = reshape( theta((1 + (tam_cam_inter * (tam_cam_entrada + 1))):end), (tam_cam_inter + 1) , tam_cam_saida);

a1 = [ones(m , 1)  X];
z2 = a1 * theta_1;
a2 = sigmoid(z2);
a2 = [ones(m , 1)  a2];
z3 = a2 * theta_2;
a3 = sigmoid(z3);

m = size(a3, 1); % Tamanho das amostras de X
p = zeros(m, 1);

% Calcular a sigmoidal
%sig = sigmoid( X * theta );
sig = a3;

% Classificar as amostras
for i=1:m 
  if ( sig(i)  >= 0.5)
    p(i) = 1;
  else
    p(i) = 0;
  end
end;
ac = (sum(Y == p)/size(Y,1)) * 100;
fprintf('Acuracia: %f\n', ac);
%res = [Theta1_grad(:), Theta2_grad(:)];

%% Finalizacao
%clear; close all;