
main = interact $ unlines . go 1 . map read . tail . words

go :: Int -> [Int] -> [String]
go num (r:k:n:xs) = qrc num r k (take n xs) : go (num+1) (drop n xs)
go _ [] = []

qrc n r k l = "Case #" ++ show n ++ ": " ++ show (f r k l 0)

f 0 _ _ a = a
f r k l a = f (r-1) k (wait ++ go) (a + sum go)
  where (go, wait) = upto k l
        
upto k (x:xs) | x <= k = (x : go, wait)
  where (go, wait) = upto (k-x) xs
upto _ l = ([], l)
