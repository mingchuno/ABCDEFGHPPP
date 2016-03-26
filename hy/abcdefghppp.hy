(import [itertools [permutations]]
        [itertools])

(defn check [tup-element]
   (let ([(, a b c d e f g h p) tup-element])
        (and (!= a 0) (!= c 0) (!= e 0) (!= g 0)
             (= (+ (* 10 e) f) (- (+ (* 10 a) b) (+ (* 10 c) d)))
             (= (* 111 p) (+ (+ (* 10 e) f) (+ (* 10 g) h)))))) 

(defn answer-list [a b c]
   (filter check (permutations (range a b) c)))

(defn show-answer [answer-element]
    (let ([(, a b c d e f g h p) answer-element])
         (print (+ (* 10 a) b) " - " (+ (* 10 c) d) " = " (+ (* 10 e) f) ", " 
                (+ (* 10 e) f) " + " (+ (* 10 g) h) " = " (* 111 p))))

;(print (list (answer-list 0 10 9)))
(for [i (answer-list 0 10 9)]
     (show-answer i))
