transform :: [a] -> (a -> b) -> [b]
transform [] _  = []
transform (a:as) fn = (fn a) : transform as fn

squares :: [Int] -> [Int]
squares []  = []
squares as = transform as (\i -> i^2)

data Student = Student { email :: String, grade :: Float }
emails :: [Student] -> [String]
emails [] = []
emails ss = transform ss (\s -> email s)