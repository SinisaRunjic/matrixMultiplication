classdef MatrixMultiplicationClassTest < matlab.unittest.TestCase
    %MatrixMultiplicationClassTest is test class function to test matrixMultiplication function
    properties (TestParameter) %% parameters that will be used in test methods
        %% square marixes taken from book "Linearna algebra" Momir V. ?eli? i Biljana Sukara-?eli? published 2010
        squareMatrixes = struct('squareMatrixes1',[1 3;2 5],'squareMatrixes2',[2 1 1; 6 2 1; -2 2 1]); 
        squareMatrixInverse = struct('squareMatrixInverse1',[-5 3; 2 -1],'squareMatrixInverse2',[0 1 -1; -8 4 4; 16 -6 -2]./8); 
        %% scalars
        scalars = struct('scalar1',1,'scalar2',3,'scalar3',4,'scalar4',6,'scalar5',-1);
        scalarInverse = struct('scalarInverse1',1,'scalarInverse2',1/3,'scalarInverse3',0.25,'scalarInverse4',1/6,'scalarInverse5',-1)
        %% square marixes with complex numbers     
        squareMatrixWithComplexNumbers = struct('matixWithComplexNumbers1', [3+2i,1+5i;-3+2i, 3-2i],'matixWithComplexNumbers2', [2i,1+5i;-3+2i, 3]);
        %% row vectors and column vectors
        vectorRows = struct('vectorRow1',[1 2 -1 -2],'vectorRow2',[1 2 5 -1 -2 10],'vectorRow3',[1 10 2 5 -1 -2 10 2]);
        vectorColumns = struct('vectorColumn1',[1 2 -1 -2]','vectorColumn2',[1 2 5 -1 -2 10]','vectorColumn3',[1 10 2 5 -1 -2 10 2]');
        %% variables design to verify errors
        cells = {{1},{3},{[55, 22; 3 3]},{[55, 22, 3, 3]}};
        squareMatrixOfCells ={[{1} {2}; {-1} {-2}],[{1} {2} {-2}; {-1} {-2},{-4}]};
        squareMatrixWithString =struct('stringMatrix1',[1, 2; '3', 4],'stringMatrix2',['1', '2'; '3', '4']);
        squareMultidimensionalArray = struct('multidimensionalArray1', ones(4,4,5),'multidimensionalArray2', zeros(2,2,6));
        nonSquareMatrixes = struct('nonSquareMatrixes1',eye(2,3), 'nonSquareMatrixes2', ones(3,2));
    end
    methods(TestClassSetup) %% runs when test class is about to close
        function setupOnce(testCase)
            format long
        end
    end
    methods(TestClassTeardown) %% runs when test class is about to close
        function teardownOnce(testCase)
            format short
        end
    end
    methods (Test, ParameterCombination = 'sequential')
        %% test values
        function testProductsOfSquareMatrixAndInverse(testCase, squareMatrixes,squareMatrixInverse )
            actualSolution = matrixMultiplication(squareMatrixes, squareMatrixInverse);
            expectedSolution = eye(size(squareMatrixes));
            verifyEqual(testCase,actualSolution, expectedSolution, 'Product of 2 matrixes is wrong')
        end
        function testProductsOfInverseSquareMatrixAndSquareMatrix(testCase, squareMatrixes,squareMatrixInverse )
            actualSolution = matrixMultiplication(squareMatrixInverse, squareMatrixes);
            expectedSolution = eye(size(squareMatrixes));
            verifyEqual(testCase,actualSolution, expectedSolution, 'Product of 2 matrixes is wrong')
        end
        function testProductsOfSquareMatrix(testCase, squareMatrixes )
            actualSolution = matrixMultiplication(squareMatrixes, squareMatrixes);
            expectedSolution = squareMatrixes^2;
            verifyEqual(testCase,actualSolution, expectedSolution, 'Product of 2 matrixes is wrong')
        end
        function testScalar(testCase, scalars)
            actualSolution = matrixMultiplication(scalars, scalars);
            expectedSolution = scalars*scalars;
            verifyEqual(testCase,actualSolution, expectedSolution, 'Product of 2 matrixes is wrong')
        end
        function testScalarAndScalarInverse(testCase, scalars, scalarInverse)
            actualSolution = matrixMultiplication(scalars, scalarInverse);
            expectedSolution = scalars*scalarInverse;
            verifyEqual(testCase,actualSolution, expectedSolution, 'Product of 2 matrixes is wrong')
        end
        function testSquareMatrixInverseWithComplexNumber(testCase, squareMatrixWithComplexNumbers)
            actualSolution = matrixMultiplication(squareMatrixWithComplexNumbers, squareMatrixWithComplexNumbers);
            expectedSolution = squareMatrixWithComplexNumbers*squareMatrixWithComplexNumbers;
            verifyEqual(testCase, actualSolution, expectedSolution, 'Product of 2 matrixes is wrong')
        end
        function testVectorRowAndVectorColumn(testCase, vectorRows, vectorColumns)
            actualSolution = matrixMultiplication(vectorRows, vectorColumns);
            expectedSolution = vectorRows*vectorColumns;
            verifyEqual(testCase,actualSolution, expectedSolution, 'Product of 2 matrixes is wrong')
        end
        function testColumnVectorAndRowVector(testCase,vectorColumns, vectorRows)
            actualSolution = matrixMultiplication(vectorColumns, vectorRows);
            expectedSolution = vectorColumns*vectorRows;
            verifyEqual(testCase,actualSolution, expectedSolution, 'Product of 2 matrixes is wrong')
        end
    end
    methods(Test, ParameterCombination = 'pairwise')
        function testScalarAndMatrixes(testCase, scalars, squareMatrixes)
           actualSolution = matrixMultiplication(scalars, squareMatrixes);
           expectedSolution = scalars*squareMatrixes;
           verifyEqual(testCase,actualSolution, expectedSolution, 'Product of 2 matrixes is wrong') 
        end
        function testMatrixesAndScalar(testCase, scalars, squareMatrixes)
           actualSolution = matrixMultiplication( squareMatrixes, scalars);
           expectedSolution = squareMatrixes*scalars;
           verifyEqual(testCase,actualSolution, expectedSolution, 'Product of 2 matrixes is wrong') 
        end
    end
    methods (Test)
         %% test for errors
        function testCells(testCase,cells)
            verifyError(testCase,@() matrixMultiplication(cells,cells),?MException,'Can''t calculate product of cell')
        end
        function testSquareMatrixWithCells(testCase,squareMatrixOfCells)
            verifyError(testCase,@() matrixMultiplication(squareMatrixOfCells,squareMatrixOfCells),?MException,'Can''t calculate product of cell')
        end
        function testSquareMatrixWithString(testCase, squareMatrixWithString)
            verifyError(testCase,@() matrixMultiplication(squareMatrixWithString,squareMatrixWithString), ?MException, 'Can''t calculate product if one of matrix isn''t numeric')
        end
        function testSquareMultidimensionalArray(testCase, squareMultidimensionalArray)
            verifyError(testCase,@() matrixMultiplication(squareMultidimensionalArray,squareMultidimensionalArray), ?MException, 'Can''t calculate product of multidimensional array')
        end
        function testNonSquareMatrixes(testCase, nonSquareMatrixes)
            verifyError(testCase,@() matrixMultiplication(nonSquareMatrixes,nonSquareMatrixes), ?MException, 'Can''t calculate product of matrixes if dimensions aren''t good')
        end
    end
end