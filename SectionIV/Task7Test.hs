module SectionIV.Task7Test
  ( sectionIVTask7Tests
  , main
  ) where

import SectionIV.Task7Solution
  ( Grammar(..)
  , Production(..)
  , Symbol(..)
  , minlengthL
  , solve
  , wordsMinlenL
  )
import TestRunner (Test, assertEqual, runTestMain, testCase, testGroup)

main :: IO ()
main = runTestMain sectionIVTask7Tests

sectionIVTask7Tests :: Test
sectionIVTask7Tests =
  testGroup
    "Section IV, task 7"
    [ testCase
        "grammar A -> aA -> expected minlengthL(A)=1"
        (assertEqual (Just 1) (minlengthL directLeftGrammar "A"))
    , testCase
        "grammar A -> aA -> expected words_minlenL(A)=[\"a\"]"
        (assertEqual ["a"] (wordsMinlenL directLeftGrammar "A"))
    , testCase
        "grammar A -> bB, B -> cA -> expected words_minlenL(A)=[\"bc\"]"
        (assertEqual ["bc"] (wordsMinlenL indirectLeftGrammar "A"))
    , testCase
        "grammar A -> A -> expected minlengthL(A)=0"
        (assertEqual (Just 0) (minlengthL emptyWordGrammar "A"))
    , testCase
        "grammar A -> aA | bA | cB, B -> dA -> expected words_minlenL(A)=[\"a\",\"b\"]"
        (assertEqual ["a", "b"] (wordsMinlenL multipleWordsGrammar "A"))
    , testCase
        "grammar A -> aB, B -> b -> expected minlengthL(A)=Nothing"
        (assertEqual Nothing (minlengthL noRecursionGrammar "A"))
    , testCase
        "grammar A -> BA, B -> c -> expected words_minlenL(A)=[\"c\"]"
        (assertEqual ["c"] (wordsMinlenL generatedPrefixGrammar "A"))
    , testCase
        "grammar A -> Aa | b -> expected words_minlenL(A)=[]"
        (assertEqual [] (wordsMinlenL blockedSuffixGrammar "A"))
    , testCase
        "solve grammar with A -> aA, B -> b -> expected A has length 1 and B has Nothing"
        (assertEqual [("A", Just (1, ["a"])), ("B", Nothing)] (solve solveAllGrammar))
    ]

directLeftGrammar :: Grammar
directLeftGrammar =
  Grammar
    { ns = ["A"]
    , sigma = "a"
    , ps = [Production "A" [T 'a', N "A"]]
    }

indirectLeftGrammar :: Grammar
indirectLeftGrammar =
  Grammar
    { ns = ["A", "B"]
    , sigma = "bc"
    , ps =
        [ Production "A" [T 'b', N "B"]
        , Production "B" [T 'c', N "A"]
        ]
    }

emptyWordGrammar :: Grammar
emptyWordGrammar =
  Grammar
    { ns = ["A"]
    , sigma = []
    , ps = [Production "A" [N "A"]]
    }

multipleWordsGrammar :: Grammar
multipleWordsGrammar =
  Grammar
    { ns = ["A", "B"]
    , sigma = "abcd"
    , ps =
        [ Production "A" [T 'a', N "A"]
        , Production "A" [T 'b', N "A"]
        , Production "A" [T 'c', N "B"]
        , Production "B" [T 'd', N "A"]
        ]
    }

noRecursionGrammar :: Grammar
noRecursionGrammar =
  Grammar
    { ns = ["A", "B"]
    , sigma = "ab"
    , ps =
        [ Production "A" [T 'a', N "B"]
        , Production "B" [T 'b']
        ]
    }

generatedPrefixGrammar :: Grammar
generatedPrefixGrammar =
  Grammar
    { ns = ["A", "B"]
    , sigma = "c"
    , ps =
        [ Production "A" [N "B", N "A"]
        , Production "B" [T 'c']
        ]
    }

blockedSuffixGrammar :: Grammar
blockedSuffixGrammar =
  Grammar
    { ns = ["A"]
    , sigma = "ab"
    , ps =
        [ Production "A" [N "A", T 'a']
        , Production "A" [T 'b']
        ]
    }

solveAllGrammar :: Grammar
solveAllGrammar =
  Grammar
    { ns = ["A", "B"]
    , sigma = "ab"
    , ps =
        [ Production "A" [T 'a', N "A"]
        , Production "B" [T 'b']
        ]
    }
