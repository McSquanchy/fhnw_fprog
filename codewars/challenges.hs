{- challenges - codewars challenges implemented in haskell -}

import qualified Data.Set as Set
import Data.Char

import Data.Ord          ( comparing )
import Data.List.Ordered ( isSorted, nub )
import Data.List         ( maximumBy, subsequences )

-- Split Strings (6 kyu)
--
-- Complete the solution so that it splits the string into pairs of two characters. If the string contains an odd number of characters then it should replace the missing second character of the final pair with an underscore ('_').
--
-- Examples: 
--
--      solution "abc" `shouldBe` ["ab", "c_"]
--      solution "abcdef" `shouldBe` ["ab", "cd", "ef"]

solution :: String -> [String]
solution [] = []
solution [a] = [a : "_"]
solution (a:b:t) = [a,b] : solution t


-- Find the missing letter (6 kyu)

-- Write a method that takes an array of consecutive (increasing) letters as input and that returns the missing letter in the array.
-- 
-- You will always get an valid array. And it will be always exactly one letter be missing. The length of the array will always be at least 2.
-- The array will always contain letters in only one case.
-- 
-- Example:
-- 
--      ['a','b','c','d','f'] -> 'e' 
--      ['O','Q','R','S'] -> 'P'

findMissingLetter :: [Char] -> Char
findMissingLetter (a:bs) | (Prelude.fromEnum (head bs) - Prelude.fromEnum a) /= 1 = Prelude.toEnum ((Prelude.fromEnum(head bs)) -1)
                           | otherwise = findMissingLetter bs



lcs :: String -> String -> String
lcs [] (_:_) = []
lcs (_:_) [] = []
lcs (x:xs) ys = case elemIndex x ys of Nothing -> lcs xs ys
                                       Just n -> x : lcs xs (drop n ys)
                                    

test :: String -> String -> [[Int]]
test [] [] = []
test _  [] = []
-- test xs ys = map (\i -> xs!!i) (concat (map (\l -> [minimum l]) (test' (filter (not . null) (map (\el -> elemIndices el xs) ys)))))
test xs ys = map (\el -> elemIndices el xs) ys

test' :: [[Int]] -> [[Int]]
test' [] = []
test' (a:as) =  a : test' (compound (head a) as)

compound :: Int -> [[Int]] -> [[Int]]
compound a list = (map ((filter (\el -> el > a))) list)

lis :: Ord a => [a] -> [a]
lis = maximumBy (comparing length) . map nub  . filter isSorted . subsequences     