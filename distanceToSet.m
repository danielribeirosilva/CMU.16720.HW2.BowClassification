function [histInter] = distanceToSet(wordHist, histograms)
    
    if(size(wordHist,1)==1)
        wordHist = wordHist';
    end

    disp(size(wordHist));
    disp(size(histograms));

    histInter = sum(bsxfun(@min,wordHist,histograms));

end
