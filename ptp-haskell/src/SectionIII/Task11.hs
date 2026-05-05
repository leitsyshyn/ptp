module SectionIII.Task11
  ( State
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

import Data.List (foldl', nub)
import Data.Foldable (asum)
import Data.Sequence (Seq, ViewL(..), (|>))
import qualified Data.Sequence as Seq
import qualified Data.Set as Set
import Prelude hiding (Word)

type State = Int
type Symbol = Char
type Word = [Symbol]

data Transition = Transition State Symbol State
  deriving (Eq, Show)

data Automaton = Automaton
  { qs :: [State]
  , sigma :: [Symbol]
  , q0 :: State
  , fs :: [State]
  , edges :: [Transition]
  }
  deriving (Eq, Show)

data Problem = Problem
  { fa :: Automaton
  , v :: Word
  , w :: Word
  }
  deriving (Eq, Show)

type Pair = (State, State)
type Node = (State, State, Word)

delta :: Automaton -> State -> Symbol -> [State]
delta a q x =
  nub
    [ q'
    | Transition p y q' <- edges a
    , p == q
    , y == x
    ]

run :: Automaton -> [State] -> Word -> [State]
run a q0s = foldl' step (nub q0s)
  where
    step :: [State] -> Symbol -> [State]
    step ps x =
      nub
        [ q
        | p <- ps
        , q <- delta a p x
        ]

accepts :: Automaton -> Word -> Bool
accepts a xs =
  any (`elem` fs a) (run a [q0 a] xs)

solve :: Problem -> Maybe Word
solve p =
  build p <$> solveY p

solveY :: Problem -> Maybe Word
solveY p =
  asum
    [ syncY p q1 q3
    | q1 <- run a [q0 a] (v p)
    , q3 <- nub (qs a)
    ]
  where
    a = fa p

syncY :: Problem -> State -> State -> Maybe Word
syncY p q1 q3 =
  bfs Set.empty (Seq.singleton (q1, q3, []))
  where
    a = fa p

    bfs :: Set.Set Pair -> Seq Node -> Maybe Word
    bfs seen queue =
      case Seq.viewl queue of
        EmptyL ->
          Nothing
        (q2, q4, y) :< rest
          | goal q2 q4 ->
              Just y
          | Set.member (q2, q4) seen ->
              bfs seen rest
          | otherwise ->
              bfs seen' queue'
          where
            seen' = Set.insert (q2, q4) seen
            queue' = foldl' (|>) rest (next q2 q4 y)

    goal :: State -> State -> Bool
    goal q2 q4 =
      q3 `elem` run a [q2] (w p)
        && q4 `elem` fs a

    next :: State -> State -> Word -> [Node]
    next q2 q4 y =
      [ (q2', q4', y ++ [x])
      | x <- nub (sigma a)
      , q2' <- delta a q2 x
      , q4' <- delta a q4 x
      ]

build :: Problem -> Word -> Word
build p y =
  v p ++ y ++ w p ++ y
