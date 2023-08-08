#include <iostream>
#include <string>

int main(int argc, char** argv)
{
    if (argc == 2 && argv[1] == std::string("-h")) {
        std::cout << "Usage: " << argv[0] << std::endl;
        return (0);
    }
    return (0);
}
