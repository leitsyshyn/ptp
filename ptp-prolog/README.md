# PTP Prolog

This project contains the Prolog versions of the same PTP tasks:

- Section I-a, task 27: keep elements with odd total frequency
- Section I-b, task 65: split a list into prime and non-prime numbers
- Section II, task 2: split a list into strictly increasing contiguous runs

## Requirements

- SWI-Prolog 10+

Installed in this environment with:

```bash
brew install swi-prolog
```

## Project structure

```text
src/tasks.pl
src/SectionIA/task27.pl
src/SectionIB/task65.pl
src/SectionII/task2.pl
test/runner/test_runner.pl
test/SectionIA/task27_tests.pl
test/SectionIB/task65_tests.pl
test/SectionII/task2_tests.pl
test/runner/main.pl
examples/demo.pl
report/SectionIA/task27-report.md
report/SectionIB/task65-report.md
report/SectionII/task2-report.md
README.md
```

## Predicate names

- `keep_odd_frequency_elements/2`
- `split_prime_nonprime/3`
- `split_increasing_runs/2`

The code uses snake_case names, one module per task, and a small custom test runner.
No external testing framework is used.

## Run tests

```bash
swipl -q -s test/runner/main.pl
swipl -q -s test/runner/main.pl -- section-ia-task27-tests
swipl -q -s test/runner/main.pl -- section-ib-task65-tests
swipl -q -s test/runner/main.pl -- section-ii-task2-tests
```

## Run demo

```bash
swipl -q -s examples/demo.pl
```

## Example interactive queries

Start SWI-Prolog in the project root:

```bash
swipl
```

Then load a task module and run queries:

```prolog
?- [src/'SectionIA/task27'].
true.

?- keep_odd_frequency_elements([1,1,1,2,2,3,4,4,4,4], Result).
Result = [1, 1, 1, 3].

?- [src/'SectionIB/task65'].
true.

?- split_prime_nonprime([11,4,5,0,17,18,-3,19,20,1], Primes, NonPrimes).
Primes = [11, 5, 17, 19],
NonPrimes = [4, 0, 18, -3, 20, 1].

?- [src/'SectionII/task2'].
true.

?- split_increasing_runs([5,4,2,8,3,1,6,9,5], Runs).
Runs = [[5], [4], [2, 8], [3], [1, 6, 9], [5]].
```
