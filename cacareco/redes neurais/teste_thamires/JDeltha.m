function [J, grad] = rn_JDeltha(theta, X, y, tam_cam_entrada, tam_cam_inter, tam_cam_saida)
  
[m, n] = size(X);
lambda = 0.8;

theta_1 = reshape( theta(1:tam_cam_inter * (tam_cam_entrada + 1)), (tam_cam_entrada + 1), tam_cam_inter );
theta_2 = reshape( theta((1 + (tam_cam_inter * (tam_cam_entrada + 1))):end), (tam_cam_inter + 1) , tam_cam_saida);

%================= Forward Propagation + Calculo de Custo
a1 = [ones(m , 1) X];
z2 = a1 * theta_1;
a2 = sigmoid(z2);
a2 = [ones(m , 1) a2];
z3 = a2 * theta_2;
a3 = sigmoid(z3);

reg_c = (lambda  * sum( theta_1(2:end) .^2 ) )/ (2 * m);
reg_c = reg_c + (lambda  * sum( theta_2(2:end) .^2 ) )/ (2 * m);

b = (( 1 .- y) .* log( 1 .- a3 ) ); 
J = sum(sum( -y.*(log( a3 ) ) - b ) / m ) + reg_c ;

%================= Back Propagation 

d3 = (a3 - y);
d2 = d3 * theta_2'.* (a2.*(1-a2));
d2(:,1) = [];%remove o bias

deltha1 = a1' * d2;
deltha2 = a2' * d3;

% ================ Calcula novo theta

D_1 =   lambda * deltha1; 
D_2 =   lambda * deltha2;

theta_1 = D_1 - theta_1;
theta_2 = D_2 - theta_2;


grad = [theta_1(:) ; theta_2(:)];

end