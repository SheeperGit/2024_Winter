module Tester where

import Lab6
import Test.HUnit

matrix1 :: (Num a) => [[a]]
matrix2 :: (Num a) => [[a]]

matrix1 = [[1,0,2],
           [2,1,4],
           [-1,1,-1]]
matrix2 = [[1,2,3],
           [4,5,6],
           [7,8,9]]

testVectorAdd = TestCase $ assertEqual
              ("vectorAdd [1,0,-2,5] [-2,2,2,5.5]") ([-1,2,0,10.5]) (vectorAdd [1,0,-2,5] [-2,2,2,5.5])
testsVectorAdd = TestList [TestLabel "vectorAdd many" testVectorAdd]


testAdd = TestCase $ assertEqual
           ("add matrix1 matrix2") ([[2,2,5],[6,6,10],[6,9,8]]) (add matrix1 matrix2)
testsAdd = TestList [TestLabel "add square" testAdd]

testScalarVectorMult = TestCase $ assertEqual
                        ("scalarVectorMult 42 [1.5,2,0]") ([63,84,0]) (scalarVectorMult 42 [1.5,2,0])
testsScalarVectorMult = TestList [TestLabel "scalarVectorMult larger" testScalarVectorMult]

testScalarMult = TestCase $ assertEqual
                  ("scalarMult 2.5 matrix1") ([[2.5,0.0,5.0],[5.0,2.5,10.0],[-2.5,2.5,-2.5]]) (scalarMult 2.5 m1)
testsScalarMult = TestList [TestLabel "scalarMult square" testScalarMult]

testTranspose = TestCase $ assertEqual
                 ("transposeMatrix m1") ([[1,2,-1],[0,1,1],[2,4,-1]]) (transposeMatrix m1)
testsTranspose = TestList [TestLabel "transposeMatrix square" testTranspose]

testMult =  TestCase $ assertEqual
             ("mult matrix1 matrix2") ([[15,18,21],[34,41,48],[-4,-5,-6]]) (mult matrix1 matrix2)
testsMult = TestList [TestLabel "mult square" testMult]

testDotProduct =  TestCase $ assertEqual
                   ("dotProduct [-1,2,0] [2.5,0,-2]") (-2.5) (dotProduct [-1,2,0] [2.5,0,-2.5])
testsDotProduct = TestList [TestLabel "dotProduct many neg" testDotProduct]

vectorAddRes = runTestTT testsVectorAdd
addRes = runTestTT testsAdd
scalarVectorMultRes = runTestTT testsScalarVectorMult
scalarMultRes = runTestTT testsScalarMult
transposeRes = runTestTT testsTranspose
multRes = runTestTT testsMult
dotProductRes = runTestTT testsDotProduct
