function sg = sigmoidGradiente(z)

sg = zeros(size(z));
g = sigmoid(z) .* (1 - sigmoid(z));