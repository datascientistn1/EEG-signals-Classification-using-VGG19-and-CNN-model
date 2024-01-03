% Define the source directory where the EDF files are located
sourceDir = 'C:\Program Files\MATLAB\EEGClassify\selectedEEGfiles\';

% Define the destination directory where the composite images will be saved
destinationDir = 'C:\Program Files\MATLAB\EEGClassify\compositeImages\';

% Create the destination directory if it doesn't exist
if ~exist(destinationDir, 'dir')
    mkdir(destinationDir);
end

% Get a list of all EDF files in the source directory
edfFiles = dir(fullfile(sourceDir, '*.edf'));

% Loop through each EDF file
for i = 1:length(edfFiles)
    % Load the EEG data using EEGLAB's pop_biosig function
    EEG = pop_biosig(fullfile(sourceDir, edfFiles(i).name));

    % Initialize a matrix to store the CWT results of all channels
    compositeCWT = [];

    % Loop through each channel
    for chan = 1:EEG.nbchan
        % Perform Continuous Wavelet Transform (CWT) on the signal
        [cwtmatr, ~] = cwt(EEG.data(chan, :), EEG.srate);
        
        % Take the absolute value and append it to the composite matrix
        compositeCWT = [compositeCWT; abs(cwtmatr)];
    end

    % Create a figure for the composite image
    fig = figure;
    imagesc(compositeCWT);
    colormap('jet'); % Colormap can be adjusted as needed
    axis tight;
    colorbar;

    % Define the output file name
    [~, name, ~] = fileparts(edfFiles(i).name);
    outputFileName = fullfile(destinationDir, [name '.jpg']);

    % Save the figure
    saveas(fig, outputFileName);
    close(fig);
end

% Display message
disp(['Composite images saved to ' destinationDir]);
