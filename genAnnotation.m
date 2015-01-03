function  STR = genAnnotation(dataset_id,chan_num)
%generate a string that contains id's of real spikes and results from 
%all three classifiers(color code: REAL SPIKES: GREEN; DETECTIONS WITH LR:
%YELLOW; DETECTIONS WITH KNN: PURPLE; DETECTIONS WITH SVM: RED)

%generate a string that contains info about TRUE SPIKES
load 'ep_record.txt'
str1 = '&annot=';
for iter = 1:size(ep_record,1)
    if ep_record(iter,4)==dataset_id && ep_record(iter,5)==chan_num
        str = strcat(num2str(ep_record(iter,2)),',',num2str(ep_record(iter,3)),',',...
            num2str(ep_record(iter,4)),',',num2str(ep_record(iter,5)),',green,experts');
        str1 = strcat(str1,str,'|');
    end
end

%generate a string that contains info about DETECTED SPIKES with LR method
load 'S_LR.mat'
str2 = '';
for r = 1:size(S,1)
    if S{r,1} == dataset_id && S{r,2} == chan_num
        for s = 1:size(S{r,3},1)
            str = strcat(num2str(S{r,3}{s,1}(1)),',',num2str(S{r,3}{s,1}(2)),',',...
                num2str(S{r,1}),',',num2str(S{r,2}),',yellow,Linear Regression');
            str2 = strcat(str2,str,'|');
        end
    end
end

load 'S_SVM.mat'
str3 = '';
for r = 1:size(S,1)
    if S{r,1} == dataset_id && S{r,2} == chan_num
        for s = 1:size(S{r,3},1)
            str = strcat(num2str(S{r,3}{s,1}(1)),',',num2str(S{r,3}{s,1}(2)),',',...
                num2str(S{r,1}),',',num2str(S{r,2}),',purple,SVM(linear)');
            str3 = strcat(str3,str,'|');
        end
    end
end

load 'S_KNN.mat'
str4 = '';
for r = 1:size(S,1)
    if S{r,1} == dataset_id && S{r,2} == chan_num
        for s = 1:size(S{r,3},1)
            str = strcat(num2str(S{r,3}{s,1}(1)),',',num2str(S{r,3}{s,1}(2)),',',...
                num2str(S{r,1}),',',num2str(S{r,2}),',red,KNN');
            str4 = strcat(str4,str,'|');
        end
    end
end

%combine the strings
STR = strcat(str1,str2,str3,str4);
end %EOF