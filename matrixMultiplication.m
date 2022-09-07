function  product = matrixMultiplication(firstMatrix, secoundMatrix)
%matrixMultiplication takes 2 numeric matrixes and returns firstMatrix *
%secoundMatrix
    assert(nargin>1 ,'Provide input argument');
    %% test if matixes are a cell 
    assert(~iscell(firstMatrix) & ~iscell(secoundMatrix) ,'At least one input matrix is a cell');
    %% test if matrixes are multidimensional array
    [rowFirstMatrix, columnFirstMatrix, layerFirstMatrix] = size(firstMatrix);
    [rowSecoundMatrix, columnSecoundMatrix, layerSecoundMatrix] = size(secoundMatrix);
    assert(layerFirstMatrix == 1 & layerSecoundMatrix == 1 ,'At least one of input matrix is multidimensional');
    clear layerFirstMatrix layerSecoundMatrix;
    %% test if matrix is numeric
    assert(isnumeric(firstMatrix) & isnumeric(secoundMatrix) ,'At least one element in matrix isn''t numeric');
    %% return value if one of matrixes is scalar
    if((rowFirstMatrix == 1 && columnFirstMatrix== 1)||(rowSecoundMatrix==1 && columnSecoundMatrix==1))
        product = firstMatrix * secoundMatrix;
        return  
    else
        %% test column number of 1st matrix and row number of 2nd matrix
        assert(columnFirstMatrix == rowSecoundMatrix, 'Dimensions of matrix must agree')
        product = zeros(rowFirstMatrix,columnSecoundMatrix);
        for i=1:rowFirstMatrix
            for k = 1:columnSecoundMatrix
                for j = 1:columnFirstMatrix
                    product(i,k) = product(i,k) +  firstMatrix(i,j) * secoundMatrix(j,k);
                end
            end
        end
    end
end

