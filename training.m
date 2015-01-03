wname = 'db4';
bandwidth = 256;
n = ceil(153600/bandwidth);
WT_CO = zeros(1,9);

spike_record = sort_channel_record(file,dataset_id,chan_num); %return the 
%windows  that contain actual spikes in specified dataset and channel

for win = 1:2
    if ~ismember(win,spike_record) 
        data = fetch_eeg_data(dataset_id,chan_num,(win-1)*bandwidth+1,win*bandwidth);
        
        [c4,l4] = wavedec(data,4,wname);
        d4 = wrcoef('d',c4,l4,wname,4);
        d4_sqr = d4.^2;
        d4 = max(d4_sqr);
        
        [c5,l5] = wavedec(data,5,wname);
        d5 = wrcoef('d',c5,l5,wname,5);
        d5_sqr = d5.^2;
        d5 = max(d5_sqr);
        
        
        [c6,l6] = wavedec(data,6,wname);
        d6 = wrcoef('d',c6,l6,wname,6);
        d6_sqr = d6.^2;
        d6 = max(d6_sqr);
        
        
        [c7,l7] = wavedec(data,7,wname);
        d7 = wrcoef('d',c7,l7,wname,7);
        d7_sqr = d7.^2;
        d7 = max(d7_sqr);
        
        [c8,l8] = wavedec(data,8,wname);
        d8 = wrcoef('d',c8,l8,wname,8);
        d8_sqr = d8.^2;
        d8 = max(d8_sqr);
        
        WT_CO(win,2) = dataset_id;
        WT_CO(win,3) = chan_num;
        WT_CO(win,4) = win;
        WT_CO(win,5) = d4;
        WT_CO(win,6) = d5;
        WT_CO(win,7) = d6;
        WT_CO(win,8) = d7;
        WT_CO(win,9) = d8;
    end
    
end % END OF SLIDING WINDOW

save WT_CO
clear c4 c5 c6 c7 c8 d4 d5 d6 d7 d8 d4_sqr d5_sqr d6_sqr d7_sqr d8_sqr
clear l4 l5 l6 l7 l8 data win