# Звіт до задачі IV, варіант 7

- Номер розділу: IV
- Номер варіанту: 7
- Умова задачі: У нескорочуваній граматиці для кожного нетермінала A знайти minlengthL(A) = min{length(w) | A =>+ wA, w - слово в термінальному алфавіті} та words_minlenL(A) = {w | A =>+ wA, w - слово в термінальному алфавіті, length(w) = minlengthL(A)}.

## Код програми

```haskell
module SectionIV.Task7
  ( Nonterminal
  , Terminal
  , TerminalWord
  , Symbol(..)
  , Production(..)
  , Grammar(..)
  , MinWords(..)
  , minlengthL
  , wordsMinlenL
  , solve
  ) where

import Data.List (foldl', nub, unsnoc)
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set

type Nonterminal = String
type Terminal = Char
type TerminalWord = [Terminal]

data Symbol
  = T Terminal
  | N Nonterminal
  deriving (Eq, Ord, Show)

data Production = Production Nonterminal [Symbol]
  deriving (Eq, Show)

data Grammar = Grammar
  { ns :: [Nonterminal]
  , sigma :: [Terminal]
  , ps :: [Production]
  }
  deriving (Eq, Show)

data MinWords = MinWords
  { len :: Int
  , ws :: Set.Set TerminalWord
  }
  deriving (Eq, Show)

data DirectDerivation = DirectDerivation Nonterminal Nonterminal MinWords
  deriving (Eq, Show)

type MinTerminalLanguage = Map.Map Nonterminal MinWords
type Relation = Map.Map (Nonterminal, Nonterminal) MinWords

minlengthL :: Grammar -> Nonterminal -> Maybe Int
minlengthL g a =
  len <$> Map.lookup (a, a) (relation g)

wordsMinlenL :: Grammar -> Nonterminal -> [TerminalWord]
wordsMinlenL g a =
  case Map.lookup (a, a) (relation g) of
    Nothing -> []
    Just mws -> Set.toList (ws mws)

solve :: Grammar -> [(Nonterminal, Maybe (Int, [TerminalWord]))]
solve g =
  [ (a, solveA a)
  | a <- nub (ns g)
  ]
  where
    rel = relation g

    solveA :: Nonterminal -> Maybe (Int, [TerminalWord])
    solveA a =
      case Map.lookup (a, a) rel of
        Nothing -> Nothing
        Just mws -> Just (len mws, Set.toList (ws mws))

relation :: Grammar -> Relation
relation g = transitiveClosure (directRelation g (minTerminalLanguage g))

minTerminalLanguage :: Grammar -> MinTerminalLanguage
minTerminalLanguage g = lfp step Map.empty
  where
    step :: MinTerminalLanguage -> MinTerminalLanguage
    step lang = foldl' add lang (ps g)

    add :: MinTerminalLanguage -> Production -> MinTerminalLanguage
    add lang (Production a alpha) =
      case alphaMinWords lang alpha of
        Nothing -> lang
        Just mws -> Map.alter (shortest mws) a lang

directRelation :: Grammar -> MinTerminalLanguage -> [DirectDerivation]
directRelation g lang = concatMap step (ps g)
  where
    step :: Production -> [DirectDerivation]
    step (Production a alpha) =
      case unsnoc alpha of
        Just (prefix, N b) ->
          case alphaMinWords lang prefix of
            Nothing -> []
            Just mws -> [DirectDerivation a b mws]
        _ -> []

transitiveClosure :: [DirectDerivation] -> Relation
transitiveClosure dir = lfp step (relation dir)
  where
    relation :: [DirectDerivation] -> Relation
    relation = foldl' insert Map.empty
      where
        insert :: Relation -> DirectDerivation -> Relation
        insert rel (DirectDerivation a b mws) = Map.alter (shortest mws) (a, b) rel

    step :: Relation -> Relation
    step rel = foldl' extend rel (Map.toList rel)

    extend :: Relation -> ((Nonterminal, Nonterminal), MinWords) -> Relation
    extend rel ((a, b), wsAB) = foldl' compose rel (outgoing b)
      where
        compose :: Relation -> DirectDerivation -> Relation
        compose current (DirectDerivation _ c wsBC) =
          Map.alter (shortest (append wsAB wsBC)) (a, c) current

    outgoing :: Nonterminal -> [DirectDerivation]
    outgoing a =
      [ der
      | der@(DirectDerivation b _ _) <- dir
      , a == b
      ]

alphaMinWords :: MinTerminalLanguage -> [Symbol] -> Maybe MinWords
alphaMinWords lang = foldl' extend (Just epsilon)
  where
    extend :: Maybe MinWords -> Symbol -> Maybe MinWords
    extend Nothing _ =
      Nothing
    extend (Just mws) (T x) =
      Just (append mws (minWords [x]))
    extend (Just mws) (N a) =
      append mws <$> Map.lookup a lang

append :: MinWords -> MinWords -> MinWords
append left right =
  MinWords
    { len = len left + len right
    , ws =
        Set.fromList
          [ u ++ v
          | u <- Set.toList (ws left)
          , v <- Set.toList (ws right)
          ]
    }

shortest :: MinWords -> Maybe MinWords -> Maybe MinWords
shortest mws Nothing = Just mws
shortest mws (Just current)
  | len mws < len current = Just mws
  | len mws == len current =
      Just current {ws = Set.union (ws current) (ws mws)}
  | otherwise = Just current

minWords :: TerminalWord -> MinWords
minWords w =
  MinWords
    { len = length w
    , ws = Set.singleton w
    }

epsilon :: MinWords
epsilon = minWords ""

lfp :: Eq a => (a -> a) -> a -> a
lfp f x
  | x == next = x
  | otherwise = lfp f next
  where
    next = f x
```

## Опис алгоритму

Нехай задано контекстно-вільну граматику `G = (N, Σ, P)`. Для кожного нетермінала `A ∈ N` потрібно знайти мінімальну довжину слова `w ∈ Σ*`, для якого існує виведення `A =>+ wA`, а також усі слова такої мінімальної довжини.

Алгоритм не перебирає всі можливі виведення напряму. Замість цього він будує скінченне відношення між нетерміналами. Запис `(A, B)` у цьому відношенні зберігає найкоротші термінальні слова `w`, для яких існує виведення `A =>+ wB`.

Спочатку обчислюється допоміжна структура `MinTerminalLanguage`. Для кожного нетермінала вона містить найкоротші термінальні слова, які цей нетермінал може породити. Це потрібно для обробки правих частин правил, у яких перед останнім нетерміналом можуть стояти термінали або нетермінали, що повністю породжують термінальні слова.

Далі з правил граматики будується пряме відношення. Якщо правило має вигляд `A -> αB`, де останній символ правої частини є нетерміналом `B`, а префікс `α` може породити термінальне слово `w`, то до відношення додається запис `A =>+ wB`. Правила, у яких після потрібного нетермінала залишаються інші символи, не дають безпосереднього кроку такого вигляду, бо у нескорочуваній граматиці ці символи не можуть бути просто усунені.

Після цього обчислюється транзитивне замикання відношення. Якщо вже відомо, що `A =>+ uB`, і є прямий крок `B =>+ vC`, то отримуємо `A =>+ uvC`. Для кожної пари нетерміналів зберігаються лише слова мінімальної довжини; якщо знайдено кілька слів однакової мінімальної довжини, їхні множини об'єднуються.

Відповідь для нетермінала `A` береться з діагонального елемента відношення `(A, A)`. Якщо такий елемент існує, його довжина є `minlengthL(A)`, а множина слів є `words_minlenL(A)`. Якщо запису `(A, A)` немає, то відповідного виведення `A =>+ wA` не існує.

## Обґрунтування завершуваності

Алгоритм використовує два ітеративні процеси пошуку найменшої нерухомої точки: для `MinTerminalLanguage` і для транзитивного замикання відношення `Relation`.

Перший процес працює з ключами з множини нетерміналів `N`, а другий - з парами нетерміналів `N × N`. Обидві множини скінченні. Оновлення значення для ключа відбувається лише тоді, коли знайдено слово меншої довжини або ще одне слово тієї самої мінімальної довжини.

Для кожної фіксованої довжини над скінченним алфавітом `Σ` існує лише скінченна кількість термінальних слів. Тому множини мінімальних слів для кожного ключа також скінченні. Коли для всіх ключів встановлено остаточні мінімальні довжини та всі слова цих довжин, наступна ітерація не змінює структуру, і функція `lfp` завершується.

Отже, обидва ітеративні процеси стабілізуються після скінченної кількості змін, а весь алгоритм завершується.

## Опис ітеративного процесу

### Ініціалізація (нульовий крок)

Алгоритм складається з трьох основних етапів: обчислення `MinTerminalLanguage`, побудови `directRelation` і обчислення `transitiveClosure`.

На першому етапі, для `MinTerminalLanguage`, початкове відображення є порожнім: жодному нетерміналу ще не поставлено у відповідність термінальне слово. Метою цього етапу є знаходження найкоротших термінальних слів, що виводяться з кожного нетермінала.

На другому етапі, для `directRelation`, окремого ітеративного процесу немає. Після стабілізації `MinTerminalLanguage` правила граматики переглядаються один раз. З них будуються безпосередні переходи вигляду `A =>+ wB`.

На третьому етапі, для `transitiveClosure`, початковим станом є пряме відношення. Далі воно доповнюється складеними переходами між нетерміналами.

### Загальний крок ітерації

Для `MinTerminalLanguage` на кожній ітерації переглядаються всі правила `A -> α`. Права частина `α` оцінюється функцією `alphaMinWords`: термінальний символ дає слово довжини 1, а нетермінал використовується лише тоді, коли для нього вже відоме мінімальне термінальне слово. Якщо вся права частина може породити термінальні слова, для нетермінала `A` утворюється нове можливе значення.

Вибір значення виконується функцією `shortest`: коротше слово замінює попереднє значення, слова тієї самої довжини додаються до множини, а довші слова не враховуються.

Для `directRelation` переглядається кожне правило. Якщо права частина закінчується нетерміналом, тобто має вигляд `αB`, то префікс `α` оцінюється через уже знайдену `MinTerminalLanguage`. Якщо `α` породжує термінальні слова `w`, до прямого відношення додається запис `(A, B)` зі словами `w`. В інших випадках правило не задає переходу вигляду `A =>+ wB`.

Для `transitiveClosure` на кожній ітерації переглядаються записи `(A, B)` поточного відношення та прямі виходи з `B`. Якщо відомо `A =>+ uB` і є прямий крок `B =>+ vC`, то додається можливість `A =>+ uvC`. Для пари `(A, C)` знову зберігаються тільки слова мінімальної довжини.

### Умова припинення ітерації

Етап `MinTerminalLanguage` завершується, коли повний перегляд правил не змінює відображення нетерміналів у множини мінімальних слів.

Етап `directRelation` завершується після одного перегляду всіх правил, оскільки він не залежить сам від себе і використовує вже обчислену `MinTerminalLanguage`.

Етап `transitiveClosure` завершується, коли черговий прохід по відношенню не змінює жодного запису. У програмі обидва ітеративні етапи зупиняються функцією `lfp`: якщо після застосування кроку отримано те саме значення, процес завершено.

Після завершення обчислення відношення відповідь для нетермінала `A` визначається перевіркою запису `(A, A)`. Якщо він присутній, повертаються мінімальна довжина і всі слова цієї довжини; якщо відсутній, повертається `Nothing` або порожній список слів.

### Оцінка максимальної кількості кроків

Для `MinTerminalLanguage` кількість ключів не перевищує `|N|`. Значення ключа може змінитися лише тоді, коли знайдено меншу довжину або додано слово вже мінімальної довжини. Тому кількість ітерацій цього етапу не перевищує кількості різних станів відображення до стабілізації плюс одну перевірочну ітерацію.

Для `directRelation` виконується один перегляд правил, тому кількість кроків цього етапу не перевищує `|P|`, якщо перевірку одного правила вважати одним кроком.

Для `transitiveClosure` кількість ключів не перевищує `|N|^2`. Запис відношення може змінитися лише тоді, коли знайдено меншу довжину або додано слово тієї самої мінімальної довжини. Отже, кількість ітерацій цього етапу не перевищує кількості різних станів відношення до стабілізації плюс одну перевірочну ітерацію. Загальна кількість кроків є скінченною сумою кроків трьох описаних етапів.

## Умови тестів

1. `minlengthL directLeftGrammar "A"` Очікувано: `Just 1`.
2. `wordsMinlenL directLeftGrammar "A"` Очікувано: `["a"]`.
3. `wordsMinlenL indirectLeftGrammar "A"` Очікувано: `["bc"]`.
4. `minlengthL emptyWordGrammar "A"` Очікувано: `Just 0`.
5. `wordsMinlenL multipleWordsGrammar "A"` Очікувано: `["a", "b"]`.
6. `minlengthL noRecursionGrammar "A"` Очікувано: `Nothing`.
7. `wordsMinlenL generatedPrefixGrammar "A"` Очікувано: `["c"]`.
8. `wordsMinlenL blockedSuffixGrammar "A"` Очікувано: `[]`.
9. `solve solveAllGrammar` Очікувано: `[("A", Just (1, ["a"])), ("B", Nothing)]`.

## Екранний знімок з результатами виконання тестів

![Результати тестів задачі 7](/report/assets/task7_tests.png)
