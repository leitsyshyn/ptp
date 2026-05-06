module Main where

import Tasks
  ( Automaton(..)
  , Grammar(..)
  , Problem(..)
  , Production(..)
  , Transition(..)
  , keepOddFrequencyElements
  , solve
  , splitIncreasingRuns
  , splitPrimeNonPrime
  )
import qualified SectionIV.Task7 as Task7
import SectionIV.Task7 (Symbol(..))

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
      sectionIIITask11Input =
        Problem
          { fa =
              Automaton
                { qs = [0, 1, 2, 3, 4]
                , sigma = "abc"
                , q0 = 0
                , fs = [4]
                , edges =
                    [ Transition 0 'a' 1
                    , Transition 1 'c' 2
                    , Transition 2 'b' 3
                    , Transition 3 'c' 4
                    ]
                }
          , v = "a"
          , w = "b"
          }
      sectionIVTask7Input =
        Grammar
          ["A", "B"]
          "abc"
          [ Production "A" [T 'a', N "A"]
          , Production "A" [T 'b', N "B"]
          , Production "B" [T 'c']
          ]

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
  printExample
    "Section III, task 11: accepted word of the form v y w y"
    sectionIIITask11Input
    (solve sectionIIITask11Input)
  printExample
    "Section IV, task 7: minimal left-recursive terminal prefixes"
    sectionIVTask7Input
    (Task7.solve sectionIVTask7Input)
