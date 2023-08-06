function HW_04_Divyank_Kulshrestha()
% Part - A: resizing the image
    im_orig     = im2double(imread('IMG_3603.jpeg'));               
    im          = imresize( im_orig, [400 300]);

% Part - B: using Kmeans to cartoonize the image
    dst_wts =  1/5 ;
    dims        = size( im );

    % xs and ys unused; affecting the resulting negatively
    [xs, ys]     = meshgrid( 1:dims(2), 1:dims(1) ); 

    reds        = im(:,:,1);
    grns        = im(:,:,2);
    blus        = im(:,:,3);

    for wt = dst_wts
        for k = 10
            attributes  = [double(reds(:)), double(grns(:)), double(blus(:))];

            tic;
            [cluster_id, centroids]  = kmeans( attributes, k, 'Replicate', 3, "MaxIter", 250);
            toc;
            im_new = reshape( cluster_id, dims(1), dims(2) );
            figure;
            imagesc( im_new );
            colormap(centroids(:, 1:3));
            axis image;
            title( sprintf('k = %d,  distance wt = %8.5f ', k, wt), 'FontSize', 24 );
            colorbar;
            drawnow;
         end
    end

% Part - C: finding the significant edges
    im_gray = im2gray(im);
    im_edge = edge(im_gray, "canny");
    im_edge = 1 - im_edge;
    figure;
    imagesc(im_edge);
    colormap(centroids(:, 1:3));
    axis image;

% Part - D: combining part B and part C
    im_edge = imfuse(label2rgb(im_new, centroids(:, 1:3)), im_edge, "blend");
    im_edge = histeq(im_edge);
    figure;
    imagesc(im_edge);
    colormap(centroids(:, 1:3));
    axis image;

end



