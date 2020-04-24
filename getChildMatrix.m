function [childMatrix] = getChildMatrix(A)
% Purpose: Create a matrix that describes which objects are child objects
	% the inputted matirx A is a sparse matrix, so we need to travel 
	% the whole matrix to find when there is a 1 (indicating it is a child object)
    childMatrix = zeros(size(A,1),1);
    for i = 1:size(A,1) % check each row
        j = 1;
		% check all the values in the row. If there is a 1, you no longer need to check. It is a child object
        while (j <=size(A,2) && childMatrix(i) == 0) 
			% if it's a 1, say that this object is a child object
            if A(i,j) == 1
                childMatrix(i) = 1;
            end
            j = j+1;
        end
    end
end