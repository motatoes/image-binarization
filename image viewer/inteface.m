

function varargout = inteface(varargin)

% INTEFACE MATLAB code for inteface.fig
    %      INTEFACE, by itself, creates a new INTEFACE or raises the existing
    %      singleton*.
    %
    %      H = INTEFACE returns the handle to a new INTEFACE or the handle to
    %      the existing singleton*.
    %
    %      INTEFACE('CALLBACfK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in INTEFACE.M with the given input arguments.
    %
    %      INTEFACE('Property','Value',...) creates a new INTEFACE or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before inteface_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to inteface_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help inteface

    % Last Modified by GUIDE v2.5 10-Apr-2013 20:48:16

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @inteface_OpeningFcn, ...
                       'gui_OutputFcn',  @inteface_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
    % End initialization code - DO NOT EDIT
end

% --- Executes just before inteface is made visible.
function inteface_OpeningFcn(hObject, ~, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to inteface (see VARARGIN)

    % Choose default command line output for inteface
    handles.output = hObject;
    
    %set the handles original image
    handles.original_image = 0;
    
    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes inteface wait for user response (see UIRESUME)
    % uiwait(handles.figure1);

end
% --- Outputs from this function are returned to the command line.
function varargout = inteface_OutputFcn(~, ~, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;

end
% --------------------------------------------------------------------
function open_toolbar_ClickedCallback(hObject, ~, handles)
    % hObject    handle to open_toolbar (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    %allow the user to select a file
    [filename, pathname]=uigetfile({ '*.jpg;*.png;*.gif', 'Image files';
                                '*', 'all files'}, 'Select an image ...' );
    fullpath = strcat(pathname,filename);

    %load the image and show it in the axis
    handles.original_image = rgb2gray(imread(fullpath));
    %save_toolbar the value in the array
    guidata(hObject,handles)
    
    
    ih = imshow(handles.original_image, 'Parent', handles.plot_image);

    %Now add an event handler to the image on click
    set(ih,'buttonDownFcn', { @plot_image_ButtonDownFcn, handles, handles.original_image}  );
    %set(handles.binarization_btn,'CallBack', { @apply_btn_Callback, handles, handles.original_image });
end

%saving a processed image %%


% --------------------------------------------------------------------
function save_toolbar_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to save_toolbar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    %allow the user to select a file
    [filename, pathname]=uiputfile({  '*.png', 'PNG';'*.jpg', 'Jpeg'; 'gif', 'GIF';
                                    '*', 'all files'}, 'Save the processed image ...' );
    fullpath = strcat(pathname,filename);

    %load the image from the axis
    X = getimage(handles.plot_processed);

    imwrite(X, fullpath);


end


% --- Executes on mouse press over axes background.
function plot_image_ButtonDownFcn(hObject, ~, handles, original_img)

    %%this method applies the 'flood fill' algorithm on the image
    %%using a non-recursive approach, and a queue to keep track
    %%of the "neighbour pixels"
    
    %first we need to get some options from the radio buttons
    
    %change darker pixels to white, or lighter pixels to dark?
    darkerToWhite = get(handles.radiobtn_darktowhite,'value');
    lighterToblack = get(handles.radiobtn_lighttoblack,'value');
    
    %consider neighbouring 4 pixels or 8 pixels?
    pixelmode_8n = get(handles.radiobtn_8n,'value');
    
    seed = ginput(1);
    midY = ceil(seed(2));
    midX = ceil(seed(1));

    points = cell_propagate(original_img, seed , pixelmode_8n, darkerToWhite);
    
    original_img(points(:)) = 255;

   imshow(original_img, 'Parent', handles.plot_processed);
end

% --------------------------------------------------------------------
function groundtruth_toolbar_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to groundtruth_toolbar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    %allow the user to select a file
    [filename, pathname]=uigetfile({ '*.tiff', 'Image files';
                                '*', 'all files'}, 'Select an image ...' );
    fullpath = strcat(pathname,filename);
    
    %load the image and show it in the axis
    original_image = imread(fullpath);
    ih = imshow(original_image, 'Parent', handles.plot_groundTruth);

end
% --------------------------------------------------------------------
function pointThresholdTool_ClickedCallback(~, ~, handles)
% hObject    handle to pointThresholdTool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % hObject    handle to plot_image (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)


    [x, y] = ginput(1);
    y = ceil(y);
    x = ceil(x);
    

    min_threshold = handles.original_image(y, x);
    %max_threshold = 255;

    %calculate the range for filter and image 
    [sizeY, sizeX] = size(handles.original_image);
    rangeY = 1 : sizeY;
    rangeX = 1 : sizeX;
    
    %apply the filter
    filter( rangeY, rangeX) = ...
                     handles.original_image( rangeY, rangeX ) >= min_threshold ;
    handles.original_image( rangeY, rangeX ) = double(handles.original_image( rangeY, rangeX )) .* double(filter);

     %now show the image
    
     %%get the limits before doing an imshow
    limits(2,:) = get(handles.plot_processed,'YLim');
    limits(1,:) = get(handles.plot_processed,'XLim');
 
    %do an imshow
    imshow(handles.original_image, 'Parent', handles.plot_processed);
    
    %restore the limits
	set(handles.plot_processed, 'YLim', limits(2,:));
	set(handles.plot_processed, 'XLim', limits(1,:));
    
end



% --- Executes on button press in filter_apply_btn.
function filter_apply_btn_Callback(hObject, eventdata, handles)
% hObject    handle to filter_apply_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    selected_item = get(handles.filter_lstbox,'value');

    orig_img = handles.original_image;


    if (selected_item == 1) %niblack
        i = edge(orig_img,'canny',0.6);
        result = (i==0);
        %orig_img(i) = 255;
    elseif (selected_item == 2)
        i = edge(orig_img);
        result = (i==0);
        %orig_img(i) = 255;
    elseif (selected_item == 3)
        addpath fast
        i = fast9(orig_img,25);
        rmpath fast
        [y,x] = size(i)

        for j=1:y
            xl = i(j,1);
            yl = i(j,2);
            orig_img(yl:yl+3,xl:xl+3) =  255 ;
            result = orig_img;
        end
    elseif (selected_item == 5)
        figure;imhist(orig_img);
        return;
    end

    imshow( result, 'Parent', handles.plot_processed);
    handles.seed_points = i;
    %save_toolbar the value in the array
    guidata(hObject,handles)
end


% --- Executes on button press in use_as_seed_points_btn.
function use_as_seed_points_btn_Callback(hObject, eventdata, handles)
    % hObject    handle to use_as_seed_points_btn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
% 
%     pixelmode_8n = 1;
%     darkerToWhite = 1;
%   
%     img = handles.original_image;
%     [imy,imx] = size(img);
%     
%     img_bin = ones(imy,imx);
% 
%     points = handles.seed_points;
%      
%     mean_value  = mean(double(img));
% 
% 
%     [y,x] = size(points)
%     values = ones(y,1);
%     
%     
%     
%     %get the values from the points
%     for (j = 1:y)
%         xl = points(j,1);
%         yl = points(j,2);
%         values(j,1) = img(yl,xl);
%     end
%     
%      figure;hist(values)
%        % get the binarized values
%      returnThreshold = 1;
%      threshold = otsu(uint8(values), returnThreshold );
% 
%      addpath fast
%      low_thresh_seed_points = fast9(img,15);
%      rmpath fast
%      [y,x] = size(low_thresh_seed_points)
%      %floodfill the corners based on where they are 
% 
%      
%     for  j = 1:y 
%         xl = low_thresh_seed_points(j,1);
%         yl = low_thresh_seed_points(j,2);
%         xl
%         yl
%         %only flood foreground pixels that have not alraedy been flooded
%         if ( img(yl,xl) < threshold &&  img(yl,xl) ~= 255 )
%             tic;
%             fg_points = cell_propagate(img, [ xl, yl] , pixelmode_8n, darkerToWhite);
%             img_bin(fg_points(:)) = 0;
%             toc;
%         end
%      
%         
%     end
% 
%     
    
     img = handles.original_image;
     points = handles.seed_points; 
     img_bin = use_corners_as_seed_points( img, points, 15);
     imshow( img_bin, 'Parent', handles.plot_processed);

end


% --- Executes on button press in evaluate_btn.
function evaluate_btn_Callback(hObject, eventdata, handles)
% hObject    handle to evaluate_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    img_bin = getimage(handles.plot_processed);
    GT = getimage(handles.plot_groundTruth);
    
    result = evaluate (img_bin,GT)
    header = {'Precision' 'PSNR' 'NRM' 'MPM', 'DRD'}; %cell array of 1 by 4
    xlswrite('ev.xls', header, 'Evaluation') % by defualt starts from A1
    xlswrite('ev.xls', [result.Precision, result.PSNR, result.NRM, result.MPM, result.DRD], 'Evaluation','A2') % array under the header.     
%     csvwrite('ev.csv', [result.Precision, result.PSNR, result.NRM, result.MPM, result.DRD])
        
end


% --- Executes on button press in binarization_btn.
function binarization_btn_Callback(hObject, eventdata, handles)
% hObject    handle to binarization_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    selected_item = get(handles.thresholding_lstbox,'value');
    if (selected_item == 1) 
           processed = niblack(handles.original_image);
    elseif (selected_item == 2)
           processed = 0;
    elseif (selected_item == 3)
           processed = otsu(handles.original_image);
    end
    
    imshow(processed, 'Parent', handles.plot_processed);
    
end


% --- Executes on button press in bulk_bin.
function bulk_bin_Callback(hObject, eventdata, handles)
    % hObject    handle to bulk_bin (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
        %allow the user to select a file
    [filename, pathname]=uigetfile({ '*.jpg;*.png;*.gif;*.bmp', 'Image files';
                                '*', 'all files'}, 'Select an image ...', 'MultiSelect', 'on' )


    if ( strcmp(class(filename), 'char') )
        fullpaths = cell(1);
        fullpaths{1} = strcat(pathname(:), filename)
    else
        
           [y,x] = size(filename)
            fullpaths = cell(x);

        for i=1:x
            fullpaths{i} = strcat(pathname,filename{i})
        end
    end
    
    filename(1)
    filename(2)
    filename{1}
    filename{2}
    fullpaths{1}
    
    bulk_corner_thresh(fullpaths, 25, 15, 'D:\Dropbox\Dropbox\bham\mini project 2\matlab\experiments\corner binarization\otsu_mutistage\handwritten09\')
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over bulk_compare_btn.
function bulk_compare_btn_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to bulk_compare_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


% --- Executes on button press in bulk_compare_btn.
function bulk_compare_btn_Callback(hObject, eventdata, handles)
% hObject    handle to bulk_compare_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    bulk_binarization
end
