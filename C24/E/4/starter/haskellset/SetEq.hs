module SetEq where

import Set

instance (Eq a) => Eq (Set a) where
    (Set s1) == (Set s2) = subset s1 s2 && subset s2 s1