% NOTE: The image 'IMG_2861_ON_BOWL_RUFFLES' was not provided in the
% exam content on mycourses. As a result, I have a chosen a random image
% from those provided and proceeded with the same task.

function Midterm_02_Divyank_Kulshrestha()
    im_input = "IMG_4070_RED_BRICKS.JPG";
    im = imread(im_input);
    im_double = im2double(im);
%     separating the green channel
    im_green = im_double(:,:,2);
    imshow(im_green);

%     computing the canny edge map
    edges = edge(im_green, 'canny');

% using 95 threshold to filter edges stronger than 95%
    edge_strengths = nonzeros(im_green(edges));
    threshold = prctile(edge_strengths, 95);
    % logical AND of canny edge map and thresholded strength map
    strong_edges = edges & (im_green > threshold);
    
    figure;
    imshow(strong_edges);
end