module Tasks
  ( keepOddFrequencyElements
  , splitPrimeNonPrime
  , splitIncreasingRuns
  , State
  , Symbol
  , Word
  , Transition(..)
  , Automaton(..)
  , Problem(..)
  , delta
  , run
  , accepts
  , solveY
  , solve
  ) where

import SectionIA.Task27 (keepOddFrequencyElements)
import SectionIB.Task65 (splitPrimeNonPrime)
import SectionII.Task2 (splitIncreasingRuns)
import SectionIII.Task11
  ( Automaton(..)
  , Word
  , Problem(..)
  , State
  , Symbol
  , Transition(..)
  , accepts
  , delta
  , run
  , solve
  , solveY
  )
import Prelude hiding (Word)
