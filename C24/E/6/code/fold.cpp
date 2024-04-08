#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
////////////////////////////////////////////////////////////////////////////////
//////////// To Run this File //////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*                                                                      ////////
    Prerequisites: A C++ Compiler (we will be using g++)                ////////
                                                                        ////////
    1. Download `fold.cpp`                                              ////////
    2. Open up a terminal and navigate to the directory of `fold.cpp`   ////////
    3. Type: g++ fold.cpp                                               ////////
    4.                                                                  ////////
        4a. If on Linux, type: ./a.out                                  ////////
        4b. If on Windows, type: a.exe                                  ////////
*/                                                                      ////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

int sum(int x, int y) {
    std::cout << x << "+" << y << std::endl;    // Prints the order of evaluations
    return x + y;
}

int sub(int x, int y) {
    std::cout << x << "-" << y << std::endl;    // Prints the order of evaluations
    return x - y;
}

// Same as sub() w/ operands swapped //
int rev_sub(int x, int y) {
    std::cout << y << "-" << x << std::endl;    // Prints the order of evaluations
    return y - x;
}

int main() {
    std::vector<int> nums = {1, 2, 3, 4, 5};

    int sumRes = std::accumulate(nums.begin(), nums.end(), 0, sum);     // EQV to foldl (+) 0 nums
    std::cout << "sum: " << sumRes << std::endl;

    int diff = std::accumulate(nums.begin(), nums.end(), 0, sub);       // EQV to foldl (-) 0 nums
    std::cout << "diff: " << diff << std::endl;

    int rev_diff = std::accumulate(std::next(nums.rbegin()), nums.rend(), nums[nums.size() - 1], rev_sub);  // EQV to foldr (-) 0 nums
    std::cout << "rev_diff: " << rev_diff << std::endl;

    return 0;
}