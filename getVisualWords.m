function [wordMap]=getVisualWords(I,filterBank,dictionary)
  
%compute filter responses
imgResponses = extractFilterResponses(I,filterBank);

%compute distance between each point and each cluster center
distances = pdist2(imgResponses,dictionary);

%get index of lowest distance
[minDist,index] = min(distances,[],2);

%word map
wordMap = vec2mat(index,size(I,2));
    
end

