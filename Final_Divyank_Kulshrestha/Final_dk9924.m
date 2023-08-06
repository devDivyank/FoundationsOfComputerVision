% NOTE: Image Crn4859A.jpg was not provided on my courses. So I chose a
% random image off the given ones.

% Read the input image
im = imread('Crn4779A.jpg');

% Get the color of the center pixel
center_color = im(size(im,1)/2,size(im,2)/2,:);

% Remove all colors except the center color
tolerance = 70;
for i = 1:size(im,1)
    for j = 1:size(im,2)
        color_diff = abs(double(im(i,j,:))-double(center_color));
        if sum(color_diff) > tolerance
            im(i,j,:) = 0;
        end
    end
end

% Find circles in the yellow regions using imfindcircle
[centers, radii, metric] = imfindcircles(im, [10 150], 'Sensitivity', 0.9);

% create a figure and display the original image
figure;
imshow(im);
hold on;

% loop over the detected circles and draw the boundaries
for i = 1:length(radii)
    % get the center and radius of the circle
    center = centers(i,:);
    radius = radii(i);
    
    % draw the boundary of the circle
    viscircles(center, radius, 'EdgeColor', 'y');
end

% saving output
frame = getframe( im );
im_out = frame.cdata;
fn_out = sprintf('Results_%s.jpg', getenv('USER') );
imwrite( fn_out, im_out, 'JPEG', 'Quality', 98);
