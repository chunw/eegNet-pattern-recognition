function class = LR(sample)
weights =   [0.5306 0.5000 0.5000 0.5000 0.5000 0.4998];
cutting_t = 1.4696e+003;
estimators = zeros(size(sample,1),1); %an estimator is a linear combination of wavelet features from d4 thr d8
for i = 1:size(sample,1)
    estimators(i) = weights(1) + sample(i,1)*weights(2) + ...
        sample(i,2)*weights(3) + sample(i,3)*weights(4)...
        + sample(i,4)*weights(5) + sample(i,5)*weights(6);
end
class = char(zeros(size(sample,1),1));
for i=1:size(sample,1)
    if estimators(i)>cutting_t
        class(i) = 'E';
    end
    if estimators(i)<=cutting_t
        class(i) = 'N';
    end
end
end %EOF