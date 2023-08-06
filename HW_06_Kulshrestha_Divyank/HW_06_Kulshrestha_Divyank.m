function HW_06_Kulshrestha_Divyank()
    addpath( '../TEST_IMAGES' );
    addpath( '../../TEST_IMAGES' );

    im_rgb = im2double( imread( 'peppers.png' ) );
    im_gray = im2gray(im_rgb);

    filter_one = fspecial("gaussian", 5, 2);
    filter_two = [-1  0  1 ;
                  -3  0  3 ;
                  -1  0  1 ;] / 10;
    filter_three = [-2  -5  -2 ;
                     0   0   0 ;
                     2   5   2 ;] / 18;
    
% change this variable to different filters above to execute each
    current_filter = filter_three;

    expect_filter = imfilter(im_gray, current_filter, 'same', 'repl');
    

    % Display my results:
    figure('Position', [300 100 600 600]);
    imagesc(expect_filter);
    colormap(gray);         % Show in gray
    axis image;             % Make the axes have square pixels.
    title("'imfilter' result",'FontSize', 24);
    colorbar;
    
    disp('Showing for 5 seconds:');
    pause(5);

    my_filter = HW06_Kulshrestha_Divyank_Filter(im_gray, current_filter);
    imagesc( my_filter );
    axis image;
    title("My filter's result",'FontSize', 24);
    colorbar;
    
    pause(5);
    
    im_diff     = imabsdiff( expect_filter, my_filter );
    imagesc( im_diff );
    axis image;
    title("'imabsdiff' result",'FontSize', 24);
    colorbar;
    
    
end

% 
%  NOTEs:  
%  1.  outputs must be named.
%
%  2.  Outputs are not returned with 'return...'.
%
%  3.  Functions start with the word "function".
%
function im_out = HW06_Kulshrestha_Divyank_Filter( input_image, given_filter )
    im_size = size(input_image);
    im_out = zeros(im_size);      % Make the output the same SIZE by default.

    filter_size = size(given_filter);
    
    % This gets you started here... 
    for row = 1+floor(filter_size(1)/2) : im_size(1)-floor(filter_size(1)/2)
        for col = 1+floor(filter_size(2)/2) : im_size(2)-floor(filter_size(2)/2)
            %
            % You need some inner loops here...
            % looping through the given filter matrix's rows and columns
            current_output_val = 0;
            i = 1;
            for filter_row = row-floor(filter_size(1)/2) : row+floor(filter_size(1)/2)
                j = 1;
                for filter_col = col-floor(filter_size(1)/2) : col+floor(filter_size(1)/2)
                    current_output_val = current_output_val + ...
                        (input_image(filter_row, filter_col)*given_filter(i, j));
                    j = j + 1;
                end
                i = i + 1;
            end
            % Return your computations here:
            im_out(row, col) = current_output_val;
        end
    end
end