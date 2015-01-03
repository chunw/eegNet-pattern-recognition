function spike_record= sort_channel_record(file,dataset_id,chan_num)
x=1;
if strcmp(file,'ybs_record.txt')
    load 'ybs_record.txt'
    x=ybs_record;
end
if strcmp(file,'ep_record.txt')
    load 'ep_record.txt'
    x=ep_record;
end
bandwidth = 256;
channel_record = zeros(size(x,1),6);
index=1;
for i=1:size(x,1)
    if x(i,4) == dataset_id && x(i,5) == chan_num
        channel_record(index,:) = x(i,:);
        channel_record(index,1) = ceil(channel_record(index,2)/bandwidth); %starting cell tells in which win the Spike starts
        channel_record(index,6) = ceil(channel_record(index,3)/bandwidth); %ending cell tells in which win the Spike ends
        index =index+1;
    end
end

%save a list of window#'s which contains a spike
spike_record = zeros(1,1);
sindex=1;
for i=1:size(channel_record,1)
    if channel_record(i,1) ~= 0
        spike_record(sindex,1)=channel_record(i,1);
        sindex=sindex+1;
    end
end
for i=1:size(channel_record,1)
    if channel_record(i,6) ~= 0 && channel_record(i,6)~= channel_record(i,1)
        spike_record(sindex,1)=channel_record(i,6);
        sindex=sindex+1;
    end
end

end %EOF