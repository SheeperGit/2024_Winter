module TestE3 where

import E3
import Test.HUnit

{- Test E3 -}

testInterleave = TestList [testInterleaveExample]
testInterleaveExample = TestCase $ assertEqual
                       ("\ninterleave [42, 45, 56] [24, 98, 567]:") [42, 24, 45, 98, 56, 567]
                       (interleave [42, 45, 56] [24, 98, 567])


testToPairs = TestList [testToPairsExample]

testToPairsExample = TestCase $ assertEqual
                     ("\ntoPairs [42, 45, 56] [24, 98, 567]:") [(42, 24), (45, 98), (56, 567)]
                     (toPairs [42, 45, 56] [24, 98, 567])


testRepeat = TestList [testRepeatExample]
inc x = x + 1
testRepeatExample = TestCase $ assertEqual
                    ("\nrepeat' inc 42 3:") [42,43,44,45]
                    (repeat' inc 42 3)

subset s t = all (`elem` t) s
sameSets s t = (length s == length t) && (s `subset` t) && (t `subset` s)

testNumNeg = TestList [testNumNegExample]
testNumNegExample = TestCase $ assertEqual
                    ("\nnumNeg [1,-2,3,-3.14]:") 2
                    (numNeg [1,-2,3,-3.14])

testGenSquares = TestList [testGenSquaresExample]
testGenSquaresExample = TestCase $ assertEqual
                        ("\ngenSquares 5 20:") [36,64,100,144,196,256,324,400]
                        (genSquares 5 20)

testTriples = TestList [testTriplesExample]
testTriplesExample = TestCase $ assertEqual
                     ("\ntriples 15:") True
                     (sameSets (triples 15) [(3,4,5),(5,12,13),(6,8,10),(9,12,15)])

tests = TestList [testInterleave,testToPairs,testRepeat,testNumNeg,testGenSquares,testTriples]
main = runTestTT tests
