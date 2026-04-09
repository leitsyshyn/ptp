module SectionIA.Task27
  ( keepOddFrequencyElements
  ) where

import Data.List (group, sort)

oddFrequencyValues :: [Int] -> [Int]
oddFrequencyValues xs =
  [value | values@(value:_) <- group (sort xs), odd (length values)]

keepOddFrequencyElements :: [Int] -> [Int]
keepOddFrequencyElements xs = filter (`elem` oddValues) xs
  where
    oddValues = oddFrequencyValues xs
