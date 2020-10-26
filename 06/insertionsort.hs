isort :: Ord a => [a] -> [a]
isort [] = []
isort (a:as) = insert a (isort as)

insert :: Ord a => a -> [a] -> [a]
insert a [] = [a]
insert a (b:bs) | a <= b = a:b:bs
                | otherwise = b: insert a bs