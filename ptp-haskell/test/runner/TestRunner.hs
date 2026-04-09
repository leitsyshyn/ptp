module TestRunner
  ( Test
  , Assertion
  , testCase
  , testGroup
  , assertEqual
  , runTest
  ) where

type Assertion = IO (Maybe String)

data Test
  = Case String Assertion
  | Group String [Test]

testCase :: String -> Assertion -> Test
testCase = Case

testGroup :: String -> [Test] -> Test
testGroup = Group

assertEqual :: (Eq a, Show a) => a -> a -> Assertion
assertEqual expected actual
  | expected == actual = pure Nothing
  | otherwise = pure (Just message)
  where
    message = "expected " ++ show expected ++ ", but got " ++ show actual

runTest :: Test -> IO Int
runTest = runWithIndent 0

runWithIndent :: Int -> Test -> IO Int
runWithIndent level test =
  case test of
    Group name tests -> runGroup level name tests
    Case name assertion -> runCase level name assertion

runGroup :: Int -> String -> [Test] -> IO Int
runGroup level name tests = do
  putStrLn (renderGroupHeader level name)
  failures <- mapM (runWithIndent (level + 2)) tests
  putStrLn ""
  pure (sum failures)

runCase :: Int -> String -> Assertion -> IO Int
runCase level name assertion = do
  result <- assertion
  putStrLn (renderCaseLine level name result)
  pure (failureCount result)

renderGroupHeader :: Int -> String -> String
renderGroupHeader level name = indent level ++ name

renderCaseLine :: Int -> String -> Maybe String -> String
renderCaseLine level name result =
  indent level ++ casePrefix result ++ name ++ caseSuffix result

casePrefix :: Maybe String -> String
casePrefix Nothing = "[PASS] "
casePrefix (Just _) = "[FAIL] "

caseSuffix :: Maybe String -> String
caseSuffix Nothing = ""
caseSuffix (Just message) = " -> " ++ message

failureCount :: Maybe String -> Int
failureCount Nothing = 0
failureCount (Just _) = 1

indent :: Int -> String
indent level = replicate level ' '
