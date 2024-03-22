module TestLab8 where

import Lab8
import Test.HUnit

{- Test Lab 8 - starter -}


testEq = TestList [testEq1]
testEq1 = TestCase $ assertEqual
         "t == t' "
         True
         (t == t')


testShow = TestList [testShow1]
testShow1 = TestCase $ assertEqual
         "show t"
         "    20\n  15\n10\n    7\n      6\n  5\n    2\n"
         (show t)


testSizedBool = TestList [testSizedBool1,testSizedBool2]
testSizedBool1 = TestCase $ assertEqual
                "size True "
                1
                (size True)

testSizedBool2 = TestCase $ assertEqual
                "nonempty False "
                True
                (nonempty False)


testSizedList = TestList [testSizedList1,testSizedList2]
testSizedList1 = TestCase $ assertEqual
                "size [1,2,3] "
                3
                (size [1,2,3])

testSizedList2 = TestCase $ assertEqual
                "empty [1,2,3] "
                False
                (empty [1,2,3])

testSizedBTree = TestList [testSizedBTree1,testSizedBTree2,testSizedBTree3]
testSizedBTree1 = TestCase $ assertEqual
                 "size Empty "
                 0
                 (size Empty)

testSizedBTree2 = TestCase $ assertEqual
                 "empty Empty "
                 True
                 (empty Empty)

testSizedBTree3 = TestCase $ assertEqual
                 "size t "
                 7
                 (size t)


tests = TestList [TestLabel "Eq" testEq
                  ,TestLabel "Show" testShow
                  ,TestLabel "SizedBool" testSizedBool
                  ,TestLabel "SizedList" testSizedList
                  ,TestLabel "SizedBTree" testSizedBTree
                 ]

main = runTestTT tests
