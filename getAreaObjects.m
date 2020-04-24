function [area,areaParent, avgParent] = getAreaObjects(stats,sumRow)
% Purpose: return the area of each of the parent objects, 
% the sum of all those areas, and the average area of the parent objects
    count = 1;
    sum = 0; sum2 = 0;
	% check all objects
    for k = 1:length(stats)
        area(k) = stats(k).Area;
		% if the object is a parent object
        if (sumRow(k) == 0) % Parent Object
			% add the area of this parent object to get the summed 
			% area of the parent objects
            areaParent(count) = area(k);
			% count the number of parent object so we can
			% take the average later
            count = count +1;
        end
    end
	% use the total sum and the count to get the average parent area
    avgParent = mean(areaParent);
end