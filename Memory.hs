module Memory where

import qualified Data.Set as S

data Mem v = MEmp | MCons Int v (Mem v)

{-@

data Mem v =
    MEmp
  | MCons { addr :: Int, val :: v,  mem :: { m : Mem v | S.intersection (memAddrs m) (S.singleton addr) == S.empty } }

@-}

{-@ measure memAddrs @-}
memAddrs :: Mem v -> S.Set Int
memAddrs MEmp                 = S.empty
memAddrs (MCons addr val mem) = S.union (S.singleton addr) (memAddrs mem)

{-@ get :: addr : Int -> { mem : Mem v | S.member addr (memAddrs mem) } -> v @-}
get :: Int -> Mem v -> v
get addr (MCons addr' val' mem)
  | addr == addr' = val'
  | otherwise     = get addr mem
get _ _ = error "impossible"

{-@ set :: addr : Int -> v -> mem : Mem v
   -> { r : Mem v | memAddrs r == S.union (S.singleton addr) (memAddrs mem) } @-}
set :: Int -> v -> Mem v -> Mem v
set addr val MEmp = MCons addr val MEmp
set addr val (MCons addr' val' mem)
  | addr == addr' = MCons addr val mem
  | otherwise     = MCons addr' val' (set addr val mem)

{-@ unset :: addr : Int -> mem : Mem v
  -> { r : Mem v | memAddrs r == S.difference (memAddrs mem) (S.singleton addr) } @-}
unset :: Int -> Mem v -> Mem v
unset addr MEmp = MEmp
unset addr (MCons addr' val' mem)
  | addr == addr' = mem
  | otherwise     = MCons addr' val' (unset addr mem)