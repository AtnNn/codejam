
data State = On | Off deriving (Eq, Show)

main = interact $ unlines . map (uncurry qra) . zip [1..] . map (map read . words) . drop 1 . lines

qra :: Int -> [Int] -> String
qra num [n, k] = "Case #" ++ show num ++ ": " ++ if (f n k) then "ON" else "OFF"

f n k = k `mod` 2^n == 2^n - 1

snap _ [] = []
snap True (On:xs) = Off : snap True xs
snap True (Off:xs) = On : xs
snap _ l = l