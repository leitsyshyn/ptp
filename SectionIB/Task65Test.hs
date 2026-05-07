module SectionIB.Task65Test
  ( sectionIBTask65Tests
  , main
  ) where

import SectionIB.Task65Solution (splitPrimeNonPrime)
import TestRunner (Test, assertEqual, runTestMain, testCase, testGroup)

main :: IO ()
main = runTestMain sectionIBTask65Tests

sectionIBTask65Tests :: Test
sectionIBTask65Tests =
  testGroup
    "Section I-b, task 65"
    [ testCase
        "input [] -> expected primes=[], non-primes=[]"
        (assertEqual ([], []) (splitPrimeNonPrime []))
    , testCase
        "input [2,4,3,6,5,9,11] -> expected primes=[2,3,5,11], non-primes=[4,6,9]"
        (assertEqual ([2, 3, 5, 11], [4, 6, 9]) (splitPrimeNonPrime [2, 4, 3, 6, 5, 9, 11]))
    , testCase
        "input [-7,0,1,2,3,-2] -> expected primes=[2,3], non-primes=[-7,0,1,-2]"
        (assertEqual ([2, 3], [-7, 0, 1, -2]) (splitPrimeNonPrime [-7, 0, 1, 2, 3, -2]))
    , testCase
        "input [13,15,13,13] -> expected primes=[13,13,13], non-primes=[15]"
        (assertEqual ([13, 13, 13], [15]) (splitPrimeNonPrime [13, 15, 13, 13]))
    , testCase
        "input [1,8,12,21] -> expected primes=[], non-primes=[1,8,12,21]"
        (assertEqual ([], [1, 8, 12, 21]) (splitPrimeNonPrime [1, 8, 12, 21]))
    ]
