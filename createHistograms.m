function outputHistograms = createHistograms(dictionarySize,imagePaths,wordMapDir)
%code to compute histograms of all images from the visual words
%imagePaths: a cell array containing paths of the images
%wordMapDir: directory name which contains all the wordmaps


%Parameter
totalLayers = 3;

%create a NumImage x histogram matrix of histograms.
%this variable will store all the histograms of training images
histSize = dictionarySize * ( 4^totalLayers - 1) / 3;
outputHistograms = zeros(histSize,length(imagePaths));

for i = 1:length(imagePaths)
   %get image path
   imagePath = imagePaths{i};
   %get corresponding .mat file path
   matPath = strrep(imagePath,'.jpg','.mat');
   %get .mat file
   matFile = fullfile(wordMapDir,matPath);
   %load mat file
   obj = load(matFile);
   %get histogram
   histogram = getImageFeaturesSPM(totalLayers, obj.wordMap, dictionarySize);
   %concatenate
   outputHistograms(:,i) = histogram;
end
                      
                      


end
