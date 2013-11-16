function [J, theta] = rn_JDeltha(theta, X, y, tam_cam_entrada, tam_cam_inter, tam_cam_saida)
% Função rn_JDeltha
% 	Calcula o custo e os thetas para serem otimizados.
%
% Entrada:
%  theta           = theta das camadas concatenados
%  X               = Matriz com os atributos e amostras da base
%  y               = Matriz com as classes da base
%  tam_cam_entrada = Quantidade de neuronios da camada de entrada
%  tam_cam_inter   = Quantidade de neuronios da camada intermediaria
%  tam_cam_saida   = Quantidade de neuronios  da camada de saida
%
% Saída:
%   J     = Custo
%   theta = theta das camadas concatenados e atualizados
% ============================================================

%Inicializar variaveis
[m, n] = size(X);
lambda = 0.8;

%Separar os thetas das camadas
theta_1 = reshape( theta(1:tam_cam_inter * (tam_cam_entrada + 1)), (tam_cam_entrada + 1), tam_cam_inter );
theta_2 = reshape( theta((1 + (tam_cam_inter * (tam_cam_entrada + 1))):end), (tam_cam_inter + 1) , tam_cam_saida);

%================= Forward Propagation + Calculo de Custo
%Adiciona o bias, e calcula a sigmoidal
a1 = [ones(m , 1) X];
a2 = sigmoid(a1 * theta_1);
a2 = [ones(m , 1) a2];
a3 = sigmoid(a2 * theta_2);

%Calcula o custo
reg_c = (lambda  * sum( theta_1(2:end) .^2 ) )/ (2 * m);
reg_c = reg_c + (lambda  * sum( theta_2(2:end) .^2 ) )/ (2 * m);

b = (( 1 .- y) .* log( 1 .- a3 ) );
J = sum(sum( -y.*(log( a3 ) ) - b ) / m ) + reg_c ;

%================= Back Propagation
% Calcula os erros e propaga
d3 = (a3 - y);
d2 = d3 * theta_2'.* (a2.*(1-a2));
d2(:,1) = [];%remove o bias

deltha1 = a1' * d2;
deltha2 = a2' * d3;

% ================ Calcula os novos thetas

D_1 =   lambda * deltha1;
D_2 =   lambda * deltha2;

theta_1 = D_1 - theta_1;
theta_2 = D_2 - theta_2;

% Concatena os thetas das camadas
theta = [theta_1(:) ; theta_2(:)];

% ==================================================================

end
