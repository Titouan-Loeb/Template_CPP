# Template_C++
New C++ project

## Requirements

To compile and execute this program you will need to have a cpp compiler (g++) and the command make installed as well. You might need to install valgrind as the rule "make run-debug" (explained in the running section) uses it. If you want to run the test you will need to have the criterion library installed.

## Compiling

### Compilation rules
The program **compiles** using make file, there are different compilation rules:
- **make** or **make build**: Compiles the source files that are necessary in with no extra flags
- **make re**: Cleans the build and compiles the source files with no extra flags
- **make debug**: Compiles the source files with the -g flag
- **make release**: Compiles the source files with the -O3 flag
- **make test**: Compiles the source files and the test files but without the main and runs the tests
- **make all**: Compiles the build, debug, release and compiles and runs the tests 
- **make full**: Cleans the build and then compiles the build, debug, release and compiles and runs the tests 

All compilation rules are independent, they all have their own build folder and binary files so compiling one rule will not affect the others.

```bash
make
# or
make build
# or
make re
# or
make debug
# or
make release
# or
make test
# or
make all
# or
make full
```

### Cleaning rules

You can **remove the build files** using the clean command as followed:

```bash
make clean # Remove all build files and delte the build folder
```

Once you are done with the project you can **remove the binary and the build files** using the fclean command as followed:

```bash
make fclean # remove all generated files and folders
```

## Running

### Binary name and locaiton

All binary files are generated in the bin folder, specific compilation rules will generate different binary files all starting with the default binary name plus a dash followed by the name of the rule

*(example: [BINARY_NAME]-debug)*

### Running commands

The makefile include running commands that will run the binary files for you, the commands are as followed:

```bash
make run # run the [BINARY_NAME] file
make run-debug # run the [BINARY_NAME]-debug file with valgrind
make run-release # run the [BINARY_NAME]-release file
make run-test # run the [BINARY_NAME]-test file
```

You can also run the binary files manually, they are located in the bin folder and are named as followed:
- **[BINARY_NAME]**
- **[BINARY_NAME]-debug**
- **[BINARY_NAME]-release**
- **[BINARY_NAME]-test**

To see what arguments the program can take, execute the generated binary with the "-h" parameter such as followed:

```bash
./bin/[BINARY_NAME] -h # display help
```

For this project the program do not required any arguments so to run the program you can simply execute one of the following commands (don't forget the required and optional arguments if there are some):

```bash
./bin/[BINARY_NAME] # run the [BINARY_NAME] file
# or
valgrind ./bin/[BINARY_NAME]-debug # run the [BINARY_NAME]-debug file with valgrind
# or
./bin/[BINARY_NAME]-release # run the [BINARY_NAME]-release file
# or
./bin/[BINARY_NAME]-test # run the tests
```
