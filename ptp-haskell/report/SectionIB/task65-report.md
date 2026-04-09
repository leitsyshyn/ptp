# Звіт до задачі I-b, варіант 65

- Номер розділу: I-b
- Номер варіанту: 65
- Умова задачі: Розбити список на два списки відповідно до умови - "бути чи не бути простим числом".

## Код програми

```haskell
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
```

## Умови тестів

1. `splitPrimeNonPrime []` Очікувано: `([], [])`.
2. `splitPrimeNonPrime [2, 4, 3, 6, 5, 9, 11]` Очікувано: `([2, 3, 5, 11], [4, 6, 9])`.
3. `splitPrimeNonPrime [-7, 0, 1, 2, 3, -2]` Очікувано: `([2, 3], [-7, 0, 1, -2])`.
4. `splitPrimeNonPrime [13, 15, 13, 13]` Очікувано: `([13, 13, 13], [15])`.

## Екранний знімок з результатами виконання тестів

![Результати тестів задачі 65](assets/task65_tests.svg)
