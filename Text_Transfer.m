%In this project, we transfer text from an image of a popular movie scene
%onto a picture of a waterfall.

% Loading the images
movieScene = imread("Life-Quotes-Dolly.jpg");
waterfall = imread("IMG_002.jpg");

%Greyscale & Contrast Adjustment 
movieSceneGray = im2gray(movieScene);
movieSceneAdjust = imadjust(movieSceneGray);

%Spatial Filtering
avg_filter = fspecial("average",4);
movieSceneSmooth = imfilter(movieSceneAdjust, avg_filter, "replicate");

%Creating structural elements for background subtraction
SE1 = strel("rectangle", [30 50]);
SE2 = ones(9, 11);
SE3 = ones(3);
SE4 = ones(7, 3);

%displaying the smoothened image
imshow(movieSceneSmooth)

%displaying intensity histogram of smoothened image
imhist(movieSceneSmooth)

%binarizing the image and performing optical character recognition (ocr) 
%on the image
test1 = imbinarize(movieSceneSmooth, "adaptive");  %this
imshow(test1)
test1ocr = ocr(test1);

%Attempting to make the ocr better by performing a series of 
%erosions and dilations on the image
test12 = imclose(test1, SE3);  %this
imshow(test12)
ocr(test12)

%resizing the image (scaling it)
test1resized = imresize(movieSceneSmooth, 20);

%binarizing the resized image
test1resizedbinary = imbinarize(test1resized);

%performing an ocr on the resized binarized image
test1resizedocr = ocr(test1resizedbinary);

%opening the image using structural element 3
test1resizedopened = imopen(test1resizedbinary, SE3);

%performing an ocr on the opened image
test1resizedopenedocr = ocr(test1resizedopened);

%imshowpair(test1, test1resizedbinary, "montage")

%compare test1ocr and test1resizedocr and talk about tradeoffs
%talk about how ocr works better with texts of size 20 pizels or more.

%filtering test1
f = imopen(test1, SE3);
g = imclose(f, SE3);

gOcr = ocr(g);
 

%extracting ocr text into waterfall image
extractedText = gOcr.Text;

%cropping waterfall
waterfallCropped = imresize(waterfall, [500 700]);
waterfallText = insertText(waterfallCropped, [400 400], extractedText, 'FontSize', 20, 'AnchorPoint', 'RightBottom', 'BoxColor', 'w');
imshow(waterfallText)   