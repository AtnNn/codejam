module Main where

-- r1/A

import Ratio

main = interact $ unlines . output . map (solve . parse) . tail . lines

output = map (\(i,r) -> "Case #" ++ show i ++ ": " ++ if r then "Possible" else "Broken") . zip [1..]

parse = map read . words

solve [n, pd, pg] = not ( (pd > 0 && pg == 0) || (pd < 100 && pg == 100) )
                    && posPer pd n
                    
posPer p n = n >= 100 || any (pp p) [1..n]

pp p i = (p * i) `mod` 100 == 0

{-

d > 0 -- games today

g -- games total

g >= d

d < n





-}