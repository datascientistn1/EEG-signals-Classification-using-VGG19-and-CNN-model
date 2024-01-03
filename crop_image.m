% Read the image
img = imread('F5CH_S007R01.jpg');

% Convert the image to grayscale to find the sum of the pixel values in the rows and columns
gray_img = rgb2gray(img);

% Determine the cropping rectangle
top_row = 49;
bottom_row = 583;
left_col = 101;
right_col = 708;

% Crop the image
cropped_img = img(top_row:bottom_row, left_col:right_col, :);

% Save the new image
imwrite(cropped_img, 'cropped_image.png');

%% For all
% Specify the folder where the images are stored
folder = 'C:\Program Files\MATLAB\EEGClassify\FALLCH_compositeImages'; % Replace with your folder path

% Get a list of all files in the folder with the desired file extension
filePattern = fullfile(folder, '*.jpg'); % Change the extension if needed
jpegFiles = dir(filePattern);

% Determine the cropping rectangle
top_row = 49;
bottom_row = 583;
left_col = 101;
right_col = 708;

% Loop over each file in the folder
for k = 1:length(jpegFiles)
    baseFileName = jpegFiles(k).name;
    fullFileName = fullfile(folder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);

    % Read the image
    img = imread(fullFileName);

    % Crop the image using the predetermined rectangle
    cropped_img = img(top_row:bottom_row, left_col:right_col, :);

    % Save the new image
    [folder, baseFileNameNoExt, ~] = fileparts(fullFileName);
    croppedFileName = fullfile(folder, [baseFileNameNoExt, '_cropped.jpg']); % Change the output format if needed
    imwrite(cropped_img, croppedFileName);
end



