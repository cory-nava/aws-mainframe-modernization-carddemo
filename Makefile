# Compiler
COBC ?= cobc

# Directories
OBJECTS_DIR = out
TEST_DIR = test
APP_CBL_DIR = app/cbl

# Test-specific files
TEST_RUNNER_SRC = $(TEST_DIR)/TCSUTLD1.cbl
TEST_TARGET_SRC = $(APP_CBL_DIR)/CSUTLDTC.cbl
MOCK_CEEDAYS_SRC = $(TEST_DIR)/CEEDAYS.cbl

# We only need an object file for the subroutines
TEST_TARGET_OBJ = $(OBJECTS_DIR)/CSUTLDTC.o
MOCK_CEEDAYS_OBJ = $(OBJECTS_DIR)/CEEDAYS.o

TEST_BIN = $(OBJECTS_DIR)/test_runner

.PHONY: test clean

# Default target: run the tests
test: $(TEST_BIN)
	./$(TEST_BIN)

# Link the test executable
$(TEST_BIN): $(TEST_RUNNER_SRC) $(TEST_TARGET_OBJ) $(MOCK_CEEDAYS_OBJ)
	@mkdir -p $(@D)
	$(COBC) -x -free -o $@ $^

# Compile the program to be tested (fixed format)
$(TEST_TARGET_OBJ): $(TEST_TARGET_SRC)
	@mkdir -p $(@D)
	$(COBC) -c -fixed -o $@ $<

# Compile the mock CEEDAYS (free format)
$(MOCK_CEEDAYS_OBJ): $(MOCK_CEEDAYS_SRC)
	@mkdir -p $(@D)
	$(COBC) -c -free -o $@ $<

# Clean compiled objects and binaries
clean:
	rm -rf $(OBJECTS_DIR)
