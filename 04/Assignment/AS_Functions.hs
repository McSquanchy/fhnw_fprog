compare1 :: (Ord a) => a -> a -> Ordering
compare1 x y = if x < y
    then LT 
    else  if x == y 
        then EQ 
        else GT

compare2 :: (Ord a) => a -> a -> Ordering
compare2 x y
    | x > y = GT
    | x < y = LT
    | otherwise = EQ

compare3 :: (Ord a) => a -> a -> Ordering
compare3 x y = case x > y of 
    True -> GT
    False -> case x == y of
        True -> EQ
        False -> LT

test_matching :: Int -> Int -> Int
test_matching x 0 = x
test_matching 0 y = y
test_matching 1 y = 1 + y
test_matching 1 y = y


type M22 = ((Int, Int), (Int, Int))

add :: M22 -> M22 -> M22 -- Addiert zwei Matrizen
add ((a11,a12), (a21,a22)) ((b11,b12), (b21,b22)) = ((a11+b11, a12+b12), (a21+b21, a22+b22))

sub :: M22 -> M22 -> M22 -- Subtrahiert die zweite Matrix von der ersten
sub ((a11,a12), (a21,a22)) ((b11,b12), (b21,b22)) = ((a11-b11, a12-b12), (a21-b21, a22-b22))

mulS :: M22 -> Int -> M22 -- Multipliziert eine Matrix mit einem Skalar
mulS ((a11,a12),(a21,a22)) b11 = ((b11*a11, b11*a12), (b11*a21, b11*a22)) 

mul :: M22 -> M22 -> M22 -- Multipliziert zwei Matrizen
mul ((a11,a12), (a21,a22)) ((b11,b12), (b21,b22)) = ((a11*b11+a12*b21 , a11*b12+a12*b22), (a21*b11+a22*b21, a21*b12+a22*b22))