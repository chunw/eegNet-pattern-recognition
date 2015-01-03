function spikes = spike_detection(EPWindows,dataset_id,chan_num) 

    m = EPWindows;

    bandwidth = 256;
    window_size = 25;
    NumWin = bandwidth/window_size;
    NumIter = size(m,1);
    threshold = 15;
    
    spikes = cell(1,1);
    spikeId = 1;
    
    for x=1:NumIter
        
        avg = zeros(NumWin,1);
        percentile = zeros(NumWin,1);
        
        startSeq = bandwidth*(EPWindows(x)-1);
        endSeq = startSeq + bandwidth-1;
        data = fetch_eeg_data(dataset_id,chan_num,startSeq,endSeq)'; %ORIGINAL DATA
  
        data_T = data.*(abs(data)/max(abs(data))).^5; %increasing the contrast between spikes and background noise 
        
        %decompose the 1-second subband into smaller windows, calculate 
        %the percentage each window takes account in the sum of amplitudes, 
        %using contrasted data
        for i=1:NumWin
            data2 = [];
            for j = window_size*(i-1) : window_size*i-1
                data2 = [data2;data_T(j+1)];
            end
            avg(i) = mean(abs(data2));
        end
        sum_avg = sum(avg);
        for i=1:NumWin
            percentile(i) = avg(i)/sum_avg*100;
        end
        
        windows_w_spike = find(percentile > threshold);
        for i=1:size(windows_w_spike,1)
            
            %return signals in the 3 consecutive windows in the surrounding
            spikes{spikeId,:} = [startSeq+window_size*(windows_w_spike(i)-2)...
                startSeq+window_size*(windows_w_spike(i)+1)];
            spikeId = spikeId + 1;
        end
    end
    
    %clear percentile spikeId i avg NumIter m x NumWin
end

    
