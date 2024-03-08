-- enumerated type
data Colour = Red | Green | Blue

c = Red

colourName :: Colour -> [Char]
colourName Red = "Red"
colourName Green = "Green"
colourName Blue = "Blue"

-- variant type
data Text = Letter Char | Word [Char]

textLen :: Text -> Int
textLen (Letter _) = 1
textLen (Word w) = length w

-- recursive type
data LList = Nil | Node (Int, LList) deriving Show

llist = Node (1, Node (2, Node(3, Nil)))
llist :: LList

llistLen :: LList -> Int
llistLen Nil = 0
llistLen (Node (_, rest)) = 1 + llistLen rest

-- polymorphic recursive type
data LList' a = Nil' | Node' (a, LList' a) deriving Show

llist' = Node' ('1', Node' ('2', Node' ('3', Nil')))
llist' :: LList' Char

llistLen' :: LList' a -> Int
llistLen' Nil' = 0
llistLen' (Node' (_, rest)) = 1 + llistLen' rest

-- mathematical expressions
-- leafs are numbers (integers for now)
-- internal nodes are either unary functions and one child
-- or binary functions and two children
{-
data MathExpr = Leaf Int
              | Unary (Int -> Int, MathExpr)
              | Binary (Int -> Int -> Int, MathExpr, MathExpr)
-}
{-
t = Binary((+),
           Binary((+),
                  Unary(abs,
                        Unary ((0-),
                               Leaf 3)),
                  Leaf 2),
           Binary((*),
                  Binary((+),
                         Unary((0-),
                               Leaf 1),
                         Leaf 4),
                  Leaf 7))
-}
t :: MathExpr

-- eval :: MathExpr -> Int
{-
eval (Leaf l) = l
eval (Unary (f, u)) = f (eval u)
eval (Binary (f, a, b)) = f (eval a) (eval b)
-}

-- the curried version:

data MathExpr = Leaf Int
              | Unary (Int -> Int) MathExpr
              | Binary (Int -> Int -> Int) MathExpr MathExpr

t = Binary (+)
           (Binary (+)
                   (Unary abs
                          (Unary (0-)
                                 (Leaf 3)))
                   (Leaf 2))
           (Binary (*)
                   (Binary (+)
                           (Unary (0-)
                                  (Leaf 1))
                           (Leaf 4))
                   (Leaf 7))

data BTree a = Empty | Node a (BTree a) (BTree a)

-- inorder t returns a list of elements of t, in the order of in-order
-- traversal of BTree t
inorder Empty = []
inorder (BTree v l r) = (inorder l) ++ [v] ++ (inorder r)


data Tree a = Empty
            | BNode (Branch a) (Branch a)
data Branch a = Branch a (Tree a)

-- listTree t return a list of labels of t
listTree :: Branch a -> [a]
listBranch :: Tree a -> [a]
listTree Empty = []
listTree (BNode l r) = (listBranch l) ++ (listBranch r)
listBranch (Branch v t) = v : listTree t

-- what is the type of listTree?
-- what is the type of listBranch?

lt =
    BNode(Branch 1
                (BNode (Branch 2 Empty)
                       (Branch 3 (BNode (Branch 4 Empty)
                                        (Branch 5 Empty)))))
        (Branch 6
                (BNode (Branch 7 Empty)
                       (Branch 8 Empty)))



class YesNo a where
    yesno :: a -> Bool

instance YesNo Integer where
    yesno 0 = False
    yesno _ = True

instance YesNo [a] where
    yesno [] = False
    yesno _ = True

instance YesNo Bool where
    yesno x = x

instance YesNo (Tree a) where
    yesno Empty = False
    yesno _ = True


-- infinite list of 1's
-- list of integers from n and up
-- natural numbers
-- all squares of nats
-- all odd naturals
-- all even naturals
-- Fibonacci numbers

-- is x prime?
prime x = False
-- all primes
