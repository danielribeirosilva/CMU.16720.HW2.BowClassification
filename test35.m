imageDir = '../images/';

for i=length(testImagePaths)
    imagePath = [imageDir testImagePaths{i}];

    disp(imagePath);
    guessImage(imagePath);
end