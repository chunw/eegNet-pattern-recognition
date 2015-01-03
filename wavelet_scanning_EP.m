function WT_EP = wavelet_scanning_EP(file)
if strcmp(file,'ep_record.txt')
load 'ep_record.txt'
x = ep_record;
end

if strcmp(file,'ybs_record.txt')
load 'ybs_record.txt'
x = ybs_record;
end

wname = 'db4';

WT_EP = zeros(40,5); %a table that includes 5 WT results 
for iter = 1:40
    
    %Perform WT at level 4,5,6,7,8
    %Calculate the squared detail components for each segment of data
    data = fetch_eeg_data(x(iter,4),x(iter,5),x(iter,2),x(iter,3));
    
    
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
    
        WT_EP(iter,1) = d4; 
        WT_EP(iter,2) = d5; 
        WT_EP(iter,3) = d6; 
        WT_EP(iter,4) = d7; 
        WT_EP(iter,5) = d8; 
    
end 