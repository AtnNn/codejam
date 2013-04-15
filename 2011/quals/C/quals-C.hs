import Data.List
import Control.Monad
import Control.Monad.Reader
import Data.Bits
import Debug.Trace

main = interact $ unlines . output . map (solve . parse) . evens . tail . lines

output = map (\(i,r) -> "Case #" ++ show i ++ ": " ++ r) . zip [1..]

parse = map read . words

odds (x:xs) = x : evens xs
odds [] = []

evens (_:xs) = odds xs
evens [] = []

solve :: [Int] -> String
solve l = -- show l ++ (show $ (head $ sort l) ==  (foldl' xor 0 $ tail $ sort l)) ++
  case foldl' xor 0 l of
    0 -> show $ sum $ tail $ sort l
    _ -> "NO"