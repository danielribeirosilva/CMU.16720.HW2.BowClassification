%Loading the dictionary, filters and training data
numCores=4;
imageDir = '../images'; %where all images are located
targetDir = '../wordmap';%where we will store visual word outputs 
load('traintest.mat');
load('trainOutput.mat');


%parameters
k=5;
layerNum = 3;
dictionarySize = size(dictionary,1);
labelsSize = size(classnames,1);

%initialize confusion matrix
conf = zeros(labelsSize,labelsSize);

%loop over test images
for i=1:length(testImagePaths)
    %get image file
    testImgFile = fullfile(imageDir,testImagePaths{i});
    %load image
    testImg = imread(testImgFile);
    %get word map
    testWordMap = getVisualWords(testImg,filterBank,dictionary);
    %get histogram w/ spatial pyramid
    testHistogram = getImageFeaturesSPM(layerNum, testWordMap, dictionarySize);
    %classify
    predLabel = knnClassify(testHistogram,trainHistograms,trainImageLabels,k);
    %update confusion matrix
    conf(testImageLabels(i),predLabel) = conf(testImageLabels(i),predLabel) + 1;
    
    %print prediction + true label
    fprintf('%s -> true: %d pred: %d\n',testImagePaths{i},testImageLabels(i),predLabel);
end

%compute accuracy
acc = trace(conf) / sum(conf(:));

disp(conf);
disp(acc);