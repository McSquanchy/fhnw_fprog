aggregate :: (a -> a -> a) -> a -> [a] -> a
aggregate _ base [] = base
aggregate op base (x:xs) = op x (aggregate op base xs)

sum' :: Num a => [a] -> a
sum' = aggregate (+) 0

product' :: Num a => [a] -> a
product' = aggregate (*) 1 

or' :: [Bool] -> Bool
or' = aggregate (||) False

and' :: [Bool] -> Bool
and' = aggregate (&&) True