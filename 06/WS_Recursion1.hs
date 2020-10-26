countDown :: Int -> [Int]
countDown 0 = return 0
countDown n = n:countDown (n-1)

countUp :: Int -> [Int]
countUp 0 = return 0
countUp n = countUp(n-1) ++ [n]

countDownUp :: Int -> [Int]
countDownUp 0 = return 0
countDownUp n = n:countDownUp(n-1) ++ [n]