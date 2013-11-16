%% Inicializacao
clear ; close all; clc;

fprintf('Carregando os dados...\n\n');

% Carrega os dados da base
data = load('base.txt');
X = data(:, 1:end-1 ); 
Y = data(:, end );
%load('base_rl.mat');
%Y=y;
[m, n] = size(X);

%% Seta parametros
tam_cam_entrada  = n;  % quantidade de neuronios na camada de entrada 
tam_cam_saida    = 1;  % quantidade de neuronios na camada de saida
tam_cam_inter    = 15;  % quantidade de neuronios na camada intermediaria
                          
 
%Inicialização do theta inicial com valores proximos de zero
%init = 0.1;
%theta_1 = init - (2 * init) .* rand(n+1, tam_cam_inter) ;
%theta_2 = init - (2 * init) .* rand(tam_cam_inter+1, tam_cam_saida) ;
theta_1 = 0.1*(1-2*rand(tam_cam_entrada+1,tam_cam_inter));
theta_2 = 0.1*(1-2*rand(tam_cam_inter+1,tam_cam_saida));

theta_inicial = [theta_1(:) ; theta_2(:)];

%================================= Funcao FMINUNC ========================================
op = optimset('GradObj', 'on');

[theta, custo] = ...
  fminunc(@(t)(JDeltha(t,X, Y, tam_cam_entrada, tam_cam_inter,tam_cam_saida)), theta_inicial, op);


%================================= Classificar

theta_1 = reshape( theta(1:tam_cam_inter * (tam_cam_entrada + 1)), (tam_cam_entrada + 1), tam_cam_inter );
theta_2 = reshape( theta((1 + (tam_cam_inter * (tam_cam_entrada + 1))):end), (tam_cam_inter + 1) , tam_cam_saida);

a1 = [ones(m , 1)  X];
a2 = sigmoid(a1 * theta_1);
a2 = [ones(m , 1)  a2];
a3 = sigmoid(a2 * theta_2);

m = size(a3, 1); 
p = zeros(m, 1);

% Calcular a sigmoidal
%media = mean(a3);
media = 0.5;
sig = a3;

% Classificar as amostras
for i=1:m 
  if ( sig(i)  >= media)
    p(i) = 1;
  else
    p(i) = 0;
  end
end;
p;
ac = (sum(Y == p)/size(Y,1)) * 100;
fprintf('Acuracia: %f\n', ac);
%% Finalizacao
%clear; close all;