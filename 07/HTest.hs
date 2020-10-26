{- HTest - Tiny Haskell Testing Framework -}

-- a)
length' :: [a] -> Int
length' []     = 0
length' (_:as) = 1 + length' as


test1 :: Eq b => (a->b) -> [(a,b)] -> Bool
test1 f ios = and (map (\(a,b) -> (f a) == b) ios)
 
lengthTestData :: [([Int], Int)]
lengthTestData = 
  [([],    0),
   ([0],   1),
   ([0,1], 2)]

lengthTest :: Bool
lengthTest = test1 length' lengthTestData


-- b)
test2 :: Eq c => (a->[b]->[c]) -> [((a,[b]),[c])] -> Bool
test2 f ios = and (map (\((a,b), c) -> (f a b) == c) ios)

dropTestData :: [((Int, [Int]), [Int])]
dropTestData = 
  [((0, []),    []),
   ((1, []),    []),
   ((1, [0]),   []),
   ((1, [0,1]), [1])]

dropTest :: Bool
dropTest = test2 drop dropTestData

drop' :: Int -> [a] -> [a]
drop' _ [] = []
drop' a is | a <= 0 = is
drop' a (_:is) = drop' (a-1) is

take' :: Int -> [a] -> [a]
take' _ [] = []
take' a _ | a <= 0 = []
take' a (i:is) = i : take' (a-1) is

zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (i:is) (a:as) = (i,a) : zip' is as

elem' :: Eq a => a -> [a] -> Bool
elem' _ [] = False
elem' a (i:is) | a == i = True
                 | otherwise = elem' a is

eqList :: Eq a => [a] -> [a] -> Bool -- Vergleicht zwei Listen
eqList a b = a == b

(|>) :: (a->b) -> (b->c) -> (a -> c)
(|>) f g = \x -> g (f x)


-- Java Sheet

-- a)
getGrades :: [([Char], Double)] -> [Double]
getGrades = map snd

-- b)
squareList :: [Int] -> [Int]
squareList = map (^2)

-- c)
adultNames :: [([Char], Int)] -> [[Char]]
adultNames =  (map fst).(filter ((>=18).snd))