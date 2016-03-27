#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int mkInt(vector<int> &v) {
    int ret = 0;
    for (vector<int>::iterator it = v.begin(); it != v.end(); ++it) {
        ret = ret * 10 + *it;
    }
    return ret;
}

int main() {
    int init_x[] = { 0, 2, 3, 4, 5, 6, 7, 8, 9 };
    vector<int> x = vector<int>(init_x, init_x + 9);
    do {
        vector<int> vec_ab = vector<int>(x.begin() + 0, x.begin() + 2);
        vector<int> vec_cd = vector<int>(x.begin() + 2, x.begin() + 4);
        vector<int> vec_ef = vector<int>(x.begin() + 4, x.begin() + 6);
        vector<int> vec_gh = vector<int>(x.begin() + 6, x.begin() + 8);

        int ab = mkInt(vec_ab), cd = mkInt(vec_cd), ef = mkInt(vec_ef), gh = mkInt(vec_gh);
        if ((ab >= 10 && cd >= 10 && ef >= 10 && gh >= 10) && (ab - cd) == ef && (ef + gh) == 111) {
            cout << ab << " - " << cd << " = " << ef << ", " << ef << " + " << gh << " = 111" << endl;
        }
    } while (next_permutation(x.begin(), x.end()));

    return 0;
}
