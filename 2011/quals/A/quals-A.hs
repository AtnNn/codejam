
import Control.Monad
import Control.Monad.Reader

import Debug.Trace

main = interact $ unlines . output . map (solve . parse) . tail . lines

output = map (\(i,r) -> "Case #" ++ show i ++ ": " ++ show r) . zip [1..]

parse = liftM2 zip odds (map read . evens) . tail . words

odds (x:xs) = x : evens xs
odds [] = []

evens (_:xs) = odds xs
evens [] = []

solve = s "O" (0, 0, 1, 0, 1)

s :: String -> (Int, Int, Int, Int, Int) -> [(String, Int)] -> Int
s _ (t, timeO, posO, timeB, posB) [] = t

s id1 state@(t, hsO, posO, hsB, posB) ((id2, target) : xs) | id1 == id2 = 
--  trace (show $ (id1, (t', hsO', posO', hsB', posB'), target)) $
  s id1 (t', 0, target, hsB', posB) xs
    where t' = t + time
          hsO' = left
          posO' = target
          hsB' = hsB + time
          posB' = posB
          
          left = 0 -- abs $ min 0 $ distance - hsO
          time = max 1 $ distance - hsO
          distance = (+1) . abs $ posO - target

s id1 (t, timeO, posO, timeB, posB) l@((id2,_):_) = 
  s id2 (t, timeB, posB, timeO, posO) l 