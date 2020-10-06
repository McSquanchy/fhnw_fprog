{-# OPTIONS_GHC -Wall #-}

switchFirstTwo :: [a] -> [a]
switchFirstTwo (x:y:zs) = y:x:zs
switchFirstTwo as = as

type Vec= (Int, Int)

addVec :: Vec -> Vec -> Vec
addVec (ax,ay) (bx,by) = (ax+bx, ay+by)

addOpt :: Int -> Int -> Int
addOpt 0 a = a
addOpt a 0 = a
addOpt a b = a + b

addVecOpt :: Vec -> Vec -> Vec
addVecOpt (ax,ay) (bx,by) = (addOpt ax bx, addOpt ay by)

max1 :: Int -> Int -> Int
max1 x y | x > y = x 
         | otherwise = y

max2 :: Int -> Int -> Int 
max2 x y = if x > y then x else y

max3 :: Int -> Int -> Int 
max3 a b = case a > b of
            True -> a 
            False -> b
