(DECLAIM (OPTIMIZE (SPEED 3)
           (COMPILATION-SPEED 0)
           (SAFETY 1)
           (DEBUG 3)))

(defun fib (n)
  (do ((i  n (- i 1))
       (f1 1 (+ f1 f2))
       (f2 1 f1))
      ((<= i 1) f1)))

(time (fib 5))
(trace fib)
(fib 5)
