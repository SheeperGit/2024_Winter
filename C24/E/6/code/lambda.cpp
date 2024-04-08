#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <numeric>
////////////////////////////////////////////////////////////////////////////////
//////////// To Run this File //////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*                                                                      ////////
    Prerequisites: A C++ Compiler (we will be using g++)                ////////
                                                                        ////////
    1. Download `lambda.cpp`                                            ////////
    2. Open up a terminal and navigate to the directory of `lambda.cpp` ////////
    3. Type: g++ lambda.cpp                                             ////////
    4.                                                                  ////////
        4a. If on Linux, type: ./a.out                                  ////////
        4b. If on Windows, type: a.exe                                  ////////
*/                                                                      ////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

int main() {
    int x = 3;
    int y = 5;
    std::vector<int> nums = {1, 2, 3, 4, 5};
    std::vector<std::string> myStr = {"abcd", "e", "fghijk"};
    std::vector<int> result;

    std::copy_if(nums.begin(), nums.end(), std::back_inserter(result), [](int x) -> bool { return x > 3; } );
    std::cout << "biggerThanThree: ";
    for (int num : result) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    size_t totalSize = std::accumulate(myStr.begin(), myStr.end(), 0, [](size_t sum, const std::string& str) -> int { return sum + str.size(); });
    std::cout << "totalSize: " << totalSize << std::endl << std::endl;

    auto add = [x,y]() -> int { return x + y; };            // Instantiating the (pass-by-val) lambda
    auto sub = [&x,&y]() -> int { return x - y; };          // Instantiating the (pass-by-ref) lambda

    std::cout << "add() before: " << add() << std::endl;    // Setting up to show closures...
    std::cout << "sub() before: " << sub() << std::endl;    // Setting up to show closures don't work here...

    // Define a function that takes one argument and returns a lambda function //
    auto curried_add = [](int x) -> std::function<int(int)> {
        return [x](int y) -> int {
            return x + y;
        };
    };
    
    auto add_x = curried_add(x);
    std::cout << "curried_add: " << add_x(y) << std::endl;

    x = 1;
    y = 0;

    std::cout << "add() after: " << add() << std::endl;     // Yay! Closures!
    std::cout << "sub() after: " << sub() << std::endl;     // Oh no! Pass-by-ref means no closures!

    return 0;
}

