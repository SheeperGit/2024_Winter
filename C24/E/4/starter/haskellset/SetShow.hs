module SetShow where

import Set
import Distribution.Simple.Utils (xargs)

instance (Show a) => Show (Set a) where
    show (Set []) = "{}"
    show (Set [x]) = "{" ++ show x ++ "}"
    show (Set (x:xs)) = "{" ++ showElem x xs ++ "}"
      where
        showElem :: Show a => a -> [a] -> String
        showElem e [] = show e
        showElem e (y:ys) = show e ++ "," ++ showElem y ys