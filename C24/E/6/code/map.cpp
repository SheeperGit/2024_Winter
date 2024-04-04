#include <iostream>
#include <vector>
#include <algorithm>
////////////////////////////////////////////////////////////////////////////////
//////////// To Run this File //////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*                                                                      ////////
    Prerequisites: A C++ Compiler (we will be using g++)                ////////
                                                                        ////////
    1. Download `map.cpp`                                               ////////
    2. Open up a terminal and navigate to the directory of `map.cpp`    ////////
    3. Type: g++ map.cpp                                                ////////
    4.                                                                  ////////
        4a. If on Linux, type: ./a.out                                  ////////
        4b. If on Windows, type: a.exe                                  ////////
*/                                                                      ////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

int square(int x) {
    return x * x;
}

int main() {
    std::vector<int> nums = {1, 2, 3, 4, 5};

    std::transform(nums.begin(), nums.end(), nums.begin(), square);
    for (int num : nums) {
        std::cout << num << " ";
    }

    std::cout << std::endl;

    return 0;
}

