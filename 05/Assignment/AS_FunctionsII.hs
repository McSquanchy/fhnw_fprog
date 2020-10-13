-- Aufgabe 1

a1_1 = (((1 + (2 ^ 3)) == 6) && ((3 / 4) < 12)) || (snd (1, True))
a2_2 = ((3:) []) == ((map (*5)) [(2 ^ (4 ^ 6))])

curry' :: ((a,b) -> c) -> a -> b -> c
curry' f = \a b -> f (a,b)

uncurry' :: (a -> b -> c) -> ((a,b) -> c)
uncurry' f = \(a,b) -> f a b

add :: (Int, Int) -> Int
add (x,y) = x + y

flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = \a -> \b -> f b a
