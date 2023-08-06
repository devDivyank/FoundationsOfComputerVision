function show_all_files_in_dir()
    addpath("./TEST_IMAGES");
    % Find all files that match this regular expression:
    cd TEST_IMAGES/
    file_list = dir('*.jpg');
    for counter = 1 : length(file_list)
        fn = file_list(counter).name;
        processImage(fn)
    end
end


function processImage(file_name)
    im_input = imread(file_name);
% 1. rotating image from portrait to landscape
    im_size = size(im_input);
    aspect_ratio = im_size(1)/im_size(2);
    if aspect_ratio > 1
        im_rotated = imrotate(im_input, 90);
    else
        im_rotated = im_input;
    end

% 2. separating the dice and the black background
    blue = im_rotated(:,:,3);
    im_gray = im2gray(blue);
    thresh = graythresh(im_gray);
    im_binary = imbinarize(im_gray, thresh);
    
% 3. counting the number of dice
    im_bw = bwareaopen(im_binary, 150);
    se = strel('disk',10);
    im_closed = imclose(im_bw, se);
    [labeled_img, num_labels] = bwlabel(im_closed);

% 4. creating a cyan box outside each die
    figure;
    imshow(im_closed);
    hold on;
    stats = regionprops(labeled_img, 'BoundingBox');
    % looping through all the dice in the image
    for i = 1 : length(stats)
        dice = stats(i).BoundingBox;
        % extracting the x-y coordinates of top left corner, height and 
        % width of dice
        x = dice(1);
        y = dice(2);
        h = dice(3);
        w = dice(4);
        % drawing a rectangle around each dice
        rectangle('Position', [x,y,h,w],'EdgeColor','c','LineWidth',5);
    end

% counting the number on each dice
    % dictionary to save the count of values that appear in each dice
    vals = [1,2,3,4,5,6];
    counts = [0,0,0,0,0,0];
    dotCounts = dictionary(vals,counts);
    % looping through all the dice in the image
    for i = 1 : length(stats)
        dice = stats(i).BoundingBox;
        % extracting the x-y coordinates of top left corner, height and 
        % width of dice
        x = dice(1);
        y = dice(2);
        h = dice(3);
        w = dice(4);
        % cropping each dice as a separate image
        im_box = imcrop(im_closed, [x,y,h,w]);
        % finding circles in each dice image
        [centersDark, radiiDark] = imfindcircles(im_box,[15 35],ObjectPolarity="dark");
        % updating the dictionary based on the value on dice
        dotCounts(length(radiiDark)) = dotCounts(length(radiiDark)) + 1;
    end

% formatting the output as required
fprintf("INPUT FILENAME: %s\n", file_name);
fprintf("Number of Dice: %g\n", length(stats));
fprintf("Number of 1's: %g\n", dotCounts("1"));
fprintf("Number of 2's: %g\n", dotCounts("2"));
fprintf("Number of 3's: %g\n", dotCounts("3"));
fprintf("Number of 4's: %g\n", dotCounts("4"));
fprintf("Number of 5's: %g\n", dotCounts("5"));
fprintf("Number of 6's: %g\n", dotCounts("6"));

end
