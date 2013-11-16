clear
% Set up parameters
nInput = 4; % number of nodes in input
nOutput = 1; % number of nodes in output
nHiddenLayer = 7; % number of nodes in th hidden layer
nTrain = 100; % size of training set
epsilon = 0.01; % learning rate


% Set up the inputs: random coefficients between -1 and 1
trainExamples = 2*rand(nInput,nTrain)-1;
trainExamples(nInput,:) = ones(1,nTrain);  %set the last input to be 1

% Set up the student neurons for both hidden and the output layers
S1(nHiddenLayer,nTrain) = 0;
S2(nOutput,nTrain) = 0;

% The student neuron starts with random weights from both input and the hidden layers
w1 = rand(nInput,nHiddenLayer);
w2 = rand(nHiddenLayer+1,nOutput);

% Calculate the teacher outputs according to the quadratic formula
T = sign(trainExamples(2,:).^2-4*trainExamples(1,:).*trainExamples(3,:));


% Initialise values for looping
nEpochs = 0;
nWrong = nTrain*0.01;
Wrong = [];
Epoch = [];

while(nWrong >= (nTrain*0.01)) % as long as more than 1% of outputs are wrong
    for i=1:nTrain
        x = trainExamples(:,i);
        S1(1:nHiddenLayer,i) = w1'*x;
        S2(:,i) = w2'*[tanh(S1(:,i));1];
        delta1 = tanh(S2(:,i)) - T(:,i); % back propagate
        delta2 = (1-tanh(S1(:,i)).^2).*(w2(1:nHiddenLayer,:)*delta1); % back propagate       
        w1 = w1 - epsilon*x*delta2'; % update
        w2 = w2 - epsilon*[tanh(S1(:,i));1]*delta1'; % update
    end

    outputNN = sign(tanh(S2));
    delta = outputNN - T; % difference between student and teacher
    nWrong = sum(abs(delta/2));
    nEpochs = nEpochs + 1;
    Wrong = [Wrong nWrong];
    Epoch = [Epoch nEpochs];
    %nWrong
end

 x = trainExamples;  
 S1 = w1'*x;
 S2 = S1'*w2(2:end,:);

size(T)
size(S2)
for i=1:size(T,2) 
  if ( S2(i,1)   >= 0.5)
    p(i) = 1;
  else
    p(i) = 0;
  end
end;
p
ac = (sum(T == p)/size(T,2)) * 100;
fprintf('Acuracia: %f\n', ac);

