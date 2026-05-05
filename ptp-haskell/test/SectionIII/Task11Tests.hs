module SectionIII.Task11Tests
  ( sectionIIITask11Tests
  ) where

import Data.List (isPrefixOf)
import SectionIII.Task11
  ( Automaton(..)
  , Word
  , Problem(..)
  , Transition(..)
  , accepts
  , solve
  )
import TestRunner (Assertion, Test, assertEqual, testCase, testGroup)
import Prelude hiding (Word)

sectionIIITask11Tests :: Test
sectionIIITask11Tests =
  testGroup
    "Section III, task 11"
    [ testCase
        "positive case with non-empty y"
        (assertPositive nonEmptyYProblem)
    , testCase
        "positive case with empty y"
        (assertPositive emptyYProblem)
    , testCase
        "negative case with no suitable word"
        (assertEqual Nothing (solve negativeProblem))
    , testCase
        "nondeterministic transitions"
        (assertPositive nondeterministicProblem)
    , testCase
        "missing transitions"
        (assertPositive missingTransitionsProblem)
    , testCase
        "multiple accepting states"
        (assertPositive multipleAcceptingStatesProblem)
    ]

assertPositive :: Problem -> Assertion
assertPositive problem =
  case solve problem of
    Nothing -> pure (Just "expected a word, but solver returned Nothing")
    Just word -> pure (validateSolvedWord problem word)

validateSolvedWord :: Problem -> Word -> Maybe String
validateSolvedWord problem word
  | not (v problem `isPrefixOf` word) = Just "word does not start with fixed v"
  | not (accepts (fa problem) word) = Just "word is not accepted by the automaton"
  | otherwise = validateForm (v problem) (w problem) word

validateForm :: Word -> Word -> Word -> Maybe String
validateForm v w word
  | remainingLength < length w = Just "word is too short to contain fixed w"
  | odd (remainingLength - length w) = Just "remaining length cannot be split into two equal y parts"
  | not (w `isPrefixOf` afterFirstY) = Just "fixed w is not in the required position"
  | firstY /= secondY = Just "the two y parts are different"
  | otherwise = Nothing
  where
    afterV = drop (length v) word
    remainingLength = length afterV
    yLength = (remainingLength - length w) `div` 2
    firstY = take yLength afterV
    afterFirstY = drop yLength afterV
    secondY = drop (length w) afterFirstY

nonEmptyYProblem :: Problem
nonEmptyYProblem =
  Problem
    { fa =
        Automaton
          { qs = [0, 1, 2, 3, 4]
          , sigma = "abc"
          , q0 = 0
          , fs = [4]
          , edges =
              [ Transition 0 'a' 1
              , Transition 1 'c' 2
              , Transition 2 'b' 3
              , Transition 3 'c' 4
              ]
          }
    , v = "a"
    , w = "b"
    }

emptyYProblem :: Problem
emptyYProblem =
  Problem
    { fa =
        Automaton
          { qs = [0, 1, 2]
          , sigma = "ab"
          , q0 = 0
          , fs = [2]
          , edges =
              [ Transition 0 'a' 1
              , Transition 1 'b' 2
              ]
          }
    , v = "a"
    , w = "b"
    }

negativeProblem :: Problem
negativeProblem =
  Problem
    { fa =
        Automaton
          { qs = [0, 1, 2, 3]
          , sigma = "abc"
          , q0 = 0
          , fs = [3]
          , edges =
              [ Transition 0 'a' 1
              , Transition 1 'c' 2
              , Transition 2 'c' 3
              ]
          }
    , v = "a"
    , w = "b"
    }

nondeterministicProblem :: Problem
nondeterministicProblem =
  Problem
    { fa =
        Automaton
          { qs = [0, 1, 2, 3, 4, 5, 6]
          , sigma = "abc"
          , q0 = 0
          , fs = [4]
          , edges =
              [ Transition 0 'a' 1
              , Transition 0 'a' 6
              , Transition 1 'c' 2
              , Transition 1 'c' 5
              , Transition 2 'b' 3
              , Transition 3 'c' 4
              ]
          }
    , v = "a"
    , w = "b"
    }

missingTransitionsProblem :: Problem
missingTransitionsProblem =
  Problem
    { fa =
        Automaton
          { qs = [0, 1, 2, 3, 4]
          , sigma = "pqr"
          , q0 = 0
          , fs = [4]
          , edges =
              [ Transition 0 'p' 1
              , Transition 1 'r' 2
              , Transition 2 'q' 3
              , Transition 3 'r' 4
              ]
          }
    , v = "p"
    , w = "q"
    }

multipleAcceptingStatesProblem :: Problem
multipleAcceptingStatesProblem =
  Problem
    { fa =
        Automaton
          { qs = [0, 1, 2, 42, 99]
          , sigma = "ab"
          , q0 = 0
          , fs = [2, 99]
          , edges =
              [ Transition 0 'a' 1
              , Transition 1 'b' 2
              ]
          }
    , v = "a"
    , w = "b"
    }
