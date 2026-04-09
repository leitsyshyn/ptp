# Звіт до задачі I-a, варіант 27

- Номер розділу: I-a
- Номер варіанту: 27
- Умова задачі: Залишити у списку елементи, що мають непарну кількість входжень у список.

## Код програми

```haskell
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
```

## Умови тестів

1. `keepOddFrequencyElements []` Очікувано: `[]`.
2. `keepOddFrequencyElements [1, 1, 2, 2, 3, 3, 4, 4]` Очікувано: `[]`.
3. `keepOddFrequencyElements [1, 1, 1, 2, 2, 3, 4, 4, 4, 4]` Очікувано: `[1, 1, 1, 3]`.
4. `keepOddFrequencyElements [0, 0, 0, -1, -1, -1, 2, 4, 4]` Очікувано: `[0, 0, 0, -1, -1, -1, 2]`.

## Екранний знімок з результатами виконання тестів

![Результати тестів задачі 27](assets/task27_tests.svg)
