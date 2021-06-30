% load data
data = readmatrix('https://raw.githubusercontent.com/plotly/datasets/master/api_docs/mt_bruno_elevation.csv');

% extract x-axis and y-axis values from matrix
x_col = data(1, :);
y_col = data(:, 1);

% remove null values 
y_col(1) = [];
x_col(1) = [];

% extract z-values
z_values = data;
z_values(1, :) = [];
z_values(:, 1) = [];

% controls
uicontrol('Style','pushbutton',...
  'String','Zoom In',...
  'Position',[20 20 60 20],...
  'Callback','if camva <= 1; return; else; camva(camva-1); end');

uicontrol('Style','pushbutton',...
  'String','Zoom Out',...
  'Position',[100 20 60 20],...
  'Callback',...
  'if camva >= 179; return; else; camva(camva+1); end');

% initial camera angle 
angle = 70;

output_folder = "path_to_directory";
output_file = VideoWriter('mtbruno_surfaceplot.mp4');
output_file.FrameRate = 2;

open(output_file)

axis tight manual

for i = 1:70
    % 3D surface plot
    plot = surf(x_col, y_col, z_values);
    colorbar;
    colormap winter;
    title("Elevation of Mt. Bruno")
    
    % set camera angle
    view(angle, 30); 
    F = getframe(gcf);
    im = frame2im(F);
    imshow(im);
    % imshow(F.cdata);
    
    % save file
    file_name = sprintf('%d.png', i);
    full_destination_filename = fullfile(output_folder, file_name);
    imwrite(F.cdata, full_destination_filename);
    
    % add to video
    writeVideo(output_file, F);
    
    angle = angle + 2;
end

close(output_file);
    


