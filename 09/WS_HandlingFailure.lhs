a) Die Funktion head :: [a] -> a wirft eine Exception falls Sie auf eine leere Liste angewendet wird. Das
Programm wird in Folge abgebrochen (ungünstig wenn Sie damit eine Rakete steuern). Viel robuster
wäre es im Typ klar zu sagen, dass ein Wert nicht vorhanden sein kann!
Implementieren Sie zum Aufwärmen die Listenfunktion safeHead.

safeHead :: [a] -> Maybe a

> safeHead :: [a] -> Maybe a 
> safeHead [] = Nothing
> safeHead (a:_) = Just a


b) Wenn Sie Aufgabe a) gelöst haben, sollte es ein leichtes Spiel sein jetzt die Funktion safeTail zu
implementieren:

safeTail :: [a] -> Maybe [a]

> safeTail :: [a] -> Maybe [a]
> safeTail [] = Nothing
> safeTail (_:as) = Just as

c) Die Listenfunktion maximum hat dasselbe Problem wie head und tail: Bei einer leeren Liste kann kein
grösstes Element zurückgeben werden. Implementieren Sie die Funktion safeMax rekursiv:

safeMax :: (Ord a) => [a] -> Maybe a

> safeMax :: (Ord a) => [a] -> Maybe a 
> safeMax [] = Nothing
> safeMax [a] = Just a
> safeMax (a:b:as) | a > b = safeMax (a:as)
>                  | otherwise = safeMax (b:as) 