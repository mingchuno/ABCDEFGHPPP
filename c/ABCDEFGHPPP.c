#include <stdio.h>
#include <string.h>

int vis[10];

int valid(int x) {
    int y = x % 10;
    int z = x / 10;
    return x >= 10 && x < 100 && !(y == z || vis[y] || vis[z]);
}

int use(int x) {
    return valid(x) && (vis[x % 10] = vis[x / 10] = 1);
}

void unuse(int x) {
    vis[x % 10] = vis[x / 10] = 0;
}

void reset() {
    memset(vis, 0, sizeof(vis));
    vis[1] = 1;
}

int main() {
    int ab, cd, ef, gh;

    reset();
    for (ab = 20; ab < 100; ab++) if (use(ab)) {
        for (cd = 20; cd < ab; cd++) if (use(cd)) {
            ef = ab - cd;
            gh = 111 - ef;

            if (use(ef)) {
                if (use(gh)) {
                    printf("%d - %d = %d, %d + %d = 111\n", ab, cd, ef, ef, gh);
                    unuse(gh);
                }
                unuse(ef);
            }
            unuse(cd);
        }
        unuse(ab);
    }

    return 0;
}
