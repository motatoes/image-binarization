
%method to propagate an image from a seed point
%@param : original image
%@param: boolean pixelmode_8n, true if we want 8 neighbours, false otherwise
%@param:darkerToWhite , boolean, if true, darker to whitem otherwise lighter
%to black


function img = cell_propagate(original_img, seed , pixelmode_8n, darkerToWhite)
    
    midX = ceil(seed(1));
    midY = ceil(seed(2));

    
    [sizey, sizex] = size(original_img);
    
    
    %import java.util.LinkedList;%for using queues
 
    threshold = original_img(midY,midX);
    
    %q = LinkedList();
    %q.add([ midY, midX ]);
    added = logical ( zeros(sizey,sizex) );

    
    %T,1 is the Y value -- T,2 is the X value
    
    %Dynamic ques make the program SLOW!! , we are better of pre-allocating
    %A large array that behaves as a queque = zeros(sizex * sizey,2);
    currentIndex = 1;
    que(currentIndex,1) = midY;
    que(currentIndex,2) = midX; 

    
    if (darkerToWhite == 1)
        new_px_value = 255;
    else
        new_px_value = 0; 
    end  
    while (currentIndex ~= 0)%~q.isEmpty() )

        
        %remove the next elem from the queue
        %item = q.remove();
        %y = item(1);
        %x = item(2);
        y = que(currentIndex ,1);
        x = que(currentIndex ,2);
        currentIndex = currentIndex - 1;
        
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
                %q.add([y,x-1]);
                currentIndex = currentIndex + 1;
                que(currentIndex, 1) = y;
                que(currentIndex, 2) = x-1;
                added(y,x-1) = 0;
            end
        
            if ( x < sizex &&  added(y,x+1) ~= 1)
                %q.add([y, x+1]);
                currentIndex = currentIndex + 1;
                que(currentIndex, 1) = y;
                que(currentIndex, 2) = x+1;                
                added(y,x+1) = 0;
            end
        
            if (y ~= 1 && added(y-1,x) ~= 1)
                %q.add([y-1,x]);
                currentIndex = currentIndex + 1;
                que(currentIndex, 1) = y-1;
                que(currentIndex, 2) = x;                
                added(y-1,x) = 0;
            end
        
            if (y < sizey && added(y+1,x) ~= 1)
                %q.add([y+1,x]);
                currentIndex = currentIndex + 1;
                que(currentIndex, 1) = y+1;
                que(currentIndex, 2) = x;                                
                added(y+1,x) = 0;
            end
            
            if (pixelmode_8n == 1)
                %we need to add diagonal pixels as well
                if (x ~= 1 && y~=1 && added(y-1,x-1) ~= 1)
                    %q.add([y-1,x-1]);
                    currentIndex = currentIndex + 1;
                    que(currentIndex, 1) = y-1;
                    que(currentIndex, 2) = x-1;                
                    added(y-1,x-1) = 0;
                end

                if ( x < sizex && y~=1 && added(y-1,x+1) ~= 1)
                    %q.add([y-1,x+1]);
                    currentIndex = currentIndex + 1;
                    que(currentIndex, 1) = y-1;
                    que(currentIndex, 2) = x+1;                
                    added(y-1,x+1) = 0;
                end

                if (y < sizey && x ~= 1 && added(y+1,x-1) ~= 1)
                    %q.add([y+1,x-1]);
                    currentIndex = currentIndex + 1;
                    que(currentIndex, 1) = y+1;
                    que(currentIndex, 2) = x-1;                
                    added(y+1,x-1) = 0;
                end

                if (y < sizey &&  x < sizex && added(y+1,x+1) ~= 1)
                    %q.add([y+1,x+1]);
                    currentIndex = currentIndex + 1;
                    que(currentIndex, 1) = y+1;
                    que(currentIndex, 2) = x+1;                
                    added(y+1,x+1) = 0;
                end
            end
        end              
    end


    img = added;%original_img;
end