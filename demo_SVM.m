%two-step sliding window

%choose one file
file = 'ep_record.txt';
%file = 'ybs_record.txt';

WT_EP = wavelet_scanning_EP(file); %pre-labeled EP data 
WT_NEP = wavelet_scanning_NEP(file); %pre-labeled NEP data 

%SVM training
SVM_training; %with polynomial kernel

%testing
if strcmp(file,'ep_record.txt')
load 'ep_record.txt'
X = ep_record;
end

if strcmp(file,'ybs_record.txt')
load 'ybs_record.txt'
X = ybs_record;
end

FNCount = [];
FPCount = [];
TNCount = [];
TPCount = [];
DetectionCount = [];

CLASS = cell(1,3);
cindex = 1; 
dataset_id = 0;
chan_num = 0;

for iter = 41:60
     if X(iter,4) ~= dataset_id || X(iter,5) ~= chan_num
        dataset_id = X(iter,4);
        chan_num = X(iter,5);
        CLASS{cindex,1} = dataset_id;
        CLASS{cindex,2} = chan_num;
        
        sample_data; %first time window sliding
        class = svmclassify(SVMStruct,sample); %SVM METHOD
        
        sample_data2; %second time window sliding
        class2 = svmclassify(SVMStruct,sample2); %SVM METHOD
       
       
        merge_class; 
        CLASS{cindex,3} = class;
        cindex = cindex+1;
        count_detections;
        spike_record = sort_channel_record(file,dataset_id,chan_num); 
        TP_calculator;
        
        
        FNCount = [FNCount;FN];
        FPCount = [FPCount;FP];
        TNCount = [TNCount;TN];
        TPCount = [TPCount;TP];
        DetectionCount = [DetectionCount;count];
        
        
        clear c4 c5 c6 c7 c8 d4 d5 d6 d7 d8 d4_sqr d5_sqr d6_sqr d7_sqr...
            d8_sqr ybs l4 l5 l6 l7 l8 data groups training win WT_NEP...
            WT_EP sample sample2 class class2
        
    end
end

Sensitivity = sum(TPCount) / (sum(TPCount)+ sum(FNCount))*100;
Specificity = sum(TNCount) / (sum(FPCount)+ sum(TNCount))*100;
PPV = sum(TPCount) / (sum(TPCount)+ sum(FPCount))*100; %positive predictive value
NPV =  sum(TNCount) / (sum(TNCount)+ sum(FNCount))*100; %negative predictive value

clear FN FP TN TP FNCount FPCount TNCount TPCount X EP NEP iter n count...
    cindex SVMStruct

postClassification;
genAnnotation;