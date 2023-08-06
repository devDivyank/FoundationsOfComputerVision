function HW07_dk9924_FIND_ORAGES( filename )
    im_in = imread(filename);
%     for faster computations
    im_sub_sampled = im_in(1:10:end, 1:10:end, : ); 
%     double to perform computations
    im_double = im2double(im_sub_sampled);
    im_double = imrotate(im_double, 270);
%     getting clicks on oranges from the user
    figure;
    imshow(im_double);
    orange_clicks = ginput();
    orange_pixels = zeros(size(orange_clicks, 1), 3);
    
%     setting value of orange pixels from 
%     corresponding orange clicks (coordinates)
    for i = 1:size(orange_clicks, 1)
        orange_pixels(i, 1) = im_double(round(orange_clicks(i,2)), ...
                round(orange_clicks(i,1)),1);
        orange_pixels(i, 2) = im_double(round(orange_clicks(i,2)), ...
                round(orange_clicks(i,1)),2);
        orange_pixels(i, 3) = im_double(round(orange_clicks(i,2)), ...
                round(orange_clicks(i,1)),3);
    end

%     calculating the mahalanobis distance between 
%     image pixels and orange pixels
    mahalanobis_dist = mahal(reshape(im_double, [], 3), orange_pixels);
    im_out = zeros(size(im_double(:, :, 1)));
    for i = 1:size(im_double, 1)
        for j = 1:size(im_double, 2)
            ind = size(im_double(:,:,1), 1) * (j-1) + i;
            current = mahalanobis_dist(ind);
%             if distance is less than threshold 10, its an orange pixel
            if current < 10
                im_out(i, j) = 1;
            end
        end
    end
    imshow(im_out);
end