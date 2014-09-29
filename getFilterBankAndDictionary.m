function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)

%parameters
K = 150;
alpha = 100;

%filter bank
filterBank = createFilterBank();

%size parameters
T = size(imPaths,1);
N = 3 * size(filterBank,1);

%complete set of filter responses
allFilterResponses = zeros(alpha*T, N);

for i = 1:length(imPaths)
    
    disp(i);
   
    %read image
    I = imread(imPaths{i});
    
    %compute filter responses
    imgResponses = extractFilterResponses(I,filterBank);
    
    %select alpha responses
    selectedRows = randperm(size(imgResponses,1),alpha);
    selectedResponses = imgResponses(selectedRows,:);
    
    %add to list of responses
    startIdx = (i-1)*alpha + 1;
    endIdx = startIdx + alpha - 1;
    allFilterResponses( startIdx:endIdx, : ) = selectedResponses;
    
end

%do k-means
[unused, dictionary] = kmeans(allFilterResponses, K, 'EmptyAction', 'drop');


end
