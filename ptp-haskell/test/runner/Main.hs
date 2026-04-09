module Main where

import Data.List (isSuffixOf)
import SectionIA.Task27Tests (sectionIATask27Tests)
import SectionIB.Task65Tests (sectionIBTask65Tests)
import SectionII.Task2Tests (sectionIITask2Tests)
import System.Environment (getProgName)
import System.Exit (exitFailure, exitSuccess)
import TestRunner (Test, runTest, testGroup)

allTests :: Test
allTests =
  testGroup
    "PTP Haskell tests"
    [ sectionIATask27Tests
    , sectionIBTask65Tests
    , sectionIITask2Tests
    ]

selectTest :: String -> Maybe Test
selectTest progName
  | "all-tests" `isSuffixOf` progName = Just allTests
  | "section-ia-task27-tests" `isSuffixOf` progName = Just sectionIATask27Tests
  | "section-ib-task65-tests" `isSuffixOf` progName = Just sectionIBTask65Tests
  | "section-ii-task2-tests" `isSuffixOf` progName = Just sectionIITask2Tests
  | otherwise = Nothing

main :: IO ()
main = do
  progName <- getProgName
  case selectTest progName of
    Nothing -> do
      putStrLn ("Unknown test suite: " ++ progName)
      exitFailure
    Just selectedTests -> do
      totalFailures <- runTest selectedTests
      putStrLn ("Total failures: " ++ show totalFailures)
      if totalFailures == 0
        then exitSuccess
        else exitFailure
