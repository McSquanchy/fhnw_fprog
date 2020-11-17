module Main where

import System.Environment
import Network.HTTP

-- cabal repl
-- :main Arg1 Arg2
-- :set args Arg1 Arg2
-- cabal run webclient FirstName LastName
main :: IO ()

main = do
     [firstName, lastName] <- getArgs
     let url = buildURL firstName lastName
     response <- simpleHTTP (getRequest url)
     code <- getResponseCode response
     putStrLn $ show code
     content <- getResponseBody response
     putStrLn (content)

buildURL :: String -> String -> String
buildURL fn ln = "http://api.icndb.com/jokes/random?limitTo=%5Bnerdy%5D&firstName=" ++ fn ++ "&lastName=" ++ ln