#![feature(slice_patterns)]

/*

$ cargo -V
cargo 0.10.0-nightly (2eade62 2016-03-04)

$ rustc -V
rustc 1.9.0-nightly (e91f889ed 2016-03-03)

*/

extern crate permutohedron;
extern crate itertools;

use permutohedron::Heap;
use itertools::Itertools;
use std::iter::once;

fn main() {
    // we use the short-cut that ppp must be 111. so we just need to find a~h as permutation of 0~9
    // excluding 1.

    for mut combinations in once(0).chain(2..10).combinations_n(8) {
        for permutations in Heap::new(&mut combinations) {
            if let [a,b,c,d,e,f,g,h] = permutations.as_slice() {
                let ab = 10*a + b;
                let cd = 10*c + d;
                let ef = 10*e + f;
                let gh = 10*g + h;
                if ab < 10 || cd < 10 || ef < 10 || gh < 10 {
                    continue;
                }
                if ab - cd == ef && ef + gh == 111 {
                    print!("{: >5}\n-{: >4}\n=====\n{: >5}\n+{: >4}\n=====\n  111\n\n\n", ab, cd, ef, gh);
                }
            }
        }
    }
}

