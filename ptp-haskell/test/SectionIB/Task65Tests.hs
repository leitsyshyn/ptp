module SectionIB.Task65Tests
  ( sectionIBTask65Tests
  ) where

import SectionIB.Task65 (splitPrimeNonPrime)
import TestRunner (Test, assertEqual, testCase, testGroup)

sectionIBTask65Tests :: Test
sectionIBTask65Tests =
  testGroup
    "Section I-b, task 65"
    [ testCase
        "empty list"
        (assertEqual ([], []) (splitPrimeNonPrime []))
    , testCase
        "mixed primes and non-primes"
        (assertEqual ([2, 3, 5, 11], [4, 6, 9]) (splitPrimeNonPrime [2, 4, 3, 6, 5, 9, 11]))
    , testCase
        "negatives zero and one are non-prime"
        (assertEqual ([2, 3], [-7, 0, 1, -2]) (splitPrimeNonPrime [-7, 0, 1, 2, 3, -2]))
    , testCase
        "repeated prime values"
        (assertEqual ([13, 13, 13], [15]) (splitPrimeNonPrime [13, 15, 13, 13]))
    , testCase
        "all non-prime values"
        (assertEqual ([], [1, 8, 12, 21]) (splitPrimeNonPrime [1, 8, 12, 21]))
    ]
