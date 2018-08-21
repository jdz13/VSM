clc
clear 

[file,path] = uigetfile('*.*');
filename = [path,file];

fid = fopen(filename,'r');
line=fgetl(fid);

pattern = 'Time_since_start';
%This is for skiping lines until we reach the column names
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

% because there is a random space at the end colomn 
data.columns(length(data.columns)) = [];

%Add the headers to the object
obj.headers = data.columns;

%move down three lines to reach the numerical data

line=fgetl(fid);line=fgetl(fid);line=fgetl(fid); % apparently needed four? EDIT - Nope. Three needed but changes further in code. 

%Now we have reached the numerical data.
data_line = sscanf(fgetl(fid),'%f');
data.values = zeros(1,length(data.columns));%Preload the array for getting the numerical data
i=1;
%This will scan line by line and put it into data.values
while isempty(data_line) ~= 1
    data.values(i,:)=data_line';
    
    data_line=sscanf(fgetl(fid),'%f');
    i=i+1;
end

line=fgetl(fid); % new line needed here. Otherwise doesn't pick up the data. 

% need to get the full loop information - if there is more

pattern = 'New Section:';
%This is for skiping lines until we reach the column names
while ~contains(line,pattern)==1
    line=fgetl(fid);
end

data_line = sscanf(fgetl(fid),'%f');
%This will scan line by line and put it into data.values
while isempty(data_line) ~= 1
    data.values(i,:)=data_line';
    
    data_line=sscanf(fgetl(fid),'%f');
    i=i+1;
end

%Add the data to the object
obj.data = data.values;

fclose(fid); %close the file in Matlab

vhd = '.VHD';
vrd = '.VRD';
prompt = 'What is the file extention? (Case sensitive and please include dot)';

if contains(file,vhd)==1
    newStr = erase(filename,vhd);
    
elseif contains(file,vrd)==1
    newStr = erase(filename,vrd);

else 
    ext = inputdlg(file,'input');
    newStr = erase(filename,ext{1});
    
end

fileout = [ newStr, '.txt']; % Add the .txt extention to make a txt file.

outputsize =  size(data.values,1);

tiled ='%s';
tiled2 = '%f';

%outputing data with header to outputpath
    for q = 1:length(data.columns)
        header(q) = data.columns(q);
    end
    
    for q = 1:length(data.columns)-1
        tiled = [tiled, ' \t %s'];
        tiled2 = [tiled2, ' \t %f'];
    end
    
    tiled = [tiled,' \n'];
    tiled2 = [tiled2, ' \n'];
    
    fid = fopen(fileout,'w');
    fprintf(fid,tiled,header{1,:});
    for j = 1:outputsize
        fprintf(fid,tiled2,data.values(j,:));
    end
    fclose('all');
    
    
    

