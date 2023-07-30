# Compiler and flags
CXX := g++
CXXFLAGS := -std=c++11 -Wall -Wextra
SRCDIR := src
INCDIR := include
BUILDDIR := build
BINDIR := bin
TARGET := $(BINDIR)/myProgram

# Find all source files in the src directory and its subdirectories
SOURCES := $(shell find $(SRCDIR) -type f -name "*.cpp")

# Derive object file names from source file names and place them in the build directory
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.cpp=.o))

# Include directories for header files (including subdirectories)
INCLUDES := -I$(INCDIR) $(shell find $(INCDIR) -type d | sed 's/^/-I/')

# Colors for terminal output
GREEN := \033[1;32m
CYAN := \033[1;36m
RESET := \033[0m

all: $(BINDIR) $(TARGET)

$(BINDIR):
	@mkdir -p $(BINDIR)

# Rule to build the target
$(TARGET): $(OBJECTS)
	@echo "$(CYAN)Linking$(RESET) $(GREEN)$@$(RESET)"
	@$(CXX) $(CXXFLAGS) $(INCLUDES) $^ -o $@

# Rule to build object files
$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	@mkdir -p $(@D)
	@echo "$(CYAN)Compiling$(RESET) $(GREEN)$<$(RESET)"
	@$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

clean:
	@echo "$(CYAN)Cleaning$(RESET) $(GREEN)build$(RESET) directory"
	@rm -rf $(BUILDDIR) $(OBJECTS)

fclean: clean
	@echo "$(CYAN)Cleaning$(RESET) $(GREEN)bin$(RESET) directory"
	@rm -rf $(TARGET) $(BINDIR)

re: fclean all

.PHONY: all clean fclean re
