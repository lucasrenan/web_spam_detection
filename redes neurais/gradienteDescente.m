function [theta, J_historico] = gradienteDescente(X, y, theta_1,theta_2, alpha, num_iter)
%GRADIENTEDESCENTE Executa o gradiente descente para aprender e otimizar theta
%   theta = GRADIENTEDESENTE(X, y, theta, alpha, num_iter) atualiza theta usando 
%   num_iter passos do gradiente com taxa de aprendizado alpha

% Initializa algumas variaveis uteis
m = length(y); % numero de exemplos de treinamento
J_historico = zeros(num_iter, 1);
theta = [theta_1(:)' theta_2(:)'];


for iter = 1:num_iter

    % ====================== ESCREVA O SEU CODIGO AQUI ====================
    % Instrucoes: Execute um unico passo do gradiente para ajustar o vetor
    %             theta. 
    %
    % Dica: para verificar se a o gradiente esta correto, verifique se a 
    %       funcao de custo (computarCusto) nunca aumenta de valor no 
    %       decorrer das iteracoes. Para facilitar, em ex02.m ha uma funcao
    %       que plota o custo J no decorrer das iteracoes. A linha nunca
    %       pode ser crescente. Se for, reduza alpha.
    %
    % ============================================================
    % Armazena o custo J obtido em cada iteracao do gradiente    
    
    
    theta0 = theta_1 - alpha*(sum(X*theta-y)./m);
     
    theta1 = theta_2 - alpha*(sum((X*theta-y)'*X(1:m,2))./m);
    
    
    theta = [theta0
             theta1];
    
    J_historico(iter) = computarCusto(X, y, theta);

end
 
 
 

end
