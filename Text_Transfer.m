%In this project, we transfer text from an image of a popular movie scene
%onto a picture of a waterfall.

% Loading the images
movieScene = imread("IMG_001.png");
waterfall = imread("IMG_002.jpg");

%Greyscale & Contrast Adjustment 
movieSceneGray = im2gray(movieScene);
movieSceneAdjust = imadjust(movieSceneGray);

%Spatial Filtering
avg_filter = fspecial("average",4);
movieSceneSmooth = imfilter(movieSceneAdjust, avg_filter, "replicate");

%Binarizing the Image
movieSceneBW = imbinarize(movieSceneSmooth, "adaptive", "ForegroundPolarity", "dark");

%Calculating and plotting row sum of image to check for text patterns
S = sum(movieSceneBW, 2);
plot(S)

