%% Inicializacao
clear ; close all; clc;

fprintf('Carregando os dados...\n\n');

% Carrega os dados da base
data = load('base.txt');
% Separa os atribuos na matriz X, e Y
x = data(:, 1:end-1 ); 
Y = data(:, end );
%load('base_rl.mat');

X = x;
%Y = y;
%% Seta parametros
%tam_cam_entrada  = 137; % quantidade de neuronios na camada de entrada 
tam_cam_entrada  = size(x,2); % quantidade de neuronios na camada de entrada 
tam_cam_saida    = 1;     % quantidade de neuronios na camada de saida
%tam_cam_inter = 274;    % quantidade de neuronios na camada intermediaria
tam_cam_inter = tam_cam_entrada * 2;    % quantidade de neuronios na camada intermediaria
num_cam = 3;            % quantidades de camadas   
lambda = 0;
                          

%  Configura a matriz apropriadamente e adiciona uns na primeira coluna
[m, n] = size(x);

%adiciona coluna de 1's na matriz x
%X = [ones(m, 1) x];
 
%gera valores randomicos entre 0 e 1 para os thetas
theta_1 = 1 + (-1-1).*rand(n + 1, tam_cam_inter);
theta_2 = 1 + (-1-1).*rand(tam_cam_inter + 1, tam_cam_saida); 
tam_t1 = size(theta_1)
tam_t2 = size(theta_2)
%theta_inicial = [theta_1(:) ; theta_2(:)];
theta_inicial = [theta_1(:)' theta_2(:)'];
tam_theta_ini = size(theta_inicial)
opcoes = optimset('GradObj', 'on', 'MaxIter', '100');

[theta, custo] = ...
  fminunc(@(t)(JDeltha(t, X, Y, tam_cam_entrada, tam_cam_inter,tam_cam_saida)), theta_inicial, opcoes);
custo
%classificar

m = size(X, 1); % Tamanho das amostras de X
p = zeros(m, 1);

% Calcular a sigmoidal
sig = sigmoid( X * theta );

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