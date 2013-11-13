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
tam_cam_saida  = 1;     % quantidade de neuronios na camada de saida
tam_cam_inter = 274;    % quantidade de neuronios na camada intermediaria
num_cam = 3;            % quantidades de camadas   
%lambda = 0;
                          
%  Configura a matriz apropriadamente e adiciona uns na primeira coluna
[m, n] = size(x);
% %adiciona coluna de 1's na matriz x
X = [ones(m, 1) x];
  
%gera valores randomicos entre -1 e 1 para os thetas
theta_1 = 1 + (-1-1).*rand(n + 1, tam_cam_inter);
theta_2 = 1 + (-1-1).*rand(tam_cam_inter + 1, tam_cam_saida); 
 

% %Forward Propagation + Calculo de Custo
%size(theta_1)
%size(theta_2)
a1 = X;
z2 = a1 * theta_1;
a2 = sigmoid(z2);
a2 = [ones(m , 1)  a2];
z3 = a2 * theta_2;
a3 = sigmoid(z3);
 
lambda = 1;
y = Y;

reg_c = (lambda  * sum(  theta_2(2:size(theta_2)) .^2 ) )/ (2 * m);
J = (sum( -y.*(log( a3 ) ) - (( 1 - y) .* log( 1 - a3 ) )  ) / m );


%backpropagation

d3 = a3 - y;
d2 = (d3*theta_2').* (a2.* (1-a2));%sigmoidGradiente(z2);

deltha1 = a1' * d2;
deltha2 = a2' * d3;

%Theta1_grad = Delta1 / m + lambda*[zeros(hidden_layer_size , 1) Theta1(:,2:end)] / m;
%Theta2_grad = Delta2 / m + lambda*[zeros(num_labels , 1) Theta2(:,2:end)] / m;

theta_c_1 = theta_1;
theta_c_1 = [zeros(size(theta_1,1) , 1) theta_1];

theta_c_2 = theta_2;
theta_c_2(1) = 0;

D_1 = (deltha1/m) + (lambda * theta_c_1); 
D_2 = (deltha2/m) + (lambda * theta_c_2); 

%size(D_1)
%size(D_2)
delta_unico = [D_1(:)' D_2(:)'];
%size(delta_unico)
custo = J;
delta = delta_unico;


%gradiente descendente
iteracoes = 1500;
alpha = 0.01;
[theta] = gradienteDescente(X, y, D_1, D_2, alpha, iteracoes);
