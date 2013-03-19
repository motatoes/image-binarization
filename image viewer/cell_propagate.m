
%method to propagate an image from a seed point
%@param : original image
%@param: boolean pixelmode_8n, true if we want 8 neighbours, false otherwise
%@param:darkerToWhite , boolean, if true, darker to whitem otherwise lighter
%to black


function img = cell_propagate(original_img, seed , pixelmode_8n, darkerToWhite)
    
    midX = ceil(seed(1));
    midY = ceil(seed(2));


    [sizey, sizex] = size(original_img);
    
    import java.util.LinkedList;%for using queues
 
    threshold = original_img(midY,midX);
    
    q = LinkedList();
    q.add([ midY, midX ]);
    added = zeros(sizey,sizex);

    if (darkerToWhite == 1)
        new_px_value = 255;
    else
        new_px_value = 0; 
    end  
    while (~q.isEmpty() )

        
        %remove the next elem from the queue
        q.size
        item = q.remove();
        y = item(1);
        x = item(2);
        

        if (darkerToWhite == 1)
            condition = original_img(y,x) <= threshold;
        else
            condition = original_img(y,x) >= threshold;
        end
        
        %do thresholding on that element
        if (condition == 1)
            original_img(y,x) = new_px_value;
            %mark it as done
            added(y,x) = 1; 
            
            %add the neighbour pixels
            %to the element if it has not
            %already been considered
            if (x ~= 1 && added(y,x-1) ~= 1)
                q.add([y,x-1]);
                added(y,x-1) = 0;
            end
        
            if (added(y,x+1) ~= 1)
                q.add([y, x+1]);
                added(y,x+1) = 0;
            end
        
            if (y ~= 1 && added(y-1,x) ~= 1)
                q.add([y-1,x]);
                added(y-1,x) = 0;
            end
        
            if (added(y+1,x) ~= 1)
                q.add([y+1,x]);
                added(y+1,x) = 0;
            end
            
            if (pixelmode_8n == 1)
                %we need to add diagonal pixels as well
                if (x ~= 1 && y~=1 && added(y-1,x-1) ~= 1)
                    q.add([y-1,x-1]);
                    added(y-1,x-1) = 0;
                end

                if (y~=1 && added(y-1,x+1) ~= 1)
                    q.add([y-1,x+1]);
                    added(y-1,x+1) = 0;
                end

                if (x ~= 1 && added(y+1,x-1) ~= 1)
                    q.add([y+1,x-1]);
                    added(y+1,x-1) = 0;
                end

                if (added(y+1,x+1) ~= 1)
                    q.add([y+1,x+1]);
                    added(y+1,x+1) = 0;
                end
            end
        end              
    end
    
    img = original_img;
end