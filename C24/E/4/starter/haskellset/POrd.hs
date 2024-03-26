module POrd where

import Set

class POrd a where
  pcompare :: a -> a -> POrdering
  
  lt, gt, lte, gte, inc :: a -> a -> Bool
  lt x y = case pcompare x y of { PLT -> True; _ -> False }
  gt x y = case pcompare x y of { PGT -> True; _ -> False }
  lte x y = case pcompare x y of { PLT -> True; PEQ -> True; _ -> False }
  gte x y = case pcompare x y of { PGT -> True; PEQ -> True; _ -> False }
  inc x y = pcompare x y == PIN || pcompare y x == PIN