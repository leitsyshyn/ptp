module Main where

import Tasks
  ( keepOddFrequencyElements
  , splitIncreasingRuns
  , splitPrimeNonPrime
  )

printExample :: (Show a, Show b) => String -> a -> b -> IO ()
printExample title input output = do
  putStrLn title
  print input
  print output
  putStrLn ""

main :: IO ()
main = do
  let sectionIATask27Input = [1, 1, 1, 2, 2, 3, 4, 4, 4, 4]
      sectionIBTask65Input = [11, 4, 5, 0, 17, 18, -3, 19, 20, 1]
      sectionIITask2Input = [5, 4, 2, 8, 3, 1, 6, 9, 5]

  putStrLn "PTP Haskell demo"
  putStrLn ""

  printExample
    "Section I-a, task 27: keep elements with odd total frequency"
    sectionIATask27Input
    (keepOddFrequencyElements sectionIATask27Input)
  printExample
    "Section I-b, task 65: split into prime and non-prime numbers"
    sectionIBTask65Input
    (splitPrimeNonPrime sectionIBTask65Input)
  printExample
    "Section II, task 2: split into maximal strictly increasing runs"
    sectionIITask2Input
    (splitIncreasingRuns sectionIITask2Input)
