function [predictedLabel] = knnClassify(wordHist,trainHistograms,trainingLabels,k)

%get distance to each point
histInter = distanceToSet(wordHist, trainHistograms);

%sort and keep indexes
[inter, indexes] = sort(histInter,'descend');

%top k labels
topLabels = trainingLabels(indexes(1:k));

%return most common label
predictedLabel = mode(topLabels);

%Alternative approach: get all modes and pick a random one
%this is better if you have more than 1 "highest occuring label"
%{
U = unique(topLabels);
H=histc(topLabels,U);
modes = U(H==max(H));
predictedLabel = datasample(modes,1);
%}

end
