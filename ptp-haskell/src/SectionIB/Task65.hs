module SectionIB.Task65
  ( splitPrimeNonPrime
  ) where

import Data.List (partition)

isPrime :: Int -> Bool
isPrime n
  | n <= 1 = False
  | n == 2 = True
  | even n = False
  | otherwise = hasNoOddDivisorFrom 3
  where
    hasNoOddDivisorFrom :: Int -> Bool
    hasNoOddDivisorFrom divisor
      | divisor * divisor > n = True
      | n `mod` divisor == 0 = False
      | otherwise = hasNoOddDivisorFrom (divisor + 2)

splitPrimeNonPrime :: [Int] -> ([Int], [Int])
splitPrimeNonPrime = partition isPrime
