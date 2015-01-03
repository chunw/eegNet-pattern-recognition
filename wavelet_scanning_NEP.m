function WT_NEP = wavelet_scanning_NEP(file)
if strcmp(file,'ep_record.txt')
load 'ep_record.txt'
x = ep_record;
end

if strcmp(file,'ybs_record.txt')
load 'ybs_record.txt'
x = ybs_record;
end

WT_CO_N = [];
dataset_id = 0;
chan_num = 0;
for i = 1:size(x,1)
    if  x(i,4) ~= dataset_id || x(i,5) ~= chan_num
        dataset_id = x(i,4);
        chan_num = x(i,5);
        training;
        
        WT_CO_N = [WT_CO_N ; WT_CO];
    end
    
end

%clear off the id's from WT_CO_N
WT_NEP = zeros(size(WT_CO_N,1),5);
for i=1:size(WT_NEP,1)
    for j=5:9
    WT_NEP(i,j-4) = WT_CO_N(i,j);
    end
end

end %EOF