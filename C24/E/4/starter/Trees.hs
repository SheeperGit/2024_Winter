module Trees where

-- |A binary tree.
data Tree a = Leaf a | Node a (Tree a) (Tree a)
three = Node "one" (Leaf "two") (Leaf "three")
five = Node "t" (Node "i" (Leaf "n") (Leaf "y")) (Leaf ":)")
long xs = length xs > 4
short xs = length xs < 4

-- |countNodes t
-- return the number of all nodes in tree t
countNodes:: Tree a -> Int
countNodes (Leaf _) = 1
countNodes (Node _ l r) = 1 + countNodes l + countNodes r

-- |forallNodes p t
-- return whether p is true of every node in tree t
forallNodes:: (a -> Bool) -> Tree a -> Bool
forallNodes p (Leaf l) = p l
forallNodes p (Node n l r) = p n && forallNodes p l && forallNodes p r

-- |existsNode p t
-- return whether p is true of some node in tree t
existsNode:: (a -> Bool) -> Tree a -> Bool
existsNode p (Leaf l) = p l
existsNode p (Node n l r) = p n || existsNode p l || existsNode p r

-- |inorder t
-- return a list of nodes in t in inorder traversal order
inorder:: Tree a -> [a]
inorder (Leaf l) = [l]
inorder (Node n l r) = inorder l ++ [n] ++ inorder r

tfold:: (a -> b) -> (a -> b -> b -> b) -> Tree a -> b
tfold f g (Leaf x) = f x
tfold f g (Node x left right) = g x (tfold f g left) (tfold f g right)

countNodes':: Tree a -> Int
countNodes' = tfold (const 1) (\_ l r -> 1 + l + r)

forallNodes':: (a -> Bool) -> Tree a -> Bool
forallNodes' p = tfold p (\n l r -> p n && l && r)

existsNode':: (a -> Bool) -> Tree a -> Bool
existsNode' p = tfold p (\n l r -> p n || l || r)

inorder':: Tree a -> [a]
inorder' = tfold (: []) (\n l r -> l ++ [n] ++ r)
-- Note: (: []) <===> (\x -> [x])
