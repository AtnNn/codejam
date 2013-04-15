{-# LANGUAGE NoMonomorphismRestriction #-}
import Control.Monad
import Control.Monad.Reader

import Data.Char
import Data.List
import Debug.Trace
import qualified Data.IntMap as M

main = interact $ unlines . output . map (solve . parse) . tail . lines

output = map (\(i,r) -> "Case #" ++ show i ++ ": " ++ display r) . zip [1..]

display l = "[" ++ (concat $ intersperse ", " $ map return l) ++ "]"

parse = parse1 . words

parse1 (n:xs) =
  (M.fromList $ map ((\([a,b,c]) -> (pair a b, c))) $ take (read n) xs,
   parse2 $ drop (read n) xs)
  
parse2 (n:xs) =   
  (M.fromList $ map ((\([a,b]) -> (pair a b, ()))) $ take (read n) xs,
   parse3 $ drop (read n) xs)

parse3 = head . tail

pair a b = ord a' + (256 * ord b')
  where a' = max a b
        b' = min a b

maybeHead [] = Nothing
maybeHead (x:_) = Just x

maybeToBool Nothing = False
maybeToBool _ = True

solve :: (M.IntMap Char, (M.IntMap (), String)) -> String
solve (com, (opp, l)) = reverse $ foldl effect [] l
  where effect l next = 
            case maybeHead l >>= (flip M.lookup com . pair next) of
              Just x -> x : tail l
              Nothing -> if any (maybeToBool . flip M.lookup opp . pair next) l
                         then []
                         else next : l