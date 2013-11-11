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
lambda = 0;
                          

%  Configura a matriz apropriadamente e adiciona uns na primeira coluna
[m, n] = size(x);

%adiciona coluna de 1's na matriz x
X = [ones(m, 1) x];
 
%gera valores randomicos entre 0 e 1 para os thetas
theta_1 = rand(n + 1, tam_cam_inter);
theta_2 = rand(tam_cam_inter + 1, tam_cam_saida); 

J = 0;
Theta1_grad = zeros(size(theta_1));
Theta2_grad = zeros(size(theta_2));

%X_1 = X * theta_1;

%forward-propagation
% a1 = X;
%z2 = X * theta_1;
%a2 = sigmoid(z2);
%a2 = [ones(m,1) a2];
%z3 = a2 * theta_2;  
%h_theta = sigmoid(z3); %a3 = h_theta = z3
% h_theta


% funçao de custo
%J = (1/m) * sum ( sum (  (-Y)' .* log(h_theta) -  (1-Y)' .* log(1-h_theta) )); % nao está funcionando

%Forward Propagation + Calculo de Custo

a1 = X;
z2 = a1 * theta_1';
a2 = sigmoid(z2);
a2 = [ones(m , 1)  a2];
a3 = sigmoid(a2 * theta_2');

ident = eye(num_labels)(Y,:);

custo = ident.*log(a3) + (1 - ident).*log(1 - a3);
J = -sum(sum(custo,2)) / m;

reg = sum(sum(theta_1(:,2:end).^2)) + sum(sum(theta_2(: , 2:end).^2));

J = J + lambda/(2*m)*reg;

%

%backpropagation

delta3 = a3 - ident;
delta2 = (delta3*theta_2)(:,2:end) .* sigmoidGradiente(z2);

Delta1 = delta2'*a1;
Delta2 = delta3'*a2;

Theta1_grad = Delta1 / m + lambda*[zeros(hidden_layer_size , 1) theta_1(:,2:end)] / m;
Theta2_grad = Delta2 / m + lambda*[zeros(num_labels , 1) theta_2(:,2:end)] / m;

%

res = [Theta1_grad(:), Theta2_grad(:)];

%% Finalizacao
%clear; close all;