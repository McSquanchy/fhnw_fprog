{- Arbeitsblatt: Recursion II -}

{-
Gesucht sind jeweils eigene rekursive Definitionen, ohne die Verwendung 
von Standardfunktionen.

Falls Sie die Aufgaben einfach finden, implementieren Sie die folgenden 
Funktionen komplett, d.h. überprüfen Sie auch die übergebenen Parameter 
ob sie überhaupt sinnvoll sind. Sie können mit error „eine Fehlermeldung“ 
eine Meldung auf der Konsole ausgeben und das Programm abbrechen.
-}


-- Aufgabe 1
-- Implementieren Sie eine Funktion welche die Länge einer Liste bestimmt:

len :: [a] -> Int
len a = len' 0 a
    where len' acc []   = acc
          len' acc b    = len' (acc+1) (tail b)

-- Aufgabe 2
-- Implementieren Sie eine Funktion, welche überprüft ob in einer Liste von 
-- Bool alle Werte True sind.
-- Hinweis: allTrue [] soll auf True evaluieren.

allTrue :: [Bool] -> Bool
allTrue [] = True
allTrue (i:is) = case i of True -> allTrue is
                           False -> False


-- Aufgabe 3
-- Implementieren Sie eine Funktion, welche aus einer List eine Teilliste extrahiert, 
-- indem dessen Startposition und Länge gegeben ist.

sublist :: Int -> Int -> [a] -> [a]
sublist _ 0 _       = []
sublist 0 b (i:is)  = i: sublist 0 (b-1) is
sublist a b (_:is)  = sublist (a-1) b is
sublist _ _ []      = error "need more elements"

sublist' :: Int -> Int -> [a] -> [a]
sublist' s l as = take l(drop s as)

-- Beispiel: sublist 3 7 "Hello World" == "lo Worl"


-- Aufgabe 4 
-- Implementieren Sie eine Funktion, welche eine Liste an eine andere Liste anhängt:

(+++) :: [a] -> [a] -> [a]
(+++) a l = l ++ a

(++++) :: [a] -> [a] -> [a]
[] ++++ bs = bs
(a:as) ++++ bs = a : (as ++++ bs)