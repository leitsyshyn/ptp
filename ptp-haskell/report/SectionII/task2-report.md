# Звіт до задачі II, варіант 2

- Номер розділу: II
- Номер варіанту: 2
- Умова задачі: Розбити список на впорядковані за зростанням підсписки (із збереженням порядку слідування елементів).

## Код програми

```haskell
module SectionII.Task2
  ( splitIncreasingRuns
  ) where

splitIncreasingRuns :: [Int] -> [[Int]]
splitIncreasingRuns = foldr splitStep []

splitStep :: Int -> [[Int]] -> [[Int]]
splitStep x [] = [[x]]
splitStep x (run@(y:_):runs)
  | x < y = (x : run) : runs
  | otherwise = [x] : run : runs
```

## Умови тестів

1. `splitIncreasingRuns []` Очікувано: `[]`.
2. `splitIncreasingRuns [42]` Очікувано: `[[42]]`.
3. `splitIncreasingRuns [1, 2, 3, 4]` Очікувано: `[[1, 2, 3, 4]]`.
4. `splitIncreasingRuns [5, 4, 2, 8, 3, 1, 6, 9, 5]` Очікувано: `[[5], [4], [2, 8], [3], [1, 6, 9], [5]]`.

## Екранний знімок з результатами виконання тестів

![Результати тестів задачі 2](assets/task2_tests.svg)
