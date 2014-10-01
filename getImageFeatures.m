function [h] = getImageFeatures(wordMap,dictionarySize)

%check if all elements of wordMap are the same
%(otherwise function below will bug)
if(size(unique(wordMap),1)==1)
   h = zeros(1,dictionarySize);
   h(wordMap(1,1)) = 1;
   return;
end

%count cluster occurences
[count,clusters]=hist(wordMap,unique(wordMap));
count = sum(count,2);

%set 0 for remaining clusters and adjust order
h = zeros(1,dictionarySize);
h(clusters) = count;

%L1 normalization
h = h / numel(wordMap);

end