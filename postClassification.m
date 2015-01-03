SPIKES = cell(1,3); %SPIKE DETECTIONS RECORD
for r = 1:size(CLASS,1)
    EPWindows = find(CLASS{r,3}=='E');
    spikes_EP = spike_detection(EPWindows,CLASS{r,1},CLASS{r,2}); %PERCENTILE FILTERING 
    SPIKES{r,1} = CLASS{r,1};
    SPIKES{r,2} = CLASS{r,2};
    SPIKES{r,3} = spikes_EP;
end

clear spikes_EP r EPWindows CLASS i j

