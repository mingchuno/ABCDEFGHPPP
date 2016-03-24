#include <cstdio>
#include <algorithm>

using namespace std;

#define X(a,b) (x[a]*10+x[b])

int main() {
    int x[] = { 0, 2, 3, 4, 5, 6, 7, 8, 9 };
    do {
        int ab = X(0, 1), cd = X(2, 3), ef = X(4, 5), gh = X(6, 7);
        if ((ab - cd) == ef && (ef + gh) == 111) {
            printf("%02d + %02d = %02d, %02d - %02d = 111\n", ab, cd, ef, ef, gh);
        }
    } while (next_permutation(x, x + 9));

    return 0;
}
