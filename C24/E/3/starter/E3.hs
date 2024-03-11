module E3 where

-- |interleave xs ys
-- return a list of corresponding elements from xs and ys, interleaved. The remaining elements of
-- the longer list are ignored.  This function should use recursion and pattern matching.
interleave :: [a] -> [a] -> [a]
interleave [] _ = []    -- Check if xs is empty --
interleave _ [] = []    -- Check if ys is empty --
interleave (x:xs) (y:ys) = x : y : interleave xs ys

-- |toPairs xs ys
-- return a list of pairs of corresponding elements from xs and ys, interleaved. The remaining
-- elements of the longer list are ignored.  This function should use recursion and pattern
-- matching.
toPairs :: [a] -> [b] -> [(a, b)]
toPairs [] _ = []    -- Check if xs is empty --
toPairs _ [] = []    -- Check if ys is empty --
toPairs (x:xs) (y:ys) = (x, y) : toPairs xs ys

-- |repeat' f x n
-- return a list [x, f(x), f(f(x)), ..., f^n(x)]
-- requires n >= 0
-- This function should use map, recursion, and pattern matching.
-- repeat':: (a -> a) -> a -> Int -> [a]
repeat' _ x 0 = [x]
repeat' f x n = x : map f (repeat' f x (n - 1))

-- |numNeg xs
-- return a number of negative elements in xs
-- No recursion, no higher-order functions. Use list comprehension!
-- numNeg :: (Ord a, Num a) => [a] -> Int
numNeg xs = length [x | x <- xs, x < 0]

-- |genSquares low high
-- return a list of squares of even integers between low and high, inclusive.
-- No recursion, no higher-order functions. Use list comprehension!
-- genSquares :: Int -> Int -> [Int]
genSquares low high = [x^2 | x <- [low..high], x > low, x <= high] 

-- |triples n
-- return a list of triples (x,y,z) of positive numbers all less than
-- or equal to n, such that x^2 + y^2 == z^2, with no duplicate triples or
-- premutations of ealier triples.
-- No recursion, no higher-order functions. Use list comprehension!
-- triples :: Int -> [(Int, Int, Int)]
triples n = [(x, y, z) | x <- [1..n], x <= n, y <- [x..n], y <= n, z <- [y..n], x^2 + y^2 == z^2]
