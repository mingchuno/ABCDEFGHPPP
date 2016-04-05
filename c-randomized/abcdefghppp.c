#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int x[9];

void randomize() {
    int i, j, y;
    for (i = 0; i < 9; i++) {
        x[i] = rand() % 10;
    }
}

int correct() {
    int i, vis[10], ab, cd, ef, gh, ppp;

    memset(vis, 0, sizeof(vis));
    for (i = 0; i < 9; i++) {
        if (vis[x[i]]) {
            return 0;
        }
        vis[x[i]] = 1;
    }

    ab = x[0] * 10 + x[1];
    cd = x[2] * 10 + x[3];
    ef = x[4] * 10 + x[5];
    gh = x[6] * 10 + x[7];
    ppp = x[8] * 111;
    return (ab - cd) == ef && (ef + gh) == ppp;
}

void init() {
    srand(time(0));
    randomize();
}

int main() {
    int t = 0;

    init();
    // with this number of trials, there is 99.9978% chance returning an answer ;)
    for (t = 1; !correct() && t > 0; t++) {
        randomize();
    }

    if (correct()) {
        printf("Answer found at #%d trial%s.\n", t, t == 1 ? "": "s");
        printf(
            "%1$d%2$d - %3$d%4$d = %5$d%6$d, %5$d%6$d + %7$d%8$d = %9$d%9$d%9$d\n",
            x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[7], x[8]
        );
    } else {
        puts("I'm too stupid.");
    }

    return 0;
}
