# PTP Haskell

This project contains the PTP Haskell assignment for:

- Section I-a, task 27
- Section I-b, task 65
- Section II, task 2
- Section III, task 11
- Section IV, task 7

## Project structure

```text
app/Main.hs
src/Tasks.hs
src/SectionIA/Task27.hs
src/SectionIB/Task65.hs
src/SectionII/Task2.hs
src/SectionIII/Task11.hs
src/SectionIV/Task7.hs
test/SectionIA/Task27Tests.hs
test/SectionIB/Task65Tests.hs
test/SectionII/Task2Tests.hs
test/SectionIII/Task11Tests.hs
test/SectionIV/Task7Tests.hs
test/runner/TestRunner.hs
test/runner/Main.hs
report/SectionIA/task27-report.md
report/SectionIB/task65-report.md
report/SectionII/task2-report.md
report/SectionIII/task11-report.md
report/SectionIV/task7-report.md
ptp-haskell.cabal
cabal.project
```

## Build

```bash
cabal build
```

## Run tests

```bash
cabal test all-tests
```

## Run tests for one task

```bash
cabal test section-ia-task27-tests
cabal test section-ib-task65-tests
cabal test section-ii-task2-tests
cabal test section-iii-task11-tests
cabal test section-iv-task7-tests
```

## Run demo executable

```bash
cabal run ptp-haskell
```
