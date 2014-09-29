function [wordMap]=getVisualWords(I,filterBank,dictionary)
  
%compute filter responses
imgResponses = extractFilterResponses(I,filterBank);

%compute distance between each point and each cluster center
distances = pdist2(imgResponses,dictionary);

%get index of lowest distance
[minDist,index] = min(distances,[],2);

%word map
wordMap = reshape(index,[size(I,1) size(I,2)]);

end

