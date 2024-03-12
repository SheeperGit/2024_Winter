module TestLab7 where

import Lab7
import Test.HUnit

{-- Test Lab 7 -}

-- (abs(-3) + 2) + ((-1 + 4) * 7) = 26
t = Binary (+)
    (Binary (+)
      (Unary abs
       (Unary (0-) (Leaf 3)))
      (Leaf 2))
    (Binary (*)
      (Binary (+)
       (Unary (0-) (Leaf 1))
       (Leaf 4))
      (Leaf 7))

-- (abs(-6) + 4) + ((-2 + 8) * 14) = 94
t2 = Binary (+)
     (Binary (+)
      (Unary abs
       (Unary (0-) (Leaf 6)))
      (Leaf 4))
     (Binary (*)
      (Binary (+)
       (Unary (0-) (Leaf 2))
       (Leaf 8))
      (Leaf 14))

-- (abs(-3) + 42) + ((-1 + 4) * 7) = 66
t3 = Binary (+)
     (Binary (+)
      (Unary abs
       (Unary (0-) (Leaf 3)))
      (Leaf 42))
     (Binary (*)
      (Binary (+)
       (Unary (0-) (Leaf 1))
       (Leaf 4))
      (Leaf 7))

-- (abs(-3) + 2) + ((-1 + 4) * 7) = 26
-- (7 * (4 + -1)) + (2 + abs(-3))
tflipped = Binary (+)
           (Binary (*)
            (Leaf 7)
            (Binary (+)
             (Leaf 4)
             (Unary (0-) (Leaf 1))))
           (Binary (+)
            (Leaf 2)
            (Unary abs
             (Unary (0-) (Leaf 3))))

--(abs(-(2 * 3)) + (2 * 2)) + ((-(2 * 1) + (2 * 4)) * (2 * 7)) == 94
testApply = TestCase $ assertEqual
            ("show $ apply (2*) t is ")
            (show t2)
            (show $ apply (2*) t)

-- (abs(-3) + 2) + ((-1 + 4) * 7)
testElement = TestCase $ assertEqual
              ("element 2 t is ")
              True
              (element 2 t)

-- (abs(-3) + 42) + ((-1 + 4) * 7) = 66
testReplace = TestCase $ assertEqual
              ("show $ replace 2 42 t is ")
              (show t3)
              (show $ replace 2 42 t)

testSumLeafs = TestCase $ assertEqual
                ("sumLeafs t is ")
                17
                (sumLeafs t)

testNumNodes = TestCase $ assertEqual
               ("numNodes t is ")
               12
               (numNodes t)

testNumLevels = TestCase $ assertEqual
                ("numLevels t is ")
                5
                (numLevels t)

testFlip = TestCase $ assertEqual
            ("show $ tflip t is ")
            (show tflipped)
            (show $ tflip t)

tests = TestList [TestLabel "apply" testApply,
                  TestLabel "element" testElement,
                  TestLabel "replace" testReplace,
                  TestLabel "sumLeafs" testSumLeafs,
                  TestLabel "numNodes" testNumNodes,
                  TestLabel "numLevels" testNumLevels,
                  TestLabel "tflip" testFlip
                 ]

main = runTestTT tests
