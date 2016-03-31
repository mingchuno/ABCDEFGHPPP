#lang scheme
(define (pass-rule1? answer) ;answer pass-rule1? AB - CD = EF
  (cond ((< (length answer) 6) #t)
        (else (let ((a (list-ref answer 0))
                    (b (list-ref answer 1))
                    (c (list-ref answer 2))
                    (d (list-ref answer 3))
                    (e (list-ref answer 4))
                    (f (list-ref answer 5)))
                (= (- (+ (* a 10) b) (+ (* c 10) d)) (+ (* e 10) f)))))) 
(define (pass-rule2? answer) ;answer pass-rule2? EF + GH = PPP ( 100P + 10P + P = 111P)
  (cond ((< (length answer) 9) #t)
        (else (let ((e (list-ref answer 4))
                    (f (list-ref answer 5))
                    (g (list-ref answer 6))
                    (h (list-ref answer 7))
                    (p (list-ref answer 8)))
                (= (+ (+ (* e 10) f) (+ (* g 10) h)) (* 111 p))))))
(define (find n m answer) ;find answer list (A B C D E F G H P)
  (cond ((= n 9)(display answer)(newline)) 
        ((= m 10))
        ((and (= m 0) (even? n)) (find n 1 answer)) ;A,C,E,G,P != 0
        (else (cond ((memv m answer)) ;each digi appears onlly once
                    ((not (pass-rule1? (append answer (list m)))))
                    ((not (pass-rule2? (append answer (list m)))))
                    (else (find (+ n 1) 0 (append answer (list m)))))
              (find n (+ m 1) answer))))

(time (find 0 0 '()))