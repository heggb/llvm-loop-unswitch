#include <vector>
#include <cstddef>

void bar(std::vector<int>& v, int flag) {
    for (size_t i = 0; i < v.size(); i++) {
        if (flag)
            v.at(i) += 1;  // может бросить std::out_of_range
        else
            v.at(i) -= 1;
    }
}
