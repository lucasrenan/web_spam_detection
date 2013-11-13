function [J, grad] = JDeltha(theta, X, y,tam_cam_entrada, tam_cam_inter,num_cam)
  
 [m, n] = size(X);

theta_1 = reshape( theta(1:tam_cam_inter * (tam_cam_entrada + 1)), (tam_cam_entrada + 1),tam_cam_inter );
valor_theta1 = theta_1(1,2)
tam_theta1 = size(theta_1)
theta_2 = reshape( theta((1 + (tam_cam_inter * (tam_cam_entrada + 1))):end), (tam_cam_inter + 1) , num_cam);
valor_theta2 = theta_2(1,1)
tam_theta2 = size(theta_2)
 %Forward Propagation + Calculo de Custo
a1 = X;
z2 = a1 * theta_1;
a2 = sigmoid(z2);
a2 = [ones(m , 1)  a2];
z3 = a2 * theta_2;
a3 = sigmoid(z3);
tam_a3 = size(a3)
% Initializa variaveis
lambda = 1;

reg_c = (lambda  * sum(  theta_2(2:size(theta_2)) .^2 ) )/ (2 * m);
J = (sum( -y.*(log( a3 ) ) - (( 1 .- y) .* log( 1 .- a3 ) )  ) / m ) + reg_c ;

%backpropagation

d3 = a3 - y;
d2 = (d3*theta_2').* (a2.* (1-a2));%sigmoidGradiente(z2);

deltha1 = a1' * d2;
deltha2 = a2' * d3;

%Theta1_grad = Delta1 / m + lambda*[zeros(hidden_layer_size , 1) Theta1(:,2:end)] / m;
%Theta2_grad = Delta2 / m + lambda*[zeros(num_labels , 1) Theta2(:,2:end)] / m;

theta_c_1 = theta_1;
theta_c_1 = [zeros(size(theta_1,1) , 1) theta_c_1];

theta_c_2 = theta_2;
theta_c_2(1) = 0;

D_1 = (deltha1/m) + (lambda * theta_c_1); 

D_1 = D_1(:,2:end);
D_2 = (deltha2/m) + (lambda * theta_c_2); 

tam_d1 = size(D_1)
tam_d2 = size(D_2)
delta_unico = [D_1(:) ; D_2(:)];
tam_delta_unico = size(delta_unico)
teste1 = reshape( delta_unico(1:tam_cam_inter * (tam_cam_entrada + 1)), (tam_cam_entrada + 1),tam_cam_inter );
teste2 = reshape( delta_unico((1 + (tam_cam_inter * (tam_cam_entrada + 1))):end), (tam_cam_inter + 1) , num_cam);
size(teste1)
size(teste2)
%delta_unico = [D_1(:)' D_2(:)' ];

%custo = J;
grad = delta_unico;
J
%size(delta)
%size(delta)

end