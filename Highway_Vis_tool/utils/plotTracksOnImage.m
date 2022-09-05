function [removingList] = plotTracksOnImage(ax, tracks, currentFrame, params, removingList)
%% Plot bounding boxes
% Remove old lines
if nargin > 4
    if size(removingList, 1) > 0
       for i = 1:size(removingList, 1)
          delete(removingList(i)); 
       end
    end
end
% Important parameters for plotting the bounding boxes
removingList = [];
boundingBoxColor = [242 204 142]/256;
% Now plot the bounding boxes together with annotations
for iTrack = 1:size(tracks, 2)
    %描绘自车
    if iTrack == params.selectid
    track = tracks(iTrack);
    initialFrame = track.initialFrame;
    finalFrame = track.finalFrame;
    if length(params.monitor_simout.tout)<finalFrame-initialFrame
        finalFrame = finalFrame-1;
    end
    if (initialFrame <= currentFrame) && (currentFrame < finalFrame)
        % Get internal track index for the chosen frame
        currentIndex = currentFrame - initialFrame + 1;
        % Try to get the bounding box
        try
            boundingBox = track.bbox(currentIndex, :);
            boundingBox = boundingBox / params.geoParams.meterPerPixel;
            boundingBox = boundingBox / 4;
            velocity = track.xVelocity(currentIndex);
            %Egolane = params.monitor_simout.Egolane.Data(currentIndex);
        catch
           continue 
        end
        % Plot the bounding box
        positionBoundingBox = [boundingBox(1) ...
                               boundingBox(2) ...
                               boundingBox(3) ...
                               boundingBox(4)];
        if params.stop == 1
            rect = rectangle(ax, 'Position', positionBoundingBox, ...
                                 'FaceColor', [130 178 154]/256, ...
                                 'EdgeColor', [0 0 0], ...
                                 'PickableParts', 'visible', ...
                                 'ButtonDownFcn',{@params.onClick, track, currentFrame});
        else
            rect = rectangle(ax, 'Position', positionBoundingBox, ...
                                 'FaceColor', [130 178 154]/256, ...
                                 'EdgeColor', [0 0 0], ...
                                 'PickableParts', 'visible');
        end
        removingList = [removingList; rect];
        
        % Plotting the triangle for the direction of the vehicle
        if velocity < 0
            back = boundingBox(1)+(boundingBox(3)*0.2);
            front = boundingBox(1);
        else
            back = boundingBox(1)+boundingBox(3)-(boundingBox(3)*0.2);
            front = boundingBox(1)+boundingBox(3);
        end
        triangleXPosition = [back back front];
        triangleYPosition = [boundingBox(2) ...
                             boundingBox(2)+boundingBox(4) ...
                             boundingBox(2)+(boundingBox(4)/2)];
        triangle = patch(ax, triangleXPosition, triangleYPosition, [0 0 0]);
        removingList = [removingList; triangle];
        
        % Plot the text annotation
        if params.plotTextAnnotation
            velocityKmh = abs(velocity) * 3.6;
            if params.monitor_simout.monitor_result.Data(currentIndex,8)~=0
                rule78 = 'Vehicle speed violation: True';
            else
                rule78 = 'Vehicle speed violation: False';
            end
            
            if params.monitor_simout.monitor_result.Data(currentIndex,9)~=0
                rule80 = 'Following distance violation: True';
            else
                rule80 = 'Following distance violation: False';
            end
            if velocityKmh>100
                Cd = 100;
            else
                Cd = 50;
            end
            if sum(params.monitor_simout.monitor_result.Data(currentIndex,10:11))~=0
                rule44 = 'Lane change violation: True';
            else
                rule44 = 'Lane change violation: False';
            end
            if sum(params.monitor_simout.monitor_result.Data(currentIndex,1:7))~=0
                rule47 = 'Overtake violation: True';
            else
                rule47 = 'Overtake violation: False';
            end
            distance = params.monitor_simout.distance.Data(currentIndex);
            cs1 = params.monitor_simout.Cs.Data(currentIndex,1);
            cs2 = params.monitor_simout.Cs.Data(currentIndex,2);
            Cd = params.monitor_simout.Cd.Data(currentIndex);
            if sum(params.monitor_simout.monitor_result.Data(currentIndex,10))~=0
                if params.monitor_simout.distance_f.Data(currentIndex-params.monitor_simout.distance_f.Time(1)*30)<14
                    df = 'distance\_f';
                else
                    df = '';
                end
                if params.monitor_simout.distance_rf.Data(currentIndex-params.monitor_simout.distance_rf.Time(1)*30)<14
                    drf = 'distance\_rf';
                else
                    drf = '';
                end
                if params.monitor_simout.distance_rr.Data(currentIndex-params.monitor_simout.distance_rr.Time(1)*30)<14
                    drr = 'distance\_rr';
                else
                    drr = '';
                end
                ind1 = params.monitor_simout.TTC_fvx_cr.Time(1)*30;
                ind2 = params.monitor_simout.TTC_rfvx.Time(1)*30;
                ind3 = params.monitor_simout.TTC_rrvx.Time(1)*30;
                if params.monitor_simout.TTC_fvx_cr.Data(currentIndex-ind1)<6 && params.monitor_simout.TTC_fvx_cr.Data(currentIndex-ind1)>0
                    ttcxf = 'TTCX\_f';
                else
                    ttcxf = '';
                end
                if params.monitor_simout.TTC_rfvx.Data(currentIndex-ind2)<6 && params.monitor_simout.TTC_rfvx.Data(currentIndex-ind2)>0
                    ttcxrf = 'TTCX\_rf';
                else
                    ttcxrf = ' ';
                end
                if params.monitor_simout.TTC_rrvx.Data(currentIndex-ind3)<6 && params.monitor_simout.TTC_rrvx.Data(currentIndex-ind3)>0
                    ttcxrr = 'TTCX\_rr';
                else
                    ttcxrr = '';
                end
                dlf=''; dlr=''; ttcxlf = ''; ttcxlr = '';
            elseif sum(params.monitor_simout.monitor_result.Data(currentIndex,11))~=0
                if params.monitor_simout.distance_f.Data(currentIndex-params.monitor_simout.distance_f.Time(1)*30)<14
                    df = 'distance\_f ';
                else
                    df = '';
                end
                if params.monitor_simout.distance_lf.Data(currentIndex-params.monitor_simout.distance_lf.Time(1)*30)<14
                    dlf = 'distance\_lf';
                else
                    dlf = '';
                end
                if params.monitor_simout.distance_lr.Data(currentIndex-params.monitor_simout.distance_lr.Time(1)*30)<14
                    dlr = 'distance\_lr';
                else
                    dlr = '';
                end
                ind1 = params.monitor_simout.TTC_fvx.Time(1)*30;
                ind2 = params.monitor_simout.TTC_lfvx.Time(1)*30;
                ind3 = params.monitor_simout.TTC_lrvx.Time(1)*30;
                if params.monitor_simout.TTC_fvx.Data(currentIndex-ind1)<6 && params.monitor_simout.TTC_fvx.Data(currentIndex-ind1)>0
                    ttcxf = 'TTCX\_f';
                else
                    ttcxf = '';
                end
                if params.monitor_simout.TTC_lfvx.Data(currentIndex-ind2)<6 && params.monitor_simout.TTC_lfvx.Data(currentIndex-ind2)>0
                    ttcxlf = 'TTCX\_lf';
                else
                    ttcxlf = '';
                end
                if params.monitor_simout.TTC_lrvx.Data(currentIndex-ind3)<6 && params.monitor_simout.TTC_lrvx.Data(currentIndex-ind3)>0
                    ttcxlr = 'TTCX\_lr';
                else
                    ttcxlr = '';
                end
                dlf=''; dlr=''; ttcxlf = ''; ttcxlr = '';
            else
                df = '';dlf=''; dlr=''; drf = ''; drr = ''; ttcxf = ''; ttcxlf = ''; ttcxlr = ''; ttcxrf = ''; ttcxrr = '';
            end
            boundingBoxAnnotationText = sprintf('Vehicle Type: %s | Vehicle ID: %d\n%s | Speed: %.2fkm/h | Compliance speed: %d - %dkm/h\n%s | Distance:  %.2fm | Compliance distance: %dm\n%s | %s %s %s %s %s %s %s %s %s %s \n%s | ', ...
                                                track.class(1),track.id, ...
                                                rule78,velocityKmh,cs1,cs2, ...
                                                rule80,distance,Cd, ...
                                                rule44,df,dlf,dlr,drf,drr,ttcxf,ttcxlf,ttcxlr,ttcxrf,ttcxrr, ...
                                                rule47);
%             textAnnotation = text(ax, boundingBox(1),boundingBox(2)-5, ...
%                                   boundingBoxAnnotationText, 'FontSize',8);        
            textAnnotation = text(ax, 140,180,boundingBoxAnnotationText, 'FontSize',12);
            textAnnotation.BackgroundColor = [1 1 1];
            textAnnotation.Margin = .5;
            removingList = [removingList; textAnnotation];
        end
        
        % Plot the track line
        if params.plotTrackingLine
            relevantBoundingBoxes = track.bbox(1:currentIndex, :);
            relevantBoundingBoxes = relevantBoundingBoxes / params.geoParams.meterPerPixel;
            relevantBoundingBoxes = relevantBoundingBoxes / 4;
            centroids = [relevantBoundingBoxes(:,1) + relevantBoundingBoxes(:,3)/2, ...
                relevantBoundingBoxes(:,2) + relevantBoundingBoxes(:,4)/2];
            if velocity < 0
                sign = 1;
            else
                sign = -1;
            end
            xdata = centroids(:, 1);
            ydata = centroids(:, 2);
            flag = [params.monitor_flag];
            j = 1;
            for i = 1:length(flag)-1
                if flag(i)~=flag(i+1)
                    index(j) = i+1;
                    j = j+1;
                end
            end
            if exist('index')
                index = [1,index,length(flag)];
            else
                index = [1,length(flag)];
            end
            k=find(index<=currentFrame-initialFrame+1, 1, 'last' );
            for i = 1:k
                if flag(index(i))==1
                    plottedCentroids = line(ax, 'XData', xdata(index(i):min(index(i+1),currentFrame-initialFrame+1))+sign*(boundingBox(3)/2), ...
                        'YData', ydata(index(i):min(index(i+1),currentFrame-initialFrame+1)),'Color','red','linewidth',2);
                    removingList = [removingList; plottedCentroids];
                else
                    plottedCentroids = line(ax, 'XData', xdata(index(i):min(index(i+1),currentFrame-initialFrame+1))+sign*(boundingBox(3)/2), ...
                        'YData', ydata(index(i):min(index(i+1),currentFrame-initialFrame+1)),'Color','green','linewidth',2);
                    removingList = [removingList; plottedCentroids];
                end
            end
%             
%             relevantBoundingBoxes = track.bbox(1:currentIndex, :);
%             relevantBoundingBoxes = relevantBoundingBoxes / params.geoParams.meterPerPixel;
%             relevantBoundingBoxes = relevantBoundingBoxes / 4;
%             centroids = [relevantBoundingBoxes(:,1) + relevantBoundingBoxes(:,3)/2, ...
%                 relevantBoundingBoxes(:,2) + relevantBoundingBoxes(:,4)/2];
%             if velocity < 0
%                 sign = 1;
%             else
%                 sign = -1;
%             end
%             plottedCentroids = line(ax, 'XData', centroids(:, 1)+sign*(boundingBox(3)/2), ...
%                 'YData', centroids(:, 2),'Color','green');
%             removingList = [removingList; plottedCentroids];
        end
%         flag = [params.monitor_flag;false;false;false];
%         if currentFrame-initialFrame+1<=length(flag) && flag(currentFrame-initialFrame+1)==1
%             relevantBoundingBoxes = track.bbox(1:currentIndex, :);
%             relevantBoundingBoxes = relevantBoundingBoxes / params.geoParams.meterPerPixel;
%             relevantBoundingBoxes = relevantBoundingBoxes / 4;
%             centroids = [relevantBoundingBoxes(:,1) + relevantBoundingBoxes(:,3)/2, ...
%                 relevantBoundingBoxes(:,2) + relevantBoundingBoxes(:,4)/2];
%             if velocity < 0
%                 sign = 1;
%             else
%                 sign = -1;
%             end
%             xdata = centroids(:, 1);
%             ydata = centroids(:, 2);
%             plottedCentroids = line(ax, 'XData', xdata(flag(1:min(currentFrame-initialFrame+1,length(flag))))+sign*(boundingBox(3)/2), ...
%                 'YData', ydata(flag(1:min(currentFrame-initialFrame+1,length(flag)))),'Color','red');
%             removingList = [removingList; plottedCentroids];
%         end
    end
    %描绘其他车
    else
    track = tracks(iTrack);
    initialFrame = track.initialFrame;
    finalFrame = track.finalFrame;
    if (initialFrame <= currentFrame) && (currentFrame < finalFrame)
        % Get internal track index for the chosen frame
        currentIndex = currentFrame - initialFrame + 1;
        % Try to get the bounding box
        try
            boundingBox = track.bbox(currentIndex, :);
            boundingBox = boundingBox / params.geoParams.meterPerPixel;
            boundingBox = boundingBox / 4;
            velocity = track.xVelocity(currentIndex);
        catch
           continue 
        end
        % Plot the bounding box
        positionBoundingBox = [boundingBox(1) ...
                               boundingBox(2) ...
                               boundingBox(3) ...
                               boundingBox(4)];
        if params.stop == 1
            rect = rectangle(ax, 'Position', positionBoundingBox, ...
                                 'FaceColor', boundingBoxColor, ...
                                 'EdgeColor', [0 0 0], ...
                                 'PickableParts', 'visible', ...
                                 'ButtonDownFcn',{@params.onClick, track, currentFrame});
        else
            rect = rectangle(ax, 'Position', positionBoundingBox, ...
                                 'FaceColor', boundingBoxColor, ...
                                 'EdgeColor', [0 0 0], ...
                                 'PickableParts', 'visible');
        end
        removingList = [removingList; rect];
        
        % Plotting the triangle for the direction of the vehicle
        if velocity < 0
            back = boundingBox(1)+(boundingBox(3)*0.2);
            front = boundingBox(1);
        else
            back = boundingBox(1)+boundingBox(3)-(boundingBox(3)*0.2);
            front = boundingBox(1)+boundingBox(3);
        end
        triangleXPosition = [back back front];
        triangleYPosition = [boundingBox(2) ...
                             boundingBox(2)+boundingBox(4) ...
                             boundingBox(2)+(boundingBox(4)/2)];
        triangle = patch(ax, triangleXPosition, triangleYPosition, [0 0 0]);
        removingList = [removingList; triangle];
        
        % Plot the text annotation
%         if params.plotTextAnnotation
%             velocityKmh = abs(velocity) * 3.6;
%             boundingBoxAnnotationText = sprintf('%s|%.2fkm/h|ID%d', ...
%                                                 track.class(1), ...
%                                                 velocityKmh, ...
%                                                 track.id);
%             textAnnotation = text(ax, boundingBox(1),boundingBox(2)-3, ...
%                                   boundingBoxAnnotationText, 'FontSize',8);        
%             textAnnotation.BackgroundColor = [1 1 .3];
%             textAnnotation.Margin = .5;
%             removingList = [removingList; textAnnotation];
%         end
        
        % Plot the track line
%         if params.plotTrackingLine
%             relevantBoundingBoxes = track.bbox(1:currentIndex, :);
%             relevantBoundingBoxes = relevantBoundingBoxes / params.geoParams.meterPerPixel;
%             relevantBoundingBoxes = relevantBoundingBoxes / 4;
%             centroids = [relevantBoundingBoxes(:,1) + relevantBoundingBoxes(:,3)/2, ...
%                          relevantBoundingBoxes(:,2) + relevantBoundingBoxes(:,4)/2];
%             if velocity < 0
%                 sign = 1;
%             else
%                 sign = -1;
%             end
%             plottedCentroids = line(ax, 'XData', centroids(:, 1)+sign*(boundingBox(3)/2), ...
%                                         'YData', centroids(:, 2));
%             removingList = [removingList; plottedCentroids];
%         end
    end
    end
end
xlim(ax, [0 params.trackWidth]);
axis off;
end
