%merge two classification results
for i=1:size(class2,1)
    if class2(i) == 'E'
        class(i) = 'E';
    end 
end