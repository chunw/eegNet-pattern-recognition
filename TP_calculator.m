TP = 0;
FN = 0;
FP = 0;
TN = 0;

for i=1:size(spike_record,1)
    if class(spike_record(i,1)) == 'E'
        TP=TP+1;
    end
    if class(spike_record(i,1)) == 'N'
        FN=FN+1;
    end
end
for i=1:n
    if ~ismember(i,spike_record)
       if class(i) == 'E' 
           FP=FP+1;
       end
      
       if class(i) == 'N'
           TN=TN+1;
       end
    end
end
