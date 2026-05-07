module SectionII.Task2Solution
  ( splitIncreasingRuns
  ) where

splitIncreasingRuns :: [Int] -> [[Int]]
splitIncreasingRuns = foldr splitStep []

splitStep :: Int -> [[Int]] -> [[Int]]
splitStep x [] = [[x]]
splitStep x (run@(y:_):runs)
  | x < y = (x : run) : runs
  | otherwise = [x] : run : runs
