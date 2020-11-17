module Main where

import System.Directory
import System.IO

import Data.Char (isSpace)

type Task = (Bool, String)
type TaskList = [Task]

taskFile = "db.txt"

main :: IO ()
main = do
    hSetBuffering stdin LineBuffering
    hSetBuffering stdout NoBuffering
    putStrLn "FProg Task List Manager"
    loop

loop = do
    putStr "> "
    line <- getLine
    if null line
        then loop
        else
            let (cmd,args) = splitCmd line
            in do dispatch cmd args
                  loop

splitCmd :: String -> (String, String)
splitCmd line = (cmd, dropWhile isSpace args)
    where (cmd, args) = break isSpace line

dispatch :: String -> String -> IO ()
dispatch "list" _  = listTasksAction taskFile
dispatch "add"  t  = addTaskAction taskFile t
dispatch "done" nr = markDoneAction taskFile (read nr)
dispatch _ _ = do 
    putStrLn "> Invalid command"

listTasksAction :: String -> IO ()
listTasksAction file = do
    tasks <- readTasks file
    let nrTasks = numberTasks tasks
    if (length nrTasks == 0) then do
        putStrLn "Nothing to do, relax!"
    else do
        putStr (unlines (map (\tuple -> show(fst tuple) ++ ". [" ++ (if (fst (snd tuple)) == True then "X] "  else " ] ") ++ (snd (snd tuple))) nrTasks))

addTaskAction :: String -> String -> IO ()
addTaskAction file t = do
    tasks <- readTasks file
    let mTasks = addTask t tasks
    writeTasks file mTasks
    putStrLn "> Successfully added task."

markDoneAction :: String -> Int -> IO ()
markDoneAction file nr = do
    tasks <- readTasks file
    if(nr < length tasks) then do
        let mTasks = markDone nr tasks
        putStrLn "> Modified task successfully."
        writeTasks file mTasks
    else do
        putStrLn ("> Invalid parameter!" ++ show(nr))


-- abc = do
--         args <- getArgs
--         if (head args) == "list" then list
--         else do
--             tasks <- readTasks taskFile
--             let nrTasks = numberTasks tasks
--             if (head args) == "add" then do
--                 let mTasks = addTask (head (tail args)) tasks
--                 writeTasks taskFile mTasks
--                 putStrLn "Successfully added task."
--             else if (head args) == "done" then do
--                 let t = read (head (tail args)) :: Int
--                 if(t < (length nrTasks)) then do
--                     let mTasks = markDone t tasks
--                     putStrLn "Modified task successfully."
--                     writeTasks taskFile mTasks
--                 else do
--                     putStrLn ("Invalid parameter: " ++  (head (tail args)))
--             else do
--                 putStrLn ("Invalid parameter: " ++ (head args))


-- list = do 
--         tasks <- readTasks taskFile
--         let nrTasks = numberTasks tasks
--         if (length nrTasks == 0) then do
--             putStrLn "Nothing to do, relax!"
--         else do
--         putStr (unlines (map (\tuple -> show(fst tuple) ++ ". [" ++ (if (fst (snd tuple)) == True then "X] "  else " ] ") ++ (snd (snd tuple))) nrTasks))
   


readTasks :: FilePath -> IO TaskList
readTasks file = do
                 exists <- doesFileExist file
                 if not exists then return []
                 else do
                     content <- readFile file
                     let tasks = if null content then [] else (read content)
                     return $! tasks

writeTasks :: FilePath -> TaskList -> IO ()
writeTasks fn tasks = writeFile fn (show tasks)

addTask :: String -> TaskList -> TaskList
addTask t list = list ++ [(False, t)]

numberTasks :: TaskList -> [(Int,Task)]
numberTasks tasks = zip [0..] tasks

markDone :: Int -> TaskList -> TaskList
markDone nr list = replace nr newTask list
            where newTask = (True, snd (head (drop nr list)))

replace :: Int -> a -> [a] -> [a]
replace index elem = map (\(index', elem') -> if index' == index then elem else elem') . zip [0..]