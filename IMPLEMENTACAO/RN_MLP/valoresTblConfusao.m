function [TP, FP, FN] = valoresTblConfusao(Y, y)

TP=0;
FP=0;
FN=0;

tam_Y = size(Y,1);

  for i=1:tam_Y
    if Y(i) == y(i) && y(i) == 1
      TP=TP+1;
    end

    if Y(i) ~= y(i) && Y(i) == 0
      FN= FN+1;
    end

    if Y(i) ~= y(i) && Y(i) == 1
      FP=FP+1;
    end
  end

end
