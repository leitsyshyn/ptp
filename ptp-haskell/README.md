# PTP Haskell

This project contains the PTP Haskell assignment for:

- Section I-a, task 27
- Section I-b, task 65
- Section II, task 2

## Project structure

```text
app/Main.hs
src/Tasks.hs
src/SectionIA/Task27.hs
src/SectionIB/Task65.hs
src/SectionII/Task2.hs
test/SectionIA/Task27Tests.hs
test/SectionIB/Task65Tests.hs
test/SectionII/Task2Tests.hs
test/runner/TestRunner.hs
test/runner/Main.hs
report/SectionIA/task27-report.md
report/SectionIB/task65-report.md
report/SectionII/task2-report.md
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
```

## Run demo executable

```bash
cabal run ptp-haskell
```
