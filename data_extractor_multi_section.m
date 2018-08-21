

% Standard stuff. 

% Get the file that you want to look at.
[file,path] = uigetfile('*.*'); % *.* denotes all file types
filename = [path,file];

% Remove the extension.
match = [".VRD", ".VHD","."] ; % Add any more in as find necessary, use " marks. 
alter = erase(file, match);

% Move into the directory, but remember where you were, so can go back. 
oldFolder = cd (path);

folName = ['Output_', alter] ; % The output folder name.

% Make the folder.
if ~exist(folName, 'dir')
  mkdir(folName);
end

outpath = [path, folName]; % Make sure that the files are put into the new folder.

% Open the file that you want to look at.
fid = fopen(filename,'r');
line=fgetl(fid); % This command moves down a line, so scans through the code.

% Need something to find where to start. First stage is to look for column
% headings. 
pattern = 'Time_since_start';

%This is for skiping lines until we reach the column names.
while ~contains(line,pattern)==1
    line=fgetl(fid);
end

%This will put the column names into a cell
data.columns={};
remain=line;
i=1;
substr = {};

while isempty(remain)==0
    [str, remain] = strtok(remain);
    
    %if statment to ensure column names with spaces are put into one data.column entry
    if isempty(substr) 
        data.columns{i} = str();
        i=i+1;
    end
    
end

% Because there is a random space at the end column.
data.columns(length(data.columns)) = [];

% Move down three lines to reach the numerical data.

n_1 = 1;
 
while line~= -1  % The end of code gives line == -1. 

    % Need it to keep looking for more sections.
pattern = 'New Section:';

% This is for skiping lines until we reach the column names.
while ~contains(line,pattern)==1
    line=fgetl(fid);
    if line == -1
        break   % Breaks put in to stop in the right places. 
    end
end

    if line == -1
        break % Breaks put in to stop in the right places. 
    end

    
    % Now that we have the right line, let's extract the information and
    % remove the crap we don't want.
filtitle = line;
filtitle1 = erase(filtitle, 'New Section: ');
filtitle2 = erase(filtitle1, ': ');
data(n_1).section = filtitle2;


% Now we have reached the numerical data.
data_line = sscanf(fgetl(fid),'%f');
i=1;
% This will scan line by line and put it into data.values.
while isempty(data_line) ~= 1
    data(1,n_1).values(i,:)=data_line';
    
    data_line=sscanf(fgetl(fid),'%f');
    i=i+1;
end

% Make sure you know you're onto a new section.
n_1 = n_1 + 1; 

% This part gets tricky. So the problem is that it has already moved past
% the title line (New Section:) so we have to move it back a line. But
% there is no official command to do so. So we have to find the current
% position in the script and manually tell it to go backwards a little. The
% amount is defined by 'safety'.
cho = ftell(fid); % Finds the current position in the script. 
safety = 40; % A safe number of characters to make sure that you go to the line above (as matlab doesn't have to go back). 
fseek(fid,cho-safety,'bof'); % Moves the string back to the line before the new 'New Section' line.
line = fgetl(fid);

% There is probably a better way to do this, but hey, it works! 

continue

end

fclose(fid); %close the file in Matlab

%%

% Create the output file names, with path, in the data structure. 
for n_2 = 1:size(data,2)
data(1,n_2).fileout = [outpath, '\',data(1,n_2).section, '.txt'];
end


% Figure out how big our output going to be.
% Initialise the variable
outputsize = zeros(1,size(data,2));

% We need to know how big each part of the structure is, as it may change
% measurement to measurement 
for n_3 = 1:size(data,2)
outputsize(n_3) =  size(data(1,n_3).values,1);
end 

% The output printing used here requires us to tell it what format to print
% for each variable, hence we need this to be adjustable to our number of
% columns. 
tiled ='%s';
tiled2 = '%f';

% Outputing data with header to outputpath.
    for q = 1:length(data(1,1).columns)
        header(q) = data(1,1).columns(q);
    end
    
    for q = 1:length(data(1,1).columns)-1
        tiled = [tiled, ' \t %s'];
        tiled2 = [tiled2, ' \t %f'];
    end
    
    % Finish it with a new line, so that it is printed properly.
    tiled = [tiled,' \n'];
    tiled2 = [tiled2, ' \n'];
    
    cd (outpath)
    %%
    
    % Output the data.
   
    for n_4 = 1:size(data,2)
    fid = fopen(data(1,n_4).fileout,'w');
    fprintf(fid,tiled,header{1,:});
    for j = 1:outputsize(n_4)
        fprintf(fid,tiled2,data(1,n_4).values(j,:));
    end
    fclose('all');
    end
    
    
    cd (oldFolder) % Change back to the old directory. As not to confuse everyone.
    