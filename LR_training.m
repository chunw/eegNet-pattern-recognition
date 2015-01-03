%use logistic regression to find optimal weights on wavelet decomposition levels
X = [W;W2];
y = [repmat(ones,size(W,1),1);repmat(zeros,size(W2,1),1)];%response matrix 
b = glmfit(X,y,'normal'); %The first element of b is the constant term
weights = 1 ./ (1 + exp(-b));

%decide grand totals that would estimate how likely 
%the spikes could be EP
Estimators = zeros(size(W,1),1);
Estimators2 = zeros(size(W2,1),1);
for i = 1:size(W,1)
    Estimators(i) = weights(1) + W(i,1)*weights(2) + ...
        W(i,2)*weights(3) + W(i,3)*weights(4)...
        + W(i,4)*weights(5) + W(i,5)*weights(6);
end
for i = 1:size(W2,1)
    Estimators2(i) = weights(1) + W2(i,1)*weights(2) + ...
        W2(i,2)*weights(3) + W2(i,3)*weights(4)...
        + W2(i,4)*weights(5) + W2(i,5)*weights(6);
end

%find the best working cutting estimator value (cutting_t)
MAX = max(Estimators); 
if MAX < max(Estimators2)
    MAX = max(Estimators2);
end
MIN = min(Estimators2); 
if MIN > min(Estimators)
    MIN = min(Estimators);
end

mis_cats = [];
w = 1;
p = MIN;
while p < MAX 
    cutting_t = p;
    mis_cats = [mis_cats; [size(find(Estimators2>cutting_t),1)+size(find(Estimators<cutting_t),1) p]];
    w = w+1;
    p = p+1;
end
for i=1:size(mis_cats,1)
    if mis_cats(i,1) == min(mis_cats(:,1)) 
        best_p = mis_cats(i,2);
    end
end
cutting_t = best_p; 
mis_cat = min(mis_cats(:,1));
mis_cat_rate = mis_cat/(size(W,1)+size(W2,1)); %rate of miscategorization
