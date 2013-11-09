data = load('base.txt');

% Separa os atribuos na matriz X, e Y
x = data(:, 1:size(data,2)-1 ); 
y = data(:, size(data,2) );
tam_Y = size(y,1);

p1 = sum(y)/tam_Y; %prob classe 1
p0 = (tam_Y - sum(y))/tam_Y; % prob classe 0

p1
p0