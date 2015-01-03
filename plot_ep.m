function plot_ep(id1,id2) 
load 'ep_record.txt'
m = ep_record;

for iter = id1:id2 %the row number of spike to be plotted
    %add some background
    background = (501-75)/2;
    data1 = fetch_eeg_data(m(iter,4), m(iter,5), m(iter,2)-background, m(iter,2))';
    data2 = fetch_eeg_data(m(iter,4), m(iter,5), m(iter,2), m(iter,3))';
    data3 = fetch_eeg_data(m(iter,4), m(iter,5), m(iter,3),m(iter,3)+background)';
    t1=linspace(0,(length(data1)),length(data1));
    t2=linspace((length(data1)),(length(data1)+length(data2)),length(data2));
    t3=linspace((length(data1)+length(data2)),(length(data1)+length(data2)+length(data3)),length(data3));
    figure(iter);
    subplot(321)
    plot(t1,data1,'b-',t2,data2,'r-',t3,data3,'b-');title('EP spike')
    
    %change background
    background = (3501-75)/2;
    data1 = fetch_eeg_data(m(iter,4), m(iter,5), m(iter,2)-background, m(iter,2))';
    data2 = fetch_eeg_data(m(iter,4), m(iter,5), m(iter,2), m(iter,3))';
    data3 = fetch_eeg_data(m(iter,4), m(iter,5), m(iter,3),m(iter,3)+background)';
    t1=linspace(0,(length(data1)),length(data1));
    t2=linspace((length(data1)),(length(data1)+length(data2)),length(data2));
    t3=linspace((length(data1)+length(data2)),(length(data1)+length(data2)+length(data3)),length(data3));
    subplot(323)
    plot(t1,data1,'b-',t2,data2,'r-',t3,data3,'b-');
    
end
end