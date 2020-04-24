function drawBoundary(origIm,B,sumRow,avgParentArea,area,A)
figure
imshow(origIm)
hold on

% show original image and draw boundaries over them
count = 1;
countCyan = 1;
sum = 0; sum2 = 0;
% for each boundary that was detected, we want to draw a border
for k = 1:length(B)
    boundary = B{k};
	% we want to color parent(cancer) object differently than child objects,
	% so check if the boundary is for a parent object
    if (sumRow(k) == 0) % Parent Object
		% Check if the object is above a threshold
		% the threshold is the average parent object size
		% this threshold was chosen because there are a lot of very small 
		% negligible objects that bring the average down enough to make this
		% threshold capture all of the relevant objects
		%      subtract from the threshold if it result is missing object
		%      add to threshold if the result is including too many objects
        if(area(k)>=avgParentArea)
			% draw a cyan border around the 'relevant' cyan objects (detected cancer)
            plot(boundary(:,2),boundary(:,1),'c','LineWidth',0.1)
			% add the area to a sum so we can find the total area of the detected cancer
            sum = sum + area(k);
			% counting the number of cancer objects detected
            countCyan = countCyan+1;
		%  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -	
            % for the included large parent (cancer), check for non-cancer inside
            % detected cancer (child object)
            i = k;
            for j = 1:size(A,2)
                if A(j,i) == 1 % if child inside of detected cancer
                    % draw boundary of child, and make it green 
                    childBoundary = B{j};
                    plot(childBoundary(:,2),childBoundary(:,1),'g','LineWidth',0.05)
					% add the area to a sum so we can find the total area of non-cancer inside
					% of detected cancer (child object)
                    sum2 = sum2 + area(j);
                end
            end
        else
			% plot(boundary(:,2),boundary(:,1),'r','LineWidth',0.05)
        end
        areaParent(count) = area(k);
        count = count +1;
    else % Child Object
        % plot(boundary(:,2),boundary(:,1),'r','LineWidth',0.1)
        % disp(k)
        % sum2 = sum2 + area(k);
    end
end

% formatting the figure to display several of the calculated values
title("Object Boundaries Found")
% percentage of image that is detected cancer
percentPurple = (sum/(numel(origIm)/3));
fprintf("Number of Purple Pixels: %.0f \n",sum)
fprintf("Percentage Purple Cancer: %.4f \n",percentPurple)
% percentage of image that is detected cancer on-cancer inside of detected cancer (child object)
percentChild = (sum2/(numel(origIm)/3));
fprintf("Percentage Child: %.4f \n",percentChild)
fprintf("Percentage Background: %.4f \n",((numel(origIm)/3)-sum-sum2)/(numel(origIm)/3))
annotation('textbox',[.15 0.8 .1 .2],'String',strcat('Parent',num2str(percentPurple)),'EdgeColor','none')
annotation('textbox',[.7 0.8 .1 .2],'String',strcat('Child',num2str(percentChild)),'EdgeColor','none')

% figName = strcat(resultDir,fileName,'_Results',type);
% saveas(gcf,strcat(figName,'.jpg')) % save .jpg
fprintf("Number of Cancer Objects %i\n",countCyan-1)
end