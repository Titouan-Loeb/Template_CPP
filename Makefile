# Compiler
CXX := g++
# Compiler flags
CXXFLAGS := -std=c++11 -Wall -Wextra
# Directories
SRCDIR := src
INCDIR := include
BUILDDIR := build
BINDIR := bin
# Target binary name
TARGET := $(BINDIR)/my_program

# Get a list of all .cpp files in the src directory
SRC := $(wildcard $(SRCDIR)/*.cpp)
# Generate the object file names from the source file names
OBJ := $(patsubst $(SRCDIR)/%.cpp,$(BUILDDIR)/%.o,$(SRC))
# Set the include directories for the compiler
CXXFLAGS += -I$(INCDIR)

# Colors for terminal output
GREEN := \033[1;32m
CYAN := \033[1;36m
RESET := \033[0m

# The default target builds the executable
all: $(TARGET)

# Rule to build the executable
$(TARGET): $(OBJ)
	@mkdir -p $(BINDIR)
	@echo "$(CYAN)Linking$(RESET) $(GREEN)$@$(RESET)"
	@$(CXX) $(CXXFLAGS) -o $@ $^

# Rule to build object files from source files
$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	@mkdir -p $(BUILDDIR)
	@echo "$(CYAN)Compiling$(RESET) $(GREEN)$<$(RESET)"
	@$(CXX) $(CXXFLAGS) -c -o $@ $<

# Clean up the build files
clean:
	@echo "$(CYAN)Cleaning$(RESET) $(GREEN)build$(RESET) directory"
	@rm -rf $(BUILDDIR)

# Clean up all build files and the executable
fclean: clean
	@echo "$(CYAN)Cleaning$(RESET) $(GREEN)bin$(RESET) directory"
	@rm -rf $(BINDIR)

# Rebuild the project from scratch
re: fclean all

# .PHONY target to ensure the rules are always executed
.PHONY: all clean fclean