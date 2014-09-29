function [h] = getImageFeatures(wordMap,dictionarySize)

%count cluster occurences
[count,clusters]=hist(wordMap,unique(wordMap));
count = sum(count,2);

%set 0 for remaining clusters and adjust order
h = zeros(1,dictionarySize);
h(clusters) = count;

%L1 normalization
h = h / numel(wordMap);

end