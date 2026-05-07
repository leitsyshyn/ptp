# PTP

This project contains Haskell and Prolog solutions for the PTP assignments:

- Section I-a, task 27
- Section I-b, task 65
- Section II, task 2
- Section III, task 11
- Section IV, task 7

## Project structure

```text
cabal.project
ptp.cabal
hie.yaml
HaskellTests.hs
TestRunner.hs
prolog_tests.pl
test_runner.pl
assets/
SectionIA/Task27Solution.hs
SectionIA/Task27Test.hs
SectionIA/Task27.hs.md
SectionIA/task27_solution.pl
SectionIA/task27_test.pl
SectionIA/task27.pl.md
SectionIB/Task65Solution.hs
SectionIB/Task65Test.hs
SectionIB/Task65.hs.md
SectionIB/task65_solution.pl
SectionIB/task65_test.pl
SectionIB/task65.pl.md
SectionII/Task2Solution.hs
SectionII/Task2Test.hs
SectionII/Task2.hs.md
SectionII/task2_solution.pl
SectionII/task2_test.pl
SectionII/task2.pl.md
SectionIII/Task11Solution.hs
SectionIII/Task11Test.hs
SectionIII/Task11.hs.md
SectionIV/Task7Solution.hs
SectionIV/Task7Test.hs
SectionIV/Task7.hs.md
```

Each section keeps the implementation, tests, and report together. Shared test runners live at the project root.

## Requirements

- GHC 9.8.4 and Cabal
- SWI-Prolog 10+

## Haskell

Build the Haskell modules:

```bash
cabal build
```

Run all Haskell tests:

```bash
cabal test all-tests
```

Run one Haskell task suite:

```bash
cabal test section-ia-task27-tests
cabal test section-ib-task65-tests
cabal test section-ii-task2-tests
cabal test section-iii-task11-tests
cabal test section-iv-task7-tests
```

Compile and run an individual Haskell test file directly from the project root:

```bash
ghc -i. -main-is SectionIII.Task11Test.main SectionIII/Task11Test.hs -o /tmp/task11-test && /tmp/task11-test
```

There is no Haskell demo executable; tests are the executable entrypoints.

## Prolog

Run all Prolog tests:

```bash
swipl -q -s prolog_tests.pl
```

Run one Prolog task suite:

```bash
swipl -q -s prolog_tests.pl -- section-ia-task27-tests
swipl -q -s prolog_tests.pl -- section-ib-task65-tests
swipl -q -s prolog_tests.pl -- section-ii-task2-tests
```

Run an individual Prolog test file directly from the project root:

```bash
swipl -q -s SectionII/task2_test.pl
```
