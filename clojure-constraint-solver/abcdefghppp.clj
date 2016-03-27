(ns constraint-prog.core
  (:require [clojure.core.logic :refer :all]
            [clojure.core.logic.fd :as fd])
  (:refer-clojure :exclude [==])
  (:gen-class))




(defn define-constraint [lo hi]
  (run* [q]
    (fresh [a b c d e f g h p]
      (fd/in a b c d e f g h p (fd/interval lo hi))
      (fd/distinct [a b c d e f g h p])
      (fd/eq
       (!= a 0)
       (!= c 0)
       (!= e 0)
       (!= g 0)
       (= (+ (* 10 e) f)
          (- (+ (* 10 a) b)
             (+ (* 10 c) d)))
       (= (* 111 p)
          (+ (+ (* 10 e) f)
             (+ (* 10 g) h))))
      (== q [a b c d e f g h p]))))


