module Lab7 where

-- mathematical expressions
-- leafs are numbers (integers)
-- internal nodes are either unary functions with one child
-- or binary functions with two children
data MathTree = Leaf Integer
              | Unary (Integer -> Integer) MathTree
              | Binary (Integer -> Integer -> Integer) MathTree MathTree

-- This is here to let Haskell know how to display the MathTree to you.
-- We will learn later what exactly this is and how it works.
instance Show MathTree where
    show (Leaf v) = show v
    show (Unary f t) = "unary(" ++ show t ++ ")"
    show (Binary f l r) = "binary(" ++ show l ++ "," ++ show r ++ ")"

-- |eval t
-- return the result of evaluating t
eval :: MathTree -> Integer

-- |apply op t
-- return the result of applying op to every leaf in t
apply :: (Integer -> Integer) -> MathTree -> MathTree

-- |element v t
-- return whether v is in t
element :: Integer -> MathTree -> Bool

-- |replace v v' t
-- return the result of replacing every value v in the leafs of t with v'
replace :: Integer -> Integer -> MathTree -> MathTree

-- |sumLeafs t
-- return the sum of the leafs of t
sumLeafs :: MathTree -> Integer

-- |numNodes t
-- return the number of all nodes in t (including leaf and internal nodes)
numNodes :: MathTree -> Int

-- |numLevels t
-- return the number of levels in t (i.e., return the number of nodes on the longest root-to-leaf
-- path in t)
numLevels :: MathTree -> Int

-- |tflip t
-- return a tree which is a result of swapping, for every binary node in the tree, its right and
-- left child
tflip :: MathTree -> MathTree
