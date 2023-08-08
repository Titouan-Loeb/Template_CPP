###############
## Variables ##
###############

# Compiler and flags
CXX := g++
# Flags for the compiler
CXXFLAGS := -std=c++20 -Wall -Wextra
CXXFLAGS_RELEASE := $(CXXFLAGS) -O3
CXXFLAGS_DEBUG := $(CXXFLAGS) -g
CRITERION_FLAGS := -lcriterion

# Directories
SRC_DIR := src
INC_DIR := include
BASE_BUILD_DIR := build
BUILD_DIR := $(BASE_BUILD_DIR)/obj
BUILD_RELEASE_DIR := $(BASE_BUILD_DIR)/release
BUILD_DEBUG_DIR := $(BASE_BUILD_DIR)/debug
BUILD_TEST_DIR := $(BASE_BUILD_DIR)/test
BIN_DIR := bin
TEST_DIR := test

# Target executable names
BIN_NAME := [BINARY_NAME]
TARGET := $(BIN_DIR)/$(BIN_NAME)
TARGET_RELEASE := $(BIN_DIR)/$(BIN_NAME)-release
TARGET_DEBUG := $(BIN_DIR)/$(BIN_NAME)-debug
TARGET_TEST := $(BIN_DIR)/$(BIN_NAME)-test

# Find all source files in the src directory and its subdirectories
SOURCES := $(shell find $(SRC_DIR) -type f -name "*.cpp")

# Find all source files in the src directory and its subdirectories
TESTS := $(shell find $(TEST_DIR) -type f -name "*.cpp")
TEST_SOURCES := $(filter-out $(SRC_DIR)/Main.cpp, $(SOURCES))

# Derive object file names from source file names and place them in the build directory
OBJECTS := $(patsubst $(SRC_DIR)/%,$(BUILD_DIR)/%,$(SOURCES:.cpp=.o))
OBJECTS_RELEASE := $(patsubst $(SRC_DIR)/%,$(BUILD_RELEASE_DIR)/%,$(SOURCES:.cpp=.o))
OBJECTS_DEBUG := $(patsubst $(SRC_DIR)/%,$(BUILD_DEBUG_DIR)/%,$(SOURCES:.cpp=.o))
OBJECTS_TEST_SOURCES := $(patsubst $(SRC_DIR)/%,$(BUILD_DIR)/%,$(TEST_SOURCES:.cpp=.o))
OBJECTS_TEST := $(patsubst $(TEST_DIR)/%,$(BUILD_TEST_DIR)/%,$(TESTS:.cpp=.o))

# Include directories for header files (including subdirectories)
INCLUDES := -I$(INC_DIR) $(shell find $(INC_DIR) -type d | sed 's/^/-I/')

# Colors for terminal output
GREEN := \033[1;32m
CYAN := \033[1;36m
RESET := \033[0m


#######################
## Compilation rules ##
#######################

# Default rule
build: $(TARGET)

# Rule to build the target
$(TARGET): $(OBJECTS)
	@mkdir -p $(BIN_DIR)
	@echo "$(CYAN)Linking$(RESET) $(GREEN)$@$(RESET)"
	@$(CXX) $(CXXFLAGS) $(INCLUDES) $^ -o $@

# Rule to build object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	@echo "$(CYAN)Compiling$(RESET) $(GREEN)$<$(RESET)"
	@$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

debug: $(TARGET_DEBUG)

# Rule to build the target in release mode
$(TARGET_DEBUG): $(OBJECTS_DEBUG)
	@mkdir -p $(BIN_DIR)
	@echo "$(CYAN)Linking --debug$(RESET) $(GREEN)$@$(RESET)"
	@$(CXX) $(CXXFLAGS_DEBUG) $(INCLUDES) $^ -o $@

# Rule to build object files
$(BUILD_DEBUG_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	@echo "$(CYAN)Compiling --debug$(RESET) $(GREEN)$<$(RESET)"
	@$(CXX) $(CXXFLAGS_DEBUG) $(INCLUDES) -c $< -o $@

# release: CXXFLAGS += $(CXXFLAGS_RELEASE)
release: $(TARGET_RELEASE)

# Rule to build the target in release mode
$(TARGET_RELEASE): $(OBJECTS_RELEASE)
	@mkdir -p $(BIN_DIR)
	@echo "$(CYAN)Linking --release$(RESET) $(GREEN)$@$(RESET)"
	@$(CXX) $(CXXFLAGS_RELEASE) $(INCLUDES) $^ -o $@

# Rule to build object files in release mode
$(BUILD_RELEASE_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	@echo "$(CYAN)Compiling --release$(RESET) $(GREEN)$<$(RESET)"
	@$(CXX) $(CXXFLAGS_RELEASE) $(INCLUDES) -c $< -o $@

# Rule to build and run tests
test: $(TARGET_TEST)
	@echo "$(CYAN)Running tests$(RESET)"
	@./$(TARGET_TEST) --verbose

# Rule to build the test executable
$(TARGET_TEST): $(OBJECTS_TEST_SOURCES) $(OBJECTS_TEST)
	@mkdir -p $(BIN_DIR)
	@echo "$(CYAN)Linking tests$(RESET) $(GREEN)$@$(RESET)"
	@$(CXX) $(CXXFLAGS) $(INCLUDES) $(CRITERION_FLAGS) $^ -o $@

# Rule to build object files for tests
$(BUILD_TEST_DIR)/%.o: $(TEST_DIR)/%.cpp
	@mkdir -p $(@D)
	@echo "$(CYAN)Compiling test$(RESET) $(GREEN)$<$(RESET)"
	@$(CXX) $(CXXFLAGS) $(CRITERION_FLAGS) $(INCLUDES) -c $< -o $@

re: fclean build

all: build debug release test

full: fclean all


####################
## Cleaning rules ##
####################

# Clean the build directory
clean:
	@echo "$(CYAN)Cleaning$(RESET) $(GREEN)build$(RESET) directory"
	@rm -rf $(BASE_BUILD_DIR)

# Clean the build directory and the bin directory
fclean: clean
	@echo "$(CYAN)Cleaning$(RESET) $(GREEN)bin$(RESET) directory"
	@rm -rf $(TARGET) $(BIN_DIR)


###################
## Running rules ##
###################

# Run the program
run:
	@echo "$(CYAN)Running$(RESET) $(GREEN)$(TARGET)$(RESET)"
	@$(TARGET)

# Run in debug mode
run-debug:
	@echo "$(CYAN)Running --debug$(RESET) $(GREEN)$(TARGET_DEBUG)$(RESET)"
	@valgrind $(TARGET_DEBUG)

# Run in release mode
run-release:
	@echo "$(CYAN)Running --release$(RESET) $(GREEN)$(TARGET_RELEASE)$(RESET)"
	@$(TARGET_RELEASE)

# Run tests
run-test:
	@echo "$(CYAN)Running tests$(RESET) $(GREEN)$(TARGET_TEST)$(RESET)"
	@$(TARGET_TEST)

.PHONY: build debug release test all full clean fclean re run run-release run-debug run-test