module SectionIA.Task27Tests
  ( sectionIATask27Tests
  ) where

import SectionIA.Task27 (keepOddFrequencyElements)
import TestRunner (Test, assertEqual, testCase, testGroup)

sectionIATask27Tests :: Test
sectionIATask27Tests =
  testGroup
    "Section I-a, task 27"
    [ testCase
        "empty list"
        (assertEqual [] (keepOddFrequencyElements []))
    , testCase
        "all multiplicities even"
        (assertEqual [] (keepOddFrequencyElements [1, 1, 2, 2, 3, 3, 4, 4]))
    , testCase
        "mixed odd and even multiplicities"
        (assertEqual [1, 1, 1, 3] (keepOddFrequencyElements [1, 1, 1, 2, 2, 3, 4, 4, 4, 4]))
    , testCase
        "negatives and zero"
        (assertEqual [0, 0, 0, -1, -1, -1, 2] (keepOddFrequencyElements [0, 0, 0, -1, -1, -1, 2, 4, 4]))
    , testCase
        "preserve all copies for odd frequency"
        (assertEqual [7, 7, 7, 7, 7] (keepOddFrequencyElements [7, 7, 7, 7, 7]))
    ]
