module Main where

import Debug.Trace
import Array

main = interact $ unlines . map (\(a,b) -> ("Case #" ++ show a ++ ": " ++ show b)) . zip [1..] . map f . map read . tail . lines

--main = print cache

f n = (sum $ map (kcache  n) [1 .. n-1]) `mod` lim

k _ 0 = 0
k 0 _ = 0
k _ 1 = 1
k n c | n <= c = 0
k n c = (sum $ map g [maxi .. c-1]) `mod` lim
  where g i = (kcache c i) * choose mx (c-i-1)
        mx = n - c - 1
        maxi = max 1 $ 2 * c - n
        
        
fact 0 = 1
fact x = product [1 .. x] `mod` lim

choose n k = (fact n) `div` ((fact k)*(fact (n-k)))

lim = 100003

kcache n c = (cache ! n) ! c

cache = listArray (0, 500) $ map (\n -> listArray (0, 500) $ map (\i -> k n i) [0 .. 500]) [0 .. 500]