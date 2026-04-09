module SectionII.Task2Tests
  ( sectionIITask2Tests
  ) where

import SectionII.Task2 (splitIncreasingRuns)
import TestRunner (Test, assertEqual, testCase, testGroup)

sectionIITask2Tests :: Test
sectionIITask2Tests =
  testGroup
    "Section II, task 2"
    [ testCase
        "empty list"
        (assertEqual [] (splitIncreasingRuns []))
    , testCase
        "one element"
        (assertEqual [[42]] (splitIncreasingRuns [42]))
    , testCase
        "entirely increasing list"
        (assertEqual [[1, 2, 3, 4]] (splitIncreasingRuns [1, 2, 3, 4]))
    , testCase
        "entirely decreasing list"
        (assertEqual [[4], [3], [2], [1]] (splitIncreasingRuns [4, 3, 2, 1]))
    , testCase
        "official sample"
        (assertEqual [[5], [4], [2, 8], [3], [1, 6, 9], [5]] (splitIncreasingRuns [5, 4, 2, 8, 3, 1, 6, 9, 5]))
    , testCase
        "equal adjacent values start new runs"
        (assertEqual [[1], [1, 2], [2, 3]] (splitIncreasingRuns [1, 1, 2, 2, 3]))
    ]
