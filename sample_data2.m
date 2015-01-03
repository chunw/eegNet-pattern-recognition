wname = 'db4';
bandwidth = 256;
n = ceil(153600/bandwidth);

WT_CO2 = zeros(n,9); %include 3 ID's, 5 WT results 

for win = 1:n
    
    %Perform WT at level 4,5,6,7,8
    %Calculate the squared detail components(energy) for each segment of data
    
    data = fetch_eeg_data(dataset_id,chan_num,(win-1)*bandwidth+bandwidth/2+1,(win-1)*bandwidth+bandwidth*3/2);
    %{
    [c2,l2] = wavedec(data,2,wname);
    d2 = wrcoef('d',c2,l2,wname,2);
    d2_sqr = d2.^2;
    d2 = max(d2_sqr);
    %}
    
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
    
    WT_CO2(win,2) = dataset_id;
    WT_CO2(win,3) = chan_num;
    WT_CO2(win,4) = win;
    WT_CO2(win,5) = d4;
    WT_CO2(win,6) = d5;
    WT_CO2(win,7) = d6;
    WT_CO2(win,8) = d7;
    WT_CO2(win,9) = d8;
end % END OF SLIDING WINDOW

sample2 = zeros(size(WT_CO2,1),5);
for i=1:size(WT_CO2,1)
    for j=5:9
        sample2(i,j-4) = WT_CO2(i,j);
    end
end
clear c4 c5 c6 c7 c8 d4 d5 d6 d7 d8 d4_sqr d5_sqr d6_sqr d7_sqr d8_sqr ybs
clear l4 l5 l6 l7 l8 data win WT_CO2
save sample2