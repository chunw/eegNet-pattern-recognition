function class_knn = KNN_classifier(WT_EP,WT_NEP,sample)
%clustering with k-nearest neighbors using features from d4 thr d8
training = [WT_EP;WT_NEP];
EP = repmat('E',size(WT_EP,1),1);
NEP = repmat('N',size(WT_NEP,1),1);
groups = [EP;NEP];

%perform k-nearest-neighbor clustering, classifying each row of the data in
%sample into one of the two groups in training.
class_knn = knnclassify(sample, training, groups);
end






