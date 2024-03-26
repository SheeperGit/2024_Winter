module SetPOrd where

import Set
import POrd
import SetEq


instance (Ord a) => POrd (Set a) where
  pcompare (Set s1) (Set s2)
    | s1 `subset` s2 && s2 `subset` s1 = PEQ
    | s1 `subset` s2 = PLT
    | s2 `subset` s1 = PGT
    | otherwise = PIN