function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)

%parameters (trying to keep same notation)
K = dictionarySize; 
h=[];
L = layerNum - 1;
l = L;


%----------------------------------------------------------------
%COMPUTE HISTOGRAM FOR FINEST LAYER
%----------------------------------------------------------------

cellHeight = size(wordMap,1) / 2^l;
cellWidth = size(wordMap,2) / 2^l;
layerHistogram = zeros(1,K*(4^l));
oldHistograms = cell(2^l,2^l);

for i=1:int16(2^l)
    for j=1:int16(2^l)
        %get corresponding cell word map
        currentWordMap = wordMap((i-1)*cellHeight+1:i*cellHeight,(j-1)*cellWidth+1:j*cellWidth);
        
        %compute corresponding histogram
        currentHistogram = getImageFeatures(currentWordMap,K);
        
        %store histogram (will be used to compute histogram for other layers)
        oldHistograms{i,j} = currentHistogram; 
        
        %concatenate histogram
        startIdx = ((i-1)*2^l + j-1)*K + 1;
        endIdx = ((i-1)*2^l + j-1)*K + K;
        layerHistogram(startIdx:endIdx) = currentHistogram;
    end
end

%normalize
layerHistogram = layerHistogram / 4^l;
%mulitply by weight
layerHistogram = getLayerWeight(l, L)*layerHistogram;
%add to final histogram
h = [layerHistogram h];

%move to lower layer
l = l - 1;


%----------------------------------------------------------------
%COMPUTE HISTOGRAM FOR REMAINING LAYERS
%----------------------------------------------------------------

while l >= 0
    
    layerHistogram = zeros(1,dictionarySize*(4^l));
    newHistograms = cell(2^l,2^l);
    for i=1:int16(2^l)
        for j=1:int16(2^l)
            %combine histograms from finer cells
            newHistograms{i,j} = oldHistograms{2*i-1,2*j-1} + ...
                                 oldHistograms{2*i,2*j-1}   + ...
                                 oldHistograms{2*i-1,2*j}   + ...
                                 oldHistograms{2*i,2*j};
                             
            %normalize combined histograms
            newHistograms{i,j} = newHistograms{i,j} / 4;
            
            %concatenate histogram
            startIdx = ((i-1)*2^l + j-1)*K + 1;
            endIdx = ((i-1)*2^l + j-1)*K + K;
            layerHistogram(startIdx:endIdx) = newHistograms{i,j};
            
        end
    end
    
    %normalize
    layerHistogram = layerHistogram / 4^l;
    %mulitply by weight
    layerHistogram = getLayerWeight(l, L)*layerHistogram;
    %add to final histogram
    h = [layerHistogram h];
    %update histograms
    oldHistograms = newHistograms;
    
    %move to lower layer
    l = l - 1;
end


end
