module Main where

import Data.List

import Control.Monad
import Control.Arrow
import Data.Char
import Data.Maybe

-- r1/C

main = interact $ unlines . output . map solve . parse . tail . lines

output = map (\(i,r) -> "Case #" ++ show i ++ ": " ++ show r) . zip [1..]

parse [] = []
parse (x:xs) = case map read $ words x of [n] -> p2 n xs
                                          
p2 n xs = (map (map read . words) $ take n xs, fst o) : snd o
  where o = p3 (drop (n) xs)
        
p3 (x:xs) = case map read $ words x of [n] -> (map (map read . words) $ take n xs, parse (drop n xs))

solve :: ([[Int]],[[Int]]) -> Int
solve (hand, pile) = undefined calc pile

calc [] = []
calc (x:xs) = map (makeBest x) $ calc xs

makeBest [cc, sc, tc] best = \c t ->
  max (best (c - 1) t) $
  sc + best (c + cc - 1) (t + tc - 1)
  
empty _ _ = 0

instance (Enum a, Enum b) => Enum (a,b) where
  enumFromTo (a,b) (c,d) = [(x,y) | x <- [a..c], y <- [b..d]]