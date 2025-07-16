# Testing Strategy for the CardDemo Application

This document outlines the testing methodology and thought process used to create the first unit test for the CardDemo application.

## Overview

The testing strategy for this COBOL application is based on a classic unit testing framework that includes a test runner, the program under test, and a `Makefile` to automate the process. To handle external dependencies that are unavailable in the local development environment, this framework uses mock subroutines.

## Directory Structure

-   `test/`: This directory contains all the files related to testing, including test drivers and mock subroutines.
-   `out/`: This directory is automatically created during the test run and stores the compiled object files (`.o`) and the final test executable.

## Key Files

-   `Makefile`: This is the heart of the test automation. It defines how to compile the source files, link them, and run the tests. It is designed to be extensible for future test cases.

-   `test/TCSUTLD1.cbl`: This is the test driver program. It contains a series of test cases that define specific inputs and their expected outcomes. For each test case, it calls the program being tested, compares the actual result to the expected result, and reports whether the test passed or failed.

-   `app/cbl/CSUTLDTC.cbl`: This is the program being tested. For our initial test, we chose this program because it is a small, self-contained utility, making it an ideal candidate for a unit test.

-   `test/CEEDAYS.cbl`: This is a "mock" subroutine. The `CSUTLDTC.cbl` program depends on a mainframe-specific subroutine called `CEEDAYS`. Since this is not available in the local GnuCOBOL environment, we created this mock version to simulate its behavior. This allows us to test `CSUTLDTC.cbl` in isolation.

## How to Run Tests

To run the tests, simply execute the following command from the root of the project:

```sh
make test
```

If you have a specific COBOL compiler you need to use, you can specify it with the `COBC` variable:

```sh
make test COBC=/path/to/your/cobc
```

## Thought Process for Creating the Initial Test

1.  **Analyze the Application:** The first step was to understand the application's structure. The `README.md` and the file layout showed a typical mainframe application with COBOL programs, JCL, and other related files.

2.  **Select a Test Candidate:** I looked for a program that was simple, had clear inputs and outputs, and had minimal dependencies. `CSUTLDTC.cbl` fit these criteria perfectly. It's a date validation utility, which is a classic example of a function that can be easily unit-tested.

3.  **Initial Test Attempt and Challenges:** My first attempt to compile the program and a test driver failed because of a missing dependency: the `CEEDAYS` subroutine. This is a common problem when testing mainframe applications in a distributed environment.

4.  **The Mocking Solution:** To overcome the missing dependency, I used the mocking technique. I created a fake `CEEDAYS` subroutine that returns the exact values needed to test the different logic paths in `CSUTLDTC.cbl`. This is a powerful technique because it allows you to test programs in isolation, without needing to set up a complex environment with all the real dependencies.

5.  **Refining the `Makefile`:** The `Makefile` went through several iterations. Initially, it had issues with linker errors and platform incompatibilities (macOS vs. Linux). The final version is more robust and clearly separates the compilation of each component (the test driver, the program under test, and the mock) before linking them into a single executable.

6.  **Debugging and Final Success:** The final hurdle was a simple off-by-one error in the test driver, where it was checking the wrong position in the output string. Once this was corrected, all the test cases passed, and the unit test was complete.

## Adding New Tests

To add a new unit test, you can follow this pattern:

1.  Create a new test driver program in the `test/` directory.
2.  If the program you're testing has dependencies, create mock versions of them in the `test/` directory.
3.  Update the `Makefile` to include the new test driver and any new mocks in the compilation and linking process.
