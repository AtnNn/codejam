module Main where

import Data.List

import Control.Monad
import Control.Arrow
import Data.Char
import Data.Maybe

-- r1/B

main = interact $ unlines . output . map solve . parse . tail . lines

output = map (\(i,r) -> "Case #" ++ show i ++ ": " ++ unwords r) . zip [1..]

parse [] = []
parse (x:xs) = case map read $ words x of [n,m] -> p2 n m xs
                                          
p2 n m xs = (take n xs, take m $ drop n $ xs) : parse (drop (n+m) xs)

solve (ds, ls) = map (s2 ds) ls

s2 ds = walkTree (makeTree ds)

walkTree = undefined

id a = ord a - ord 'a'

data Tree = Tree String [(Char, Tree)]

makeTree :: [String] -> [Tree]
makeTree ds = map (\n -> mt ['a'..'z'] $ return $
                         (,) (map (const ' ') [1..n]) $
                         filter ((==n) . length) ds) [1..]

mt :: String -> [(String, [String])] -> Tree
mt _ [] = Tree []
mt left list = Tree (head $ snd list) $ map (\x -> (x, mt (delete x left) (add x list))) left

add x [] = []
add x ((try, words):rest) = go x try words : add x rest

go :: Char -> String -> String -> [(String, [String])]
go x try words = map (\x -> (fst (head x), map snd x)) 
                 groupBy (\x y -> fst x == fst y) $ sort $ catMaybes $ map (guess try x) $
                 filter (any (== x)) words
                 
guess [] _ _ = ([],[])
guess (' ':ts) x (w:ws) | w == x = first (x :) . second (w :) $ guess ts x ws
guess (t:ts) x (w:ws) = first (t :) . second (w :) $ guess ts x ws

maximum' = foldl' max 0