#include <stdio.h>
#include <string.h>

int vis[10];

int valid(int x) {
    int y = x % 10;
    int z = x / 10;
    return x >= 10 && x < 100 && !(y == z || vis[y] || vis[z]);
}

void use(int x) {
    vis[x % 10] = 1;
    vis[x / 10] = 1;
}

void unuse(int x) {
    vis[x % 10] = 0;
    vis[x / 10] = 0;
}

void abcd(int ef, int gh) {
    int ab, cd;
    for (cd = 10; cd < 100; cd++) if (valid(cd)) {
        use(cd);
        ab = cd + ef;
        if (valid(ab)) {
            printf("%02d - %02d = %02d, %02d + %02d = %02d\n", ab, cd, ef, ef, gh, ef + gh);
        }
        unuse(cd);
    }
}

void efgh(int p) {
    int ppp = p * 111;
    int ef, gh;
    for (ef = 10; ef < 100; ef++) if (valid(ef)) {
        use(ef);
        gh = ppp - ef;
        if (valid(gh)) {
            use(gh);
            abcd(ef, gh);
            unuse(gh);
        }
        unuse(ef);
    }
}

int main() {
    int p;
    memset(vis, 0, sizeof(vis));
    for (p = 0; p < 10; p++) {
        vis[p] = 1;
        efgh(p);
        vis[p] = 0;
    }

    return 0;
}
