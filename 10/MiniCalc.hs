main = do
        putStrLn "Welcome to Minicalc!"
        forever loop

loop = do
        putStrLn "Please enter a first number:"
        num1 <- getLine
        let number1 = (read num1) :: Int
        putStrLn "Please enter a second number:"
        num2 <- getLine
        putStrLn "Please specify operation:"
        op <- getLine
        let operator = readOp op
        let number2 = (read num2) :: Int
        putStrLn (num1 ++ " " ++ op ++ " " ++ num2 ++ " = " ++ (show (operator number1 number2)))


readOp :: String -> (Int -> Int -> Int)
readOp "+" = (+)
readOp "-" = (-)
readOp "*" = (*)
readOp "^" = (^)

forever a = do a 
               forever a