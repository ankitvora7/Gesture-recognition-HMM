function [observations] = decatMatFiles(idx, obsLength)

% Decatenate files to obtain individual observation sequences
obsLength = obsLength';
numFiles = size(obsLength,1);

% Keep a track of datapoints done
prevMatFileSize = 0;

% Start decatenating
for i = 1:numFiles
    
    % Generate the new matfile
    curMatFile = idx(prevMatFileSize+1:prevMatFileSize + obsLength(i));
    
    % Update prevMatFileSize variable
    prevMatFileSize = prevMatFileSize + obsLength(i);    

    % Store in the struct
    observations(i).samples = curMatFile;
end
observations = observations';

end

