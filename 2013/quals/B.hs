import Data.List
import Debug.Trace

main = interact $ \input -> let
  lawns = readLawns $ tail $ lines input
  results = map status lawns
  in
   unlines $
   zipWith (\a b -> "Case #" ++ show a ++ ": " ++ if b then "YES" else "NO")
   [1..] results

readLawns :: [String] -> [[[Int]]]
readLawns [] = []
readLawns (size:rest) = let
  height = read $ head $ words size
  it = map (map read . words) $ take height rest
  in it : readLawns (drop height rest)

status lawn = go (map (foldr1 max) lawn) (map (foldr1 max) $ transpose lawn) lawn
  where
    go _ _ [] = True
    go (x:xs) ys (row : rest) =
      and (zipWith (\y r -> r == y || r == x) ys row)
      && go xs ys rest