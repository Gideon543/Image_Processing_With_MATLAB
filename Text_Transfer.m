%In this project, we transfer text from an image of a popular movie scene
%onto a picture of a waterfall.

% Loading the images
movieScene = imread("IMG_001.png");
waterfall = imread("IMG_002.jpg");

%Greyscale & Contrast Adjustment 
movieSceneGrey = im2gray(movieScene);
movieSceneAdjust = imadjust(movieSceneGrey);

%Spatial Filtering
avg_filter = fspecial("average",4);
movieSceneSmooth = imfilter(movieSceneAdjust, avg_filter);

