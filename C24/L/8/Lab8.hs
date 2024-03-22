module Lab8 where

import Data.List

-- recall our datatype for binary trees from class
data BTree a = Empty | Node a (BTree a) (BTree a)

t = Node 10
    (Node 5
     (Node 2 Empty Empty)
     (Node 7
      (Node 6 Empty Empty)
      Empty))
    (Node 15
     Empty
     (Node 20 Empty Empty))

t' = Node 10
     (Node 15
      (Node 6 Empty Empty)
      (Node 20 Empty Empty))
    (Node 5
     (Node 2 Empty Empty)
     (Node 7 Empty Empty))

-- |preorder t
-- return a list of values in t, in preorder traversal order
preorder :: BTree a -> [a]
preorder Empty = []
preorder (Node val left right) = val : (preorder left ++ preorder right)


-- We want to be able to compare BTrees for equality. We decide that two BTrees are equal if they
-- contain the same elements. The shapes of the trees do not determine whether the trees are equal.

instance (Eq a) => Eq (BTree a) where
    t1 == t2 = preorder t1 == preorder t2

-- we want to be able to display BTrees as follows (tilt your head to the left!)
--     20
--  15
--10
--    7
--      6
--  5
--    2

instance (Show a) => Show (BTree a) where
    show = showIndented ""
        where
            showIndented _ Empty = ""
            showIndented indent (Node val left right) =     -- Note: indent itself is incremented here!
                showIndented (indent ++ "  ") right ++ "\n" ++ indent ++ show val ++ "\n" ++ showIndented (indent ++ "  ") left
                -- right then left shows the BTree in descending order. left then right will show in ascending order

-- Let's create a type class Sized, which prescribes a function
-- size :: a -> Int, and provides definitions for
-- empty :: a -> Bool and nonempty :: a -> Bool

-- This is looking a lot like Template Method!
class Sized a where
    size :: a -> Int          -- Abstract Method

    empty :: a -> Bool        -- Concrete Method using Abstract Method `size`
    empty x = size x == 0

    nonempty :: a -> Bool     -- Concrete Method using Concrete Method `empty` using Abstract Method `size`
    nonempty x = not (empty x)

-- now let's state that all Bool's are of size 1, by defining
-- a corresponding instance

instance Sized Bool where
    size _ = 1


-- now let's make lists Sized, by defining the size of a list
-- to be its length

instance Sized [a] where
    size = length
    -- EQV to size l = length l

-- finally, let's make our BTree's Sized, by defining the size of a BTree
-- to be the number of the elements stored in it

instance Sized (BTree a) where
     size btree = length (preorder btree)
