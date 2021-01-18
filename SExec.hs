{-@ LIQUID "--reflection" @-}
{-@ LIQUID "--ple"        @-}
{- LIQUID "--no-totality"        @-}

module SExec where

import Memory
import qualified Data.Set as S 

type Acc = Int 
type Reg = Int 
type Config = (Acc, Mem Reg) 

data Code 
  = Load Int Code 
  | Store Reg Code 
  | Add   Reg Code 
  | Free  Reg Code 
  | Halt 

{-@ exec :: c:Code -> (a::Acc, {m:Mem Int | validMem m c a}) -> Config @-}
exec :: Code -> Config -> Config
exec (Load n c) (a,m)  = exec c (n,m)  
exec (Store r c) (a,m) = exec c (a,set r a m) 
exec (Add r c)   (a,m) = exec c (a `add` get r m ,m) 
exec (Free r c)  (a,m) = exec c (a, unset r m)
exec Halt        (a,m) = (a,m) 


{-@ reflect validMem @-}
validMem :: Mem Int -> Code -> Acc -> Bool 
validMem m (Add r c) a = if S.member r (memAddrs m) then validMem m c (a `add` get r m) else False
validMem m (Load n c) a = validMem m c n
validMem m (Store r c) a = validMem (set r a m) c a  
validMem m (Free r c) a  = validMem (unset r m) c a  
validMem m _ a = True 


{-@ type ValidCode = {c:Code | validMem MEmp c 0 } @-}
{-@ code :: ValidCode  @-} 
code :: Code 
code =  Store 0 (Load 42 (Store 42 ( Add 42 Halt)))

runExample :: Config 
runExample = exec code (0,MEmp)



{-@ reflect add @-}
add :: Int -> Int -> Int 
add = (+)


