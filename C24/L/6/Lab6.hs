module Lab6 where

m1 :: (Num a) => [[a]]
m2 :: (Num a) => [[a]]
m3 :: (Num a) => [[a]]

m1 = [[1,0,2],
      [2,1,4],
      [-1,1,-1]]
m2 = [[1,2,3],
      [4,5,6],
      [7,8,9]]
m3 = [[2,2,5],
      [6,6,10],
      [6,9,8]]
m4 = [[1, 2, 3],
      [3, 4, 2],
      [3, 2, 1]]
m5 = [[1, 1, 1],
      [3, 4, 2],
      [3, 2, 1]]
m1tr = [[1,2,-1],
        [0,1,1],
        [2,4,-1]]
{-
   bad            good
f x = g x    <==>  f = g
f x = g (h x)     <==>  f = g . h
-}
-- In all of the following, we assume that dimensions of input vectors and matrices are such that
-- the corresponsing operations are well-defined.

-- Make sure your code works on empty vectors and matrices! The empty matrix is represented as [].

-- Make sure your code passes hlint!

-- Provide the shortest solution you can think of. Hint: use zipWith.
-- |vectorAdd v1 v2
-- return the sum of vectors v1 and v2
vectorAdd :: Num a => [a] -> [a] -> [a]
vectorAdd = zipWith (+)
-- vectorAdd v1 v2 = zipWith (+) v1 v2

-- Provide the shortest solution you can think of. Hint: use zipWith and any of the already defined
-- functions.
-- |add m1 m2
-- return the sum of matrices m1 and m2
add :: Num a => [[a]] -> [[a]] -> [[a]]
add = zipWith vectorAdd
-- add m1 m2 = zipWith vectorAdd m1 m2

-- Provide the shortest solution you can think of. Hint: use map.
-- |scalarVectorMult k v
-- return the result of scalar multiplication of vector v by scalar k
scalarVectorMult :: Num a => a -> [a] -> [a]
scalarVectorMult k = map (* k)
-- scalarVectorMult k v = map (* k) v

-- Provide the shortest solution you can think of. Hint: use map and "." and any of the already
-- defined functions.
-- |scalarMult k m
-- return the result of scalar multiplication of matrix m by scalar k
scalarMult :: Num a => a -> [[a]] -> [[a]]
scalarMult = map . scalarVectorMult
-- scalarMult k m = map (scalarVectorMult k) m
-- scalarMult k = map (scalarVectorMult k)

-- Provide a recursive version that uses map.
-- |transposeMatrix m
-- return the transpose of matrix m
transposeMatrix :: Num a => [[a]] -> [[a]]
transposeMatrix ([]:_) = []   -- Empty row --
transposeMatrix m = map head m : transposeMatrix (map tail m)
{-

Explanation) For m = [[1,2,3],[4,5,6],[7,8,9]]

transposeMatrix m turns into the following (at the 1st iter):

map head x = [1,4,7]
map tail x = [[2,3],[5,6],[8,9]]
 
-}

-- Provide the shortest solution you can think of. Hint: use a couple of maps and any of the already
-- defined functions.
-- |mult m1 m2
-- return the product of matrices m1 and m2
mult :: Num a => [[a]] -> [[a]] -> [[a]]
mult m1 m2 = 
    let m2_T = transposeMatrix m2   -- Note: `let` denotes a local var in `mult` --
    in map (\ row1 -> map (sum . zipWith (*) row1) m2_T) m1       -- `\` === lambda --

-- Provide the shortest solution you can think of. Hint: use zipWith and sum.
-- If you are brave enough, use a couple of "."s for an even shorter solution!
-- |dotProduct v1 v2
-- return the dot product of v1 and v2
dotProduct :: Num a => [a] -> [a] -> a
dotProduct =  (sum .) . zipWith (*)
-- dotProduct v1 v2 =  (sum .) . zipWith (*) v1 v2
