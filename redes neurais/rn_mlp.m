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
lambda = 0;
                          

%  Configura a matriz apropriadamente e adiciona uns na primeira coluna
[m, n] = size(x);

%adiciona coluna de 1's na matriz x
X = [ones(m, 1) x];
 
%gera valores randomicos entre 0 e 1 para os thetas
%theta_1 = rand(n + 1, tam_cam_inter);
theta_1 = 1 + (-1-1).*rand(n + 1, tam_cam_inter);
theta_2 = 1 + (-1-1).*rand(tam_cam_inter + 1, tam_cam_saida); 

%theta_1 = rand(n + 1, 1);
%theta_2 = rand(tam_cam_inter + 1, 2); 

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
size(theta_1)
size(theta_2)
a1 = X;
z2 = a1 * theta_1;
a2 = sigmoid(z2);
a2 = [ones(m , 1)  a2];
z3 = a2 * theta_2;
a3 = sigmoid(z3);

%custo = ident.*log(a3) + (1 - ident).*log(1 - a3);
%J = -sum(sum(custo,2)) / m;

%reg = sum(sum(theta_1(:,2:end).^2)) + sum(sum(theta_2(: , 2:end).^2));

%J = J + lambda/(2*m)*reg;

% Voce precisa retornar as seguintes variaveis corretamente
J = 0;
% Initializa variaveis
lambda = 1;

y = Y;

reg_c = (lambda  * sum(  theta_2(2:size(theta_2)) .^2 ) )/ (2 * m);
J = (sum( -y.*(log( a3 ) ) - (( 1 .- y) .* log( 1 .- a3 ) )  ) / m )  ;

J

%

%backpropagation

d3 = a3 - Y;
d2 = (d3*theta_2').* (a2.* (1-a2));%sigmoidGradiente(z2);

%deltao1 = a1 * delta2;
deltha2 = a2' * d3;

%Delta1 = delta2'*a1;
%Delta2 = delta3'*a2;
theta_c_1 = theta_1;
theta_c_2 = theta_2;
theta_c_2(1) = 0;
theta_c_1(1) = 0;

%Delta1 = (deltao1/m) + (lambda * theta_c_1);
Delta = (deltha2/m) + (lambda * theta_c_2);	

delta_unico = Delta;
delta_unico = delta_unico';
delta_unico = delta_unico(:);

%Theta1_grad = Delta1 / m + lambda*[zeros(hidden_layer_size , 1) theta_1(:,2:end)] / m;
%Theta2_grad = Delta2 / m + lambda*[zeros(num_labels , 1) theta_2(:,2:end)] / m;

%
opcoes = optimset('GradObj', 'on');
[theta, custo] = ...
	fminunc(@(t)(JDeltha(J,delta_unico)), theta_1);
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