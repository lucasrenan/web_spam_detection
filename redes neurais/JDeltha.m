function [J, grad] = JDeltha(theta, X, y, tam_cam_entrada, tam_cam_inter, tam_cam_saida)
  
[m, n] = size(X);
lambda = 1;

theta_1 = reshape( theta(1:tam_cam_inter * (tam_cam_entrada + 1)), (tam_cam_entrada + 1), tam_cam_inter );
theta_2 = reshape( theta((1 + (tam_cam_inter * (tam_cam_entrada + 1))):end), (tam_cam_inter + 1) , tam_cam_saida);

% ================ Printa valores
valor_theta1 = theta_1(1,2)
valor_theta2 = theta_2(1,1)

tam_theta1 = size(theta_1)
tam_theta2 = size(theta_2)

%================= Forward Propagation + Calculo de Custo
a1 = [ones(m , 1)  X];
z2 = a1 * theta_1;
a2 = sigmoid(z2);
a2 = [ones(m , 1)  a2];
z3 = a2 * theta_2;
a3 = sigmoid(z3);

reg_c = (lambda  * sum( theta_1(2:end) .^2 ) )/ (2 * m);
reg_c = reg_c + (lambda  * sum( theta_2(2:end) .^2 ) )/ (2 * m);
J = (sum( -y.*(log( a3 ) ) - (( 1 .- y) .* log( 1 .- a3 ) )  ) / m ) + reg_c ;

%================= Back Propagation 

d3 = a3 - y;
d2 = (d3*theta_2').* (a2.* (1-a2));

deltha1 = a1' * d2;
deltha2 = a2' * d3;

%=================Printa valores
tamd3 = size(d3);
tamd2 = size(d2);
tamdel1 = size(deltha1);
tamdel2 = size(deltha2);

theta_c_1 = theta_1;
theta_c_1(1) = 0;

theta_c_2 = theta_2;
theta_c_2(1) = 0;

D_1 = (deltha1(:,2:end)/m) + (lambda * theta_c_1); 
D_2 = (deltha2/m) + (lambda * theta_c_2); 

%=================Printa valores
tamD1 = size(D_1)
tamD2 = size(D_2)

grad = [D_1(:) ; D_2(:)];
%grad = [D_1(:)' D_2(:)'];
J

end