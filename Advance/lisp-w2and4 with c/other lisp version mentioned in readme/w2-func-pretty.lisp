(DECLAIM (OPTIMIZE (SPEED 3)
           (COMPILATION-SPEED 0)
           (SAFETY 0)
           (DEBUG 0)))
(DEFVAR *base* 10)
(DEFVAR *ppp* 0) ; why 111, set below?
(DEFVAR all-answers NIL)
(DEFPARAMETER *max-no-print-solutions* 50)
(DEFPARAMETER *req-no-numbers-in-answers* 8)

(DEFUN NOT-FAIL-RULE1? (answer len-answer candidate-num)
  (IF (= len-answer  7)
      (LET ((B (NTH 0 answer))
        (C (NTH 1 answer))
        (D (NTH 2 answer))
        (E (NTH 3 answer))
        (F (NTH 4 answer)))
       (= (- (+ (* candidate-num *base*) B) 
       	     (+ (* C *base*) D)) 
          (+ (* E *base*) F)))
      T))

(DEFUN NOT-FAIL-RULE2? (answer len-answer candidate-num)
  (IF (= len-answer  3)
      (LET ((F (NTH 0 answer))
        (G (NTH 1 answer))
        (H (NTH 2 answer)))
       (= (+ (+ (* candidate-num *base*) F) 
       	     (+ (* G *base*) H)) 
          *ppp*))
      T))

(DEFUN R-SEARCH (answer len-answer  candidate-num) 
          ; beware it is (h) (g h) 
          ; (f g h)         (rule of 3) to check e
          ; (b c d e f g h) (rule of 7) to check a

  (COND 
  	((= len-answer  *req-no-numbers-in-answers*)   
  		           (SETF all-answers (CONS answer all-answers))) ; really add to answer-sets and drop
    ((= candidate-num *base*)                                  ) ; already in, drop
    ((AND (= candidate-num 0) 
    	  (ODDP len-answer))   (R-SEARCH answer len-answer  2) ) 
    	                    ; strange but because reverse insert order from h then g
    	                    ; when len-answer is 1 h is in and we are considering g
    	                    ; hence not allow 0 as gh not allow 0h 
    						; could drop but skip instead
    ((= candidate-num 1)       (R-SEARCH answer len-answer  2) ) ; cannot be 1 and could drop but skip instead
    (T (COND 
    	 ((MEMBER candidate-num answer)                             ) ; already in, drop
         ((NOT (NOT-FAIL-RULE1? answer len-answer candidate-num))   ) ; confirm fail, drop
         ((NOT (NOT-FAIL-RULE2? answer len-answer candidate-num))   ) ; confirm fail , drop
         (T (R-SEARCH (CONS candidate-num answer) (+ len-answer  1) 0))) 
                      ; unique ans not yet fail, add to answer list to try
                      ; and try other candidate number from 0
       (R-SEARCH answer len-answer  (+ candidate-num 1)))))
                 ; the above take the answer but
                 ; here assume move to next candidate number  

(DEFUN INTERACTIVE-SEARCH ()
  (SETF *base* (READ))
  (SETF *ppp* (+ (* *base* *base*) *base* 1))
  (SETF all-answers NIL)
  (TIME (R-SEARCH NIL 0 0)))

(DEFUN BASE-N (base-num)
  (SETF *base* base-num)
  (SETF *ppp* (+ (* base-num base-num) base-num 1))
  (SETF all-answers NIL)
  (TIME (R-SEARCH NIL 0 0))

  (FORMAT T "BASE:~A answer:~A~%~%~%" *base* (LENGTH all-answers)) 
  (DO ((N 1 (+ N 1)))
      ((> N  (min *max-no-print-solutions* (LENGTH all-answers))))
        ;(FORMAT T "~A: ~A~%" len-answer  (NTH (RANDOM (LENGTH all-answers)) all-answers))
        (FORMAT T "~A: ~A~%" N (NTH (- (LENGTH all-answers) N ) all-answers))) 
                                             ;;; why call the function length all-answers
                                             ;;; got old N or here len-answer
  (PRINT '++++++++++++++++++++++++++++++++++++++++++++++++++)
  (PRINT "")   
  (PRINT ""))

(BASE-N 10)
(BASE-N 16)
(BASE-N 22)
(BASE-N 28)
(BASE-N 34)