%% Inicializacao
clear ; close all; clc;

fprintf('Carregando os dados...\n\n');

% Carrega os dados da base
data = load('base.txt');
% Separa os atribuos na matriz X, e Y
x = data(:, 1:end-1 ); 
Y = data(:, end );


%% Seta parametros
tam_cam_entrada  = 137; % quantidade de neuronios na camada de entrada 
tam_cam_saida  = 2;     % quantidade de neuronios na camada de saida
tam_cam_inter = 274;    % quantidade de neuronios na camada intermediaria
num_cam = 3;            % quantidades de camadas   
                          

%  Configura a matriz apropriadamente e adiciona uns na primeira coluna
[m, n] = size(x);

%adiciona coluna de 1's na matriz x
X = [ones(m, 1) x];
 
%gera valores randomicos entre 0 e 1 para os thetas
theta_1 = rand(n + 1, tam_cam_inter);
theta_2 = rand(tam_cam_inter + 1, tam_cam_saida); 

%X_1 = X * theta_1;

%forward-propagation
% a1 = X;
z2 = X * theta_1;
a2 = sigmoid(z2);
a2 = [ones(m,1) a2];
z3 = a2 * theta_2;  
h_theta = sigmoid(z3); %a3 = h_theta = z3
% h_theta


% funçao de custo
J = (1/m) * sum ( sum (  (-Y)' .* log(h_theta) -  (1-Y)' .* log(1-h_theta) )); % nao está funcionando



%% Finalizacao
%clear; close all;