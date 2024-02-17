module Lab5 where
import Text.XHtml (base)

-- define life 42
life :: Int
life = 42

-- define life' (+ 42 24)
life' :: Int
life' = 42 + 24

-- define (implies a b) (if a b True)
implies :: Bool -> Bool -> Bool
implies a b = not a || b    -- Or could do: if a then b else True, but Haskell complains at this redundant `if`.

-- define (greet x) (string-append "hello, " x)
-- greet :: String -> String
greet x = "hello, " ++ x

-- define a function repeatTwice that repeats each element in the given list twice
repeatTwice x = concatMap(\x -> [x, x]) x

-- let's look at a better way! (listen to your TA!)
-- now let's use pattern matching to produce a much better solution
-- call it repeatTwice'
repeatTwice' [] = [] -- Base Case: Empty list
repeatTwice' (x:xs) = x : x : repeatTwice xs -- Recursive Case: Repeat the head (using Haskell equivalent of cons === :) and apply to rest of the list (tail).


-- define len (length of list) using pattern matching
len [] = 0
len (x:xs) = 1 + len xs

-- define firsts that takes a list of pairs and returns a list of its first elements
-- use pattern mathing
firsts [] = []
firsts ((x, _):xs) = x : firsts xs

-- define rev which returns the reverse of the input list
-- use pattern matching
rev [] = []
rev (x:xs) = rev xs ++ [x]  -- Note: `++` === concat, `:` === cons (list creation?)

-- now define a tail-recursive linear-time version of rev called rev'
-- you can use "let" or "where": look them up! https://wiki.haskell.org/Let_vs._Where
rev' xs = reverse' xs []
  where
    reverse' :: [a] -> [a] -> [a]
    reverse' [] acc = acc
    reverse' (x:xs) acc = reverse' xs (x:acc)


-- you don't need to fully understand these, we will cover this in class.
greet :: [Char] -> [Char]
repeatTwice :: [a] -> [a]
repeatTwice' :: [a] -> [a]
len :: [a] -> Int
firsts :: [(a,b)] -> [a]
rev :: [a] -> [a]
rev' :: [a] -> [a]

main = do
  print "Lab 5"
  print $ greet "Anya"
  print $ repeatTwice' "cscc24"
