module Lists where

{-@ i42 :: { i : Int | i == 42 } @-}
i42 :: Int
i42 = 42

{-@ measure size @-}
{-@ size :: [a] -> Nat @-}
size :: [a] -> Int
size [] = 0
size (x : xs) = 1 + size xs

-- [] :: { r : [a] | size r == 0 }
-- (:) :: a -> xs : [a] -> { r : [a] | size r == 1 + size xs }

{-@ (!!!) :: xs : [a] -> { i : Nat | i < size xs } -> a @-}
(!!!) :: [a] -> Int -> a
(x : xs) !!! 0 = x
(x : xs) !!! i = xs !!! (i - 1)
_ !!! _ = error "impossible"

-- error :: { s : String | false } -> a

-- We will add contents to this module during the tutorial.
