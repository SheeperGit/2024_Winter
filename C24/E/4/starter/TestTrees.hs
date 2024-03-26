module TestTrees where

import Trees
import Test.HUnit

{- Starter -- Test Trees -}

three = Node "one" (Leaf "two") (Leaf "three")
long xs = length xs > 4

testCountNodes = TestList [testCountNodesExample]
testCountNodesExample = TestCase $ assertEqual
                        ("countNodes three is ") 3
                        (countNodes three)

testForallNodes = TestList [testForallNodesExample]
testForallNodesExample = TestCase $ assertEqual
                         ("forallNodes long three is ") False
                         (forallNodes long three)

testExistsNode = TestList [testExistsNodeExample]
testExistsNodeExample = TestCase $ assertEqual
                        ("existsNode long three is ") True
                        (existsNode long three)

testInorder = TestList [testInorderExample]
testInorderExample = TestCase $ assertEqual
                     ("inroder three is ") ["two","one","three"]
                     (inorder three)

tests = TestList [testCountNodes,testForallNodes,testExistsNode,testInorder]

countNodesRes = runTestTT testCountNodes
forallNodesRes = runTestTT testForallNodes
existsNodeRes = runTestTT testExistsNode
inorderRes = runTestTT testInorder

main = runTestTT tests
