-- Aufgabe 1
-- Implementieren Sie die Funktion maxl, die das grösste Element einer Liste findet.
-- Hinweis: Definieren Sie zuerst eine Funktion max' die zwei Argumente vergleicht und das
-- grössere Argument zurückgibt.

maxl :: (Ord a) => [a] -> a
maxl [] = error "no elements in list"
maxl [a] = a
maxl [a,b] = max' a b
maxl (a1:a2:as) = maxl ([(max' a1 a2)] ++ as)

max' :: Ord a => a -> a -> a
max' a b | a >= b = a 
         | otherwise = b

-- Evaluieren Sie schrittweise maxl [2,5,1]
-- maxl [2,5,1]
-- maxl [5,1] 
-- 5


-- Aufgabe 2
-- Implementieren Sie die Funktion, die eine Liste umkehrt.

reverse' :: [a] -> [a]
reverse' [] = []
reverse' [a] = [a]
reverse' (a:as) = reverse' as ++ [a]

-- Evaluieren Sie schrittweise reverse' [1,2,3]
-- reverse' [1,2,3]
-- reverse' [2,3] ++ [1] 
-- reverse' [3] ++ [2] ++ [1]
-- [3,2,1]


-- Aufgabe 3
-- Implementieren Sie die Funktion alternate. Sie nimmt zwei Listen und gibt eine Liste zurück die
-- abwechselnd von der ersten Liste und der zweiten Liste die Elemente enthält.
-- Hinweis: Überlegen Sie sich wie immer zuerst den Typ der gesuchten Funktion.

alternate :: [a] -> [a] -> [a]
alternate [] [] = []
alternate l [] = l
alternate [] l = l
alternate (a:as) (b:bs) = a:b:alternate as bs 

-- Aufgabe 4
-- Collatz Vermutung

collatzSequence :: Int -> [Int]
collatzSequence a | a < 1 = error "Value must be > 0"
                  | otherwise = collatzIter a where
                                collatzIter :: Int -> [Int]
                                collatzIter 1             = [1]
                                collatzIter n | even n    = n : collatzIter (n `div` 2)
                                              | otherwise = n : collatzIter (n*3+1)

collatzSequence' :: Int -> [Int]
collatzSequence' a | a < 1 = error "Value must be > 0"
                  | otherwise = takeWhile (/=1) (iterate f a) ++ [1]

f :: Int -> Int
f n | even n    = n `div` 2
    | otherwise = n*3+1