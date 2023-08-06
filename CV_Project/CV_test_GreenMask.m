function features=CV_test_GreenMask(input)
image = imread(input);
image = image(:,:,1:3);

   % Extract the color channels
redChannel = image(:, :, 1);
greenChannel = image(:, :, 2);
blueChannel = image(:, :, 3);

% Define color channel thresholds for green
redThreshold = 100;
greenThreshold = 80;
blueThreshold = 100;

% Create a binary green mask
greenMask = (redChannel < redThreshold) & ...
             (greenChannel > greenThreshold) & ...
             (blueChannel < blueThreshold);

% Define the structuring element for dilation
se = strel('disk', 3); % You can adjust the size of the disk as needed

% Dilate the green mask
dilatedGreenMask = imdilate(greenMask, se);

% Fill holes in the dilated green mask
filledGreenMask = imfill(dilatedGreenMask, 'holes');

% Apply the filled green mask to the original image
maskedImage = image;
maskedImage(repmat(~filledGreenMask, [1, 1, 3])) = 0;

% Create a binary white mask
redThresholdWhite = 160;
greenThresholdWhite = 160;
blueThresholdWhite = 160;

whiteMask = (redChannel > redThresholdWhite) & ...
            (greenChannel > greenThresholdWhite) & ...
            (blueChannel > blueThresholdWhite);

% Combine the white mask and the green mask to get white dots on the green patch
whiteObjectsOnGreenPatch = filledGreenMask & whiteMask;

% Remove small white objects (noise) by morphological opening
seOpening = strel('disk', 1);
whiteObjectsOnGreenPatchOpened = imopen(whiteObjectsOnGreenPatch, seOpening);

%Print interim
% figure;
% imshow(whiteObjectsOnGreenPatchOpened);

% Label connected components (white cotton buds)
[labeledWhiteObjects, numWhiteCottonBuds] = bwlabel(whiteObjectsOnGreenPatchOpened);

% Display the original image and the masked image
% figure;
% subplot(1, 2, 1);
% imshow(image);
% title('Original Image');
% 
% subplot(1, 2, 2);
% imshow(maskedImage);
% title('Image with Filled Green Mask');

% Calculate the area of the green patch
greenArea = sum(filledGreenMask, 'all');

% Calculate the mean green intensity in the green patch
greenIntensityInPatch = greenChannel(filledGreenMask);
meanGreenIntensity = mean(greenIntensityInPatch, 'all');

% % % Display the green area
% fprintf('The area of the green patch is %d pixels.\n', greenArea);
% % 
% % % Display the white
% fprintf('The number of white dots is %d.\n', numWhiteCottonBuds);
% 
% % % Display the green intensity
% fprintf('The mean intensity of the green color in the green patch is %.2f.\n', meanGreenIntensity);

features = zeros(1, 3);
features(1,1)=greenArea;
features(1,2)=numWhiteCottonBuds;
features(1,3)=meanGreenIntensity;

end