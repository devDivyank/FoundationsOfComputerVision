function HW07_dk9924_Cluster_Colors( filename )
    im_in = imread(filename);
%     for faster computations
    im_sub_sampled = im_in(3:3:end,3:3:end,:);  
%     double to perform computations
    im_double = im2double(im_sub_sampled);
%     seperating color channels
    im_red = im_double(:,:,1);
    im_grn = im_double(:,:,2);
    im_blu = im_double(:,:,3);

%     performing K-means and convert the results of k-means into an image
    num_colors = 10;
    data = [ im_red(:) , im_grn(:) , im_blu(:) ];
    [cluster_id, centers] = kmeans(data, num_colors, "Distance","sqeuclidean");
    image_by_id = reshape( cluster_id, size(im_double,1), size(im_double,2) );

%     displaying each cluster center
    for i = 1:size(centers(:, 1))
        color_id = image_by_id;
%         color_id not equal to the current_id is set to 0
        current = image_by_id ~= i;
        color_id(current) = 0;
%         image for the current center
        image = ind2rgb(color_id, centers);
%         inverting the image
        image = rgb2gray(1-image);
%         displaying the image
        figure;
        imshow(image);
    
    end
end