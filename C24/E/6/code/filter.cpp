#include <iostream>
#include <vector>
#include <algorithm>
////////////////////////////////////////////////////////////////////////////////
//////////// To Run this File //////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*                                                                      ////////
    Prerequisites: A C++ Compiler (we will be using g++)                ////////
                                                                        ////////
    1. Download `filter.cpp`                                            ////////
    2. Open up a terminal and navigate to the directory of `filter.cpp` ////////
    3. Type: g++ filter.cpp                                             ////////
    4.                                                                  ////////
        4a. If on Linux, type: ./a.out                                  ////////
        4b. If on Windows, type: a.exe                                  ////////
*/                                                                      ////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

bool biggerThanThree(int x) {
    return x > 3;
}

bool isEven(int x) {
    return x % 2 == 0;
}

int main() {
    std::vector<int> nums = {1, 2, 3, 4, 5};
    std::vector<int> result;

    std::copy_if(nums.begin(), nums.end(), std::back_inserter(result), biggerThanThree);
    std::cout << "biggerThanThree: ";
    for (int num : result) {
        std::cout << num << " ";
    }

    std::cout << std::endl;
    result.clear();

    std::copy_if(nums.begin(), nums.end(), std::back_inserter(result), isEven);
    std::cout << "isEven: ";
    for (int num : result) {
        std::cout << num << " ";
    }

    std::cout << std::endl;

    return 0;
}

