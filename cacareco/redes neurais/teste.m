clear ; close all; clc;
load('base_rl.mat');

Y=y;


[m, n] = size(X);
X = [ones(m , 1) X];
[m, n] = size(X);
tam_cam_entrada  = n;                    % quantidade de neuronios na camada de entrada 
tam_cam_saida    = 1;                    % quantidade de neuronios na camada de saida
tam_cam_inter    = 3;  % quantidade de neuronios na camada intermediaria
num_cam          = 3; 

numItrs = 100;
epsilon = 0.001;
theta_1 = 0.5*(1-2*rand(n+1,tam_cam_inter));
theta_2 = 0.5*(1-2*rand(tam_cam_inter+1,tam_cam_saida));
theta_1 = theta_1';

%media = mean(X);
%X_norm = bsxfun(@minus, X, media);

%Calcular o desvio padrao
%desvio = std(X_norm);
%x = bsxfun(@rdivide, X_norm, desvio);

for train=1:numItrs
        for iterator=1:m

            %%%%%%%% FORWARD PROPAGATION %%%%%%%%

            % Grab the inputs, which are rows of the inputFeatures matrix
            a1 = X(iterator, :)'; %don't forget to turn into column 
            % Calculate the hidden layer outputs: 
            a2 = sigmoid(theta_1' * a1); 
            % Now the output layer outputs:
            a3 = sigmoid(theta_2' * a2);

            %%%%%%% Debug stuff %%%%%%%% (for single valued output)
            if (mod(train+iterator, 100) == 0)
               str = strcat('Output value: ', num2str(a3), ' | Test value: ', num2str(Y(iterator, :)')); 
               disp(str);
            end 




            %%%%%%%% BACKWARDS PROPAGATION %%%%%%%%

            % Propagate backwards for the hidden-output weights
            %currentTargets = Y(iterator, :); %strip off the row, make it a column for easy subtraction
            d3 = (a3 - Y);
            delta3 = a2 * d3; %outer product
            % Update this layer's weight matrix:
            theta_2 = theta_2 - epsilon*delta3; %does it element by element

            % Propagate backwards for the input-hidden weights
            d2 = a2 .* (1 - a2) .* theta_2*d3; 
            delta2 = a1 * d2'; 
            theta_1 = theta_1 - epsilon*delta2; 

        end

end

a1 = X(:, :)'; %don't forget to turn into column 
            % Calculate the hidden layer outputs: 
            a2 = sigmoid(theta_1' * a1); 
            % Now the output layer outputs:
            a3 = sigmoid(theta_2' * a2);

sig = a3

% Classificar as amostras
for i=1:m 
  if ( sig(i)  >= 0.5)
    p(i) = 1;
  else
    p(i) = 0;
  end
end;
p
ac = (sum(Y == p)/size(Y,1)) * 100;
fprintf('Acuracia: %f\n', ac);


