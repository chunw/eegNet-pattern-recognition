%clutersing with SVM
training = [WT_EP;WT_NEP];
EP = repmat('E',size(WT_EP,1),1);
NEP = repmat('N',size(WT_NEP,1),1);
groups = [EP;NEP];
SVMStruct = svmtrain(training,groups,'kernel_function','polynomial');

save SVMStruct
clear EP NEP groups training 




