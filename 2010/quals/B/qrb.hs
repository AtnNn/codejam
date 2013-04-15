module Main where

import Primes
import List
import Debug.Trace

greatevents = [2600, 11000, 6000]

main = interact $ unlines . map (uncurry qrb) . zip [1..] . map (map read . tail. words) . tail . lines

qrb num l = "Case #" ++ show num ++ ": " ++ show (g l)
  where max = maximum l

f num exp (p:ps) l = if allSame $ map (`mod` (p ^ exp)) l then
                       f num (exp + 1) (p : ps) l
                     else
                       f (num * p^(exp - 1)) 1 ps l
f num _ [] _ = num

g :: [Integer] -> Integer
g l = if r == 1 then 0 else r
  where s = sort l
        m = foldl1 gcd $ zipWith (-) (tail s) (init s)
        r = trace (let rs = map (`mod` m) l in show l ++ show rs) m - (head l `mod` m)

allSame (x:xs) = allSame' x xs
allSame' a (x:xs)| a == x = allSame' x xs
allSame' _ [] = True
allSame' _ _ = False