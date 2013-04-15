import Data.List
import Control.Monad
import Control.Monad.Reader
import Data.Bits
import Debug.Trace
import Data.Ratio

main = interact $ unlines . output . map (solve . parse) . evens . tail . lines

output = map (\(i,r) -> "Case #" ++ show i ++ ": " ++ show r) . zip [1..]

parse = map read . words

odds (x:xs) = x : evens xs
odds [] = []

evens (_:xs) = odds xs
evens [] = []

solve :: [Int] -> Double
solve l = ci $ length l - inOrder l

perms n = permutations [1..n]

test = (!!) tests

tests = map test [0..8]
  where test = map (\l -> (length l, head l)) . group . sort . map inOrder . perms

inOrder = length . filter id . map (uncurry (==)) . zip [1..]

bang n = product [1..n]

calc n = sum $ map c $ test n
  where c (nb, x) = (nb % bang n) * (x % 1)

ci :: Int -> Double
ci = fromInteger . toInteger

try :: Int -> Int -> Int -> Double
try 0 step _ = ci step
try _ step limit | limit == step = ci step
try n step limit = 
  let t = test n
      l = limit - 1
      f (nb, x) = try (n - x) (step + 1) l * (ci nb) / (ci $ bang n)
  in  sum $ map f t