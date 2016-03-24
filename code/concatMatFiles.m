function [allMatFiles,datapointLengths] = concatMatFiles(loc,files)

% Concatenate matfiles in the given location
allMatFiles = [];
numFiles = size(files,1);

% Start concatenation
for i = 1:numFiles
    
    % Get current filename
    curFile = strcat(loc,files(i).name);
    
    % Load the file
    vals = load(curFile);
    
    % Remove the unwanted timestamp column
    vals = vals(:,2:end);
    
    % Keep a track of size of each dataset in order to decatenate after
    % clustering
    datapointLengths(i) = size(vals,1);
    
    allMatFiles = [allMatFiles;vals];
end

