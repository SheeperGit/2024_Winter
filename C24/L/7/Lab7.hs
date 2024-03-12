module Lab7 where
import Data.Binary.Get (label)

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
eval (Leaf l) = l
eval (Unary f u) = f (eval u)
eval (Binary f a b) = f (eval a) (eval b)

-- |apply op t
-- return the result of applying op to every leaf in t
apply :: (Integer -> Integer) -> MathTree -> MathTree
apply op (Leaf l) = Leaf (op l)
apply op (Unary f u) = Unary f (apply op u)
apply op (Binary f a b) = Binary f (apply op a) (apply op b)

-- |element v t
-- return whether v is in t
element :: Integer -> MathTree -> Bool
element v (Leaf l) = v == l
element v (Unary _ t) = element v t
element v (Binary _ a b) = element v a || element v b


-- |replace v v' t
-- return the result of replacing every value v in the leafs of t with v'
replace :: Integer -> Integer -> MathTree -> MathTree
replace v v' (Leaf l) = if l == v then Leaf v' else Leaf l
replace v v' (Unary f u) = Unary f (replace v v' u)
replace v v' (Binary f a b) = Binary f (replace v v' a) (replace v v' b)

-- |sumLeafs t
-- return the sum of the leafs of t
sumLeafs :: MathTree -> Integer
sumLeafs (Leaf l) = l
sumLeafs (Unary _ u) = sumLeafs u
sumLeafs (Binary _ a b) = sumLeafs a + sumLeafs b

-- |numNodes t
-- return the number of all nodes in t (including leaf and internal nodes)
numNodes :: MathTree -> Int
numNodes (Leaf _) = 1
numNodes (Unary _ a) = 1 + numNodes a
numNodes (Binary _ a b) = 1 + numNodes a + numNodes b

-- |numLevels t
-- return the number of levels in t (i.e., return the number of nodes on the longest root-to-leaf
-- path in t)
numLevels :: MathTree -> Int
numLevels (Leaf l) = 1
numLevels (Unary _ a) = 1 + numLevels a
numLevels (Binary _ a b) = 1 + max (numLevels a) (numLevels b)

-- |tflip t
-- return a tree which is a result of swapping, for every binary node in the tree, its right and
-- left child
tflip :: MathTree -> MathTree
tflip (Leaf l) = Leaf l
tflip (Unary f u) = Unary f (tflip u)
tflip (Binary f a b) = Binary f (tflip b) (tflip a)
