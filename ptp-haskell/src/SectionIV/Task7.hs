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
