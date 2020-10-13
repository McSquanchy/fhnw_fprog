incAll :: [Int] -> [Int]
incAll is = map (\i -> i+1) is

addToAll :: Int -> [Int] -> [Int]
addToAll amt is  = map (\i -> i+amt) is

keepOld :: [Int] -> [Int]
keepOld is = filter (\i -> i >= 90) is

dropShort :: [String] -> [String]
dropShort ss = filter (\s -> length s /= 1) ss