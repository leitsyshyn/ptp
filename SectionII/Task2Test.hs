module SectionII.Task2Test
  ( sectionIITask2Tests
  , main
  ) where

import SectionII.Task2Solution (splitIncreasingRuns)
import TestRunner (Test, assertEqual, runTestMain, testCase, testGroup)

main :: IO ()
main = runTestMain sectionIITask2Tests

sectionIITask2Tests :: Test
sectionIITask2Tests =
  testGroup
    "Section II, task 2"
    [ testCase
        "input [] -> expected []"
        (assertEqual [] (splitIncreasingRuns []))
    , testCase
        "input [42] -> expected [[42]]"
        (assertEqual [[42]] (splitIncreasingRuns [42]))
    , testCase
        "input [1,2,3,4] -> expected [[1,2,3,4]]"
        (assertEqual [[1, 2, 3, 4]] (splitIncreasingRuns [1, 2, 3, 4]))
    , testCase
        "input [4,3,2,1] -> expected [[4],[3],[2],[1]]"
        (assertEqual [[4], [3], [2], [1]] (splitIncreasingRuns [4, 3, 2, 1]))
    , testCase
        "input [5,4,2,8,3,1,6,9,5] -> expected [[5],[4],[2,8],[3],[1,6,9],[5]]"
        (assertEqual [[5], [4], [2, 8], [3], [1, 6, 9], [5]] (splitIncreasingRuns [5, 4, 2, 8, 3, 1, 6, 9, 5]))
    , testCase
        "input [1,1,2,2,3] -> expected [[1],[1,2],[2,3]]"
        (assertEqual [[1], [1, 2], [2, 3]] (splitIncreasingRuns [1, 1, 2, 2, 3]))
    ]
