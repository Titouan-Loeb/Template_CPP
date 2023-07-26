# Template_C++
New C++ project

## Requirements

To compile and execute this program you will need to have a cpp compiler (g++) and the command make installed as well

## Compile
The program **compiles** using make file, to compile run the following command:

```bash
make # Compile everything that is necessary
# Or
make re # Re-compile everything
```

You can **remove the build files** using the clean command as followed:

```bash
make clean # Remove all build files
```

Once you are done with the project you can **remove the binary and the build files** using the fclean command as followed:

```bash
make fclean # remove all generated files
```

## Run

To see how the what arguments the program can take execute the generated binary with the "-h" parameter such as followed:

```bash
./bin/binary -h # display help
```

To the program run the following command (dont forget to respect the arguments required):

```bash
./bin/binary [optional_arguments, ...]
```