keep :: (a -> Bool) -> [a] -> [a]
keep _ [] = []
keep p (a:as) | (p a) = a : keep p as
              | otherwise = keep p as

evens :: [Int] -> [Int]
evens [] = []
evens as = keep even as

data Student = Student { email :: String, grade :: Float }
goodS :: [Student] -> [Student]
goodS [] = []
goodS as = keep (\s -> (grade s) > 5) as