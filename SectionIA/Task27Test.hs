module SectionIA.Task27Test
  ( sectionIATask27Tests
  , main
  ) where

import SectionIA.Task27Solution (keepOddFrequencyElements)
import TestRunner (Test, assertEqual, runTestMain, testCase, testGroup)

main :: IO ()
main = runTestMain sectionIATask27Tests

sectionIATask27Tests :: Test
sectionIATask27Tests =
  testGroup
    "Section I-a, task 27"
    [ testCase
        "input [] -> expected []"
        (assertEqual [] (keepOddFrequencyElements []))
    , testCase
        "input [1,1,2,2,3,3,4,4] -> expected []"
        (assertEqual [] (keepOddFrequencyElements [1, 1, 2, 2, 3, 3, 4, 4]))
    , testCase
        "input [1,1,1,2,2,3,4,4,4,4] -> expected [1,1,1,3]"
        (assertEqual [1, 1, 1, 3] (keepOddFrequencyElements [1, 1, 1, 2, 2, 3, 4, 4, 4, 4]))
    , testCase
        "input [0,0,0,-1,-1,-1,2,4,4] -> expected [0,0,0,-1,-1,-1,2]"
        (assertEqual [0, 0, 0, -1, -1, -1, 2] (keepOddFrequencyElements [0, 0, 0, -1, -1, -1, 2, 4, 4]))
    , testCase
        "input [7,7,7,7,7] -> expected [7,7,7,7,7]"
        (assertEqual [7, 7, 7, 7, 7] (keepOddFrequencyElements [7, 7, 7, 7, 7]))
    ]
