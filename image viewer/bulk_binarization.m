function varargout = bulk_binarization(varargin)
    % BULK_BINARIZATION MATLAB code for bulk_binarization.fig
    %      BULK_BINARIZATION, by itself, creates a new BULK_BINARIZATION or raises the existing
    %      singleton*.
    %
    %      H = BULK_BINARIZATION returns the handle to a new BULK_BINARIZATION or the handle to
    %      the existing singleton*.
    %
    %      BULK_BINARIZATION('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in BULK_BINARIZATION.M with the given input arguments.
    %
    %      BULK_BINARIZATION('Property','Value',...) creates a new BULK_BINARIZATION or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before bulk_binarization_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to bulk_binarization_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help bulk_binarization

    % Last Modified by GUIDE v2.5 10-Apr-2013 11:41:31

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @bulk_binarization_OpeningFcn, ...
                       'gui_OutputFcn',  @bulk_binarization_OutputFcn, ...
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
% --- Executes just before bulk_binarization is made visible.
function bulk_binarization_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bulk_binarization (see VARARGIN)

% Choose default command line output for bulk_binarization
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bulk_binarization wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = bulk_binarization_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on selection change in binarized_images_lstbox.
function binarized_images_lstbox_Callback(hObject, eventdata, handles)
% hObject    handle to binarized_images_lstbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns binarized_images_lstbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from binarized_images_lstbox

end

% --- Executes during object creation, after setting all properties.
function binarized_images_lstbox_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to binarized_images_lstbox (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: listbox controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

end

% --- Executes on selection change in GT_images_lstbox.
function GT_images_lstbox_Callback(hObject, eventdata, handles)
    % hObject    handle to GT_images_lstbox (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns GT_images_lstbox contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from GT_images_lstbox

end


% --- Executes during object creation, after setting all properties.
function GT_images_lstbox_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to GT_images_lstbox (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: listbox controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

end

function [paths] = getPaths()
    [filename, pathname]=uigetfile({ '*.tiff;','tiff';'*.jpg;*.png;*.gif;*.bmp;*.tiff;*.tiff', 'Image files';
                                '*', 'all files'}, 'Select an image ...', 'MultiSelect', 'on' )


    if ( strcmp(class(filename), 'char') )
        paths = cell(1);
        paths{1} = strcat(pathname, filename)

    else
        
           [y,x] = size(filename)
            paths = cell(x);

        for i=1:x
            paths{i} = strcat(pathname,filename{i})
        end

        end
            
end

% --- Executes on button press in load_bin_btn.
function load_bin_btn_Callback(hObject, eventdata, handles)
        % hObject    handle to load_bin_btn (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)

        fullpaths = getPaths();

        [pathsizey, ~ ] = size(fullpaths)
        for i=1:pathsizey 
            initial_name=cellstr(get(handles.binarized_images_lstbox,'String'));
            new_name = [initial_name;{fullpaths{i}}];
            set(handles.binarized_images_lstbox,'String',new_name) 

        end
    
end



% --- Executes on button press in Load_GT_btn.
function Load_GT_btn_Callback(hObject, eventdata, handles)
    % hObject    handle to Load_GT_btn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

        fullpaths = getPaths();

        [pathsizey, ~ ] = size(fullpaths)
        for i=1:pathsizey 
            initial_name=cellstr(get(handles.GT_images_lstbox,'String'));
            new_name = [initial_name;{fullpaths{i}}];
            set(handles.GT_images_lstbox,'String',new_name) 

        end
    
end


% --- Executes on button press in Evaluate_btn.
function Evaluate_btn_Callback(hObject, eventdata, handles)
    % hObject    handle to Evaluate_btn (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    bin_images = get(handles.binarized_images_lstbox, 'string');
    GT_images = get(handles.GT_images_lstbox, 'string');

    sizeGT = length(GT_images);
    sizeBin = length(bin_images);
    
    results = zeros(sizeGT-1,5);
    
    if (sizeGT ~= sizeBin) 
        warndlg({'Not the same amount of images!'});
        return;
    end
    
    %save as ...
    [filename, pathname]=uiputfile({  '*.xls', 'xls';}, 'Save the evaluation results...' );
    evalpath = strcat(pathname,filename);
    
    
    for i=2:sizeGT
       temp = evaluate (imread(bin_images{i}), imread(GT_images{i}))
       results(i-1,:) = [temp.Fmeasure, temp.PSNR, temp.NRM, temp.MPM, temp.DRD];
    end
    
    results

    header = {'Fmeasure' 'PSNR' 'NRM' 'MPM', 'DRD'}; %cell array of 1 by 4
    xlswrite(evalpath, header, 'Evaluation') % by defualt starts from A1
    xlswrite(evalpath, results, 'Evaluation','A2') % array under the header.     
%   csvwrite('ev.csv', [result.Precision, result.PSNR, result.NRM, result.MPM, result.DRD])
        
end
