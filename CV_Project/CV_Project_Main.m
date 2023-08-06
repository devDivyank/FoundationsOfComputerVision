function CV_Project_Main()
imageDir='cotton images and labels/cotton images/';
labelDir='cotton images and labels/labels/labels_rgb.csv';

imgClassesCSV = readtable(labelDir);
%imgIds = imgClassesCSV.image_ID;
labels = categorical(imgClassesCSV.class);

% How many images to process
iter=2240;
%2240;

% Gets name of image to be processed
imagePrefix="20220818_lb_p4r_twri_mosaic%d.tif";


X = [];
Y = [];


    for i = 1 : iter   
        % Load current image
        file_number = 559 + i;
        file_name = sprintf(imagePrefix, file_number);

        % Preprocess images
        %processed=CV_Project_Preprocess(imageDir+file_name);
        
        % Extract features from current image (e.g. color histograms, texture descriptors, etc.)
        %current_features = CV_Project_FeatureExtracter(processed);
        %current_features=CV_Project_EDGEFeatureExtracter(processed);

        %features from green mask
        current_features=CV_test_GreenMask(imageDir+file_name);

        % Append current features to feature matrix X
        X = [X; current_features];
        
        % Append current label to label vector Y
        Y = [Y; labels(i)];

        %Prints progress
        fprintf('Image Processed %d\n', file_number);

    end

% decision tree 

% Split data into training and testing sets
cv = cvpartition(size(Y,1),'HoldOut',0.20);
Xtrain = X(training(cv),:);
Ytrain = Y(training(cv));
Xtest = X(test(cv),:);
Ytest = Y(test(cv));

% Train decision tree classifier
tree = fitctree(Xtrain,Ytrain);

% Predict on test set and calculate accuracy
Ypred = predict(tree,Xtest);
accuracy = sum(Ypred == Ytest)/numel(Ytest);

%Print accuracy
fprintf('The accuracy found is %.2f\n%', (accuracy*100));

end