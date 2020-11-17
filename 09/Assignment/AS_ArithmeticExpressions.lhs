> import Control.Applicative hiding (Const, many)
> import Data.Char
> import Data.List

Übung 09: Rekursive Datentypen

In dieser Übung arbeiten Sie mit einfachen arithmetischen Ausdrücken.

Beispiele: "1+2*3" oder "(1+2)*(4+2)"

Ein Ausdruck kommt in den folgenden Formen:
- Konstante, z.B. 12       Repräsentation: Const 12
- Addition, e1 + e2        Repräsentation: Add e1 e2
- Multiplikation, e1 * e2  Repräsentation: Mul e1 e2
wobei e1 und e2 wieder arithmetische Ausdrücke sind.

> data Expr = Const Int
>           | Add Expr Expr
>           | Mul Expr Expr
>           deriving (Show, Eq)

Der Ausdruck "(1+2)*3" wird entsprechend so dargestellt:

> ex1 = Mul (Add (Const 1) (Const 2)) (Const 3)

Die Struktur wird deutlicher, wenn wir den Ausdruck mit infix Konstruktoren schreiben:

> ex2 = ((Const 1) `Add` (Const 2)) `Mul` (Const 3)

Denken Sie sich das `Add` als '+' und das `Mul` als '*'.

Den obigen Ausdruck können Sie sich auch als ein verkehrt herum stehenden Baum vorstellen.

       *
      / \
     +   3
    / \
   1   2

Eine solche Struktur nennt man Baum, weil sie mit einem einzelnen Element an der Wurzel
startet '*' und von da weitere Teile wie Äste davon abzweigen.

Aufgabe 1)
Zeichnen Sie den Baum und konstruieren Sie den Wert vom Typ Expr in Haskell für folgenden
Ausdruck: "(3*4)+(5+2)"

> a1 = Add (Mul (Const 3) (Const 4)) (Add (Const 5) (Const 2))

        +
      /   \
     *     +
    / \   / \
   3   4 5   2

Aufgabe 2)
Einen solchen arithmetischen Ausdruck kann man nun ausrechnen (evaluieren).
Implementieren Sie die Funktion eval. Als Argument nimmt sie einen arithmetischen Ausdruck
und berechnet dessen Wert.

Beispiel:
1 + 2 = 3
eval (Add (Const 1) (Const 2)) ~> 3

> eval :: Expr -> Int
> eval (Const a) = a
> eval (Add a b) = (eval a) + (eval b)
> eval (Mul a b) = (eval a) * (eval b)

Hinweis:
Es handelt sich um eine rekursive Funktion. Überlegen Sie sich den Basisfall. Für welche
Expr ist der Wert sofort klar? Bei den anderen beiden Fällen, müssen Sie sich überlegen
wie man zum Resultat kommt, wenn die beiden Teilresultate schon evaluiert wurden:

Aufgabe 3)
Schreiben Sie mindestens drei Unit Tests um die eval Funktion zu testen.

eval ex1
eval a1
eval (Mul (Mul (Add (Const 5) (Const 7)) (Const 8)) (Mul (Add (Mul (Const 5) (Const 3)) (Add (Const 3) (Const 2))) (Add (Const 2) (Const 3))))

Aufgabe 4)
Die Addition und die Multiplikation haben Eigenschaften, die es erlauben Ausdrücke
zu vereinfachen:

Wenn Sie eine Addition ausführen und die Konstante 0 auf einer Seite haben, können Sie die
Addition und die Konstante 0 entfernen, weil sie keinen Effekt haben:
0 + e == e + 0 == e

Beispiel:
Add (Const 0) (Const 1) kann vereinfacht werden nach (Const 1)

Überlegen Sie sich zwei weitere Vereinfachungsregeln für die Multiplikation.
Hinweis: Es geht um die Konstanten 0 und 1.

Implementieren Sie die Funktion simpl. Sie nimmt einen Ausdruck und gibt einen vereinfachten
Ausdruck zurück. Die Vereinfachung darf dabei den Wert des repräsentieren Ausdrucks nicht
verändern:
eval e == eval (simpl e)

% > simpl :: Expr -> Expr
% > simpl (Add a (Const 0)) = simpl a
% > simpl (Add (Const 0) b) = simpl b
% > simpl (Add a b) = (Add (simpl a) (simpl b))
% > simpl (Mul a (Const 1)) = simpl a
% > simpl (Mul (Const 1) b) = simpl b
% > simpl (Mul _ (Const 0)) = (Const 0)
% > simpl (Mul (Const 0) _) = (Const 0)
% > simpl (Mul a b) = (Mul (simpl a) (simpl b))
% > simpl e = e

Problem: Abstieg wird gehandelt -> Aufstieg aber nicht

Version 2:

> simpl :: Expr -> Expr
> simpl ex = simplD ex
>      where 
> simplD (Add l r)          = simplU (Add (simplD l) (simplD r))
> simplD (Mul l r)          = simplU (Mul (simplD l) (simplD r))
> simplD e = e
> simplU (Add a (Const 0)) = a
> simplU (Add (Const 0) b) = b
> simplU (Mul a (Const 1)) = a
> simplU (Mul (Const 1) b) = b
> simplU (Mul _ (Const 0)) = (Const 0)
> simplU (Mul (Const 0) _) = (Const 0)
> simplU e = e


Aufgabe 5)
Schreiben Sie wiederum einige Unit Tests um die simpl Funktion zu überprüfen.

simpl (Add (Const 5) (Const 0))
simpl (Mul (Const 8132543) (Const 0))
simpl (Mul (Const 12351) (Const 1))

== Zahltag ==
Weil Sie so fleissig waren und sich bis hier unten durchgearbeitet haben, haben wir
eine kleine Belohnung. Unten im File hat es einen Parser, der automatisch simple
arithmetische Ausdrücke in Expr Werte übersetzt.
Der Parser nimmt also einen String und erzeugt daraus eine Struktur vom Typ Expr.

> ex3 = parseExpr "(1+2)*3"  -- Mul (Add (Const 1) (Const 2)) (Const 3)

Sie haben nun selbst Funktionen geschrieben um solche Strukturen zu vereinfachen
und um sie zu evaluieren.
Das Ganze ist viel mehr als nur ein kleiner Taschenrechner. Es beinhaltet nämlich
die zentralen Elemente zur Implementierung einer interpretierten Programmiersprache:
Sourcecode -parsen-> Struktur -vereinfachen-> Struktur -ausführen-> Resultat

Wenn wir nun noch den Pipe Operator wie folgt zur Verfügung haben

> (|>) :: (a -> b) -> (b -> c) -> a -> c
> f |> g = g.f

können wir folgende, an Eleganz kaum zu übertreffende, Definition hinschreiben:

> runExample = (parseExpr |> simpl |> eval) "(5+0)*8+2"

Hallelujah!

Der folgende Code implementiert generische Infrastruktur um Parser zu definieren.
Basieren darauf haben wir einen Parser für simple arithmetische Ausdrücke implementiert.

> data Parser a = Parser { run :: (String -> [(a, String)]) }
>
> parse p s = case find (\(_,r) -> null r) (run p s) of
>                  Nothing -> error "Illegal"
>                  Just (x,_) -> x
>
> item :: Parser Char
> item = Parser (\cs' -> case cs' of
>                     []     -> []
>                     (c:cs) -> [(c,cs)])
>
> instance Functor Parser where
>   fmap f p = Parser (\cs -> map (\(a,cs') -> (f a, cs')) (run p cs))
>
> instance Applicative Parser where
>   pure a = Parser (\cs -> [(a,cs)])
>   mf <*> ma = mf >>= \f -> ma >>= \a -> pure (f a)
>
> instance Monad Parser where
>   return = pure
>   p >>= f = Parser (\cs -> concat (map (\(a,cs') -> run (f a) cs') (run p cs)))
>
> instance Alternative Parser where
>    empty = Parser (\_ -> [])
>    p <|> q = Parser (\cs -> run p cs ++ run q cs)
>
>
> (+++) :: Parser a -> Parser a -> Parser a
> p +++ q = Parser (\cs -> case run (p <|> q) cs of
>                            [] -> []
>                            (x:xs) -> [x])
>
> sat :: (Char -> Bool) -> Parser Char
> sat p = do c <- item
>            if p c then return c else empty
>
> char :: Char -> Parser Char
> char c = sat (c ==)
>
> many :: Parser a -> Parser [a]
> many p = many1 p +++ return []
>
> many1 :: Parser a -> Parser [a]
> many1 p = do a <- p
>              as <- many p
>              return (a:as)
>
> token :: Parser a -> Parser a
> token p = do
>   space
>   v <- p
>   space
>   return v
>
> space = many (sat isSpace)
>
> symbol c = token (char c)


Semiformale Grammatik für simple arithmetische Ausdrücke:

expr ::= term
       | term + expr

term ::= factor
       | factor * term

factor ::= constant
         | '(' expr ')'

constant :: = (0..9)+


> parseExpr = parse expr
>
> expr  = do t <- term
>            symbol '+'
>            e <- expr
>            return (Add t e)
>         +++ term
>
> term  = do f <- factor
>            symbol '*'
>            t <- term
>            return (Mul f t)
>         +++ factor
>
> factor = constant
>          +++
>          do symbol '('
>             e <- expr
>             symbol ')'
>             return e
>
> constant = do ds <- many1 digit
>               let ints = map digitToInt ds
>               let val = foldl (\acc d -> acc * 10 + d) 0  ints
>               return (Const val)
>
> digit = sat isDigit
>