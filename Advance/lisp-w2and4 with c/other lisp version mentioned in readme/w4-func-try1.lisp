(DECLAIM (OPTIMIZE (SPEED 3)
           (COMPILATION-SPEED 0)
           (SAFETY 0)
           (DEBUG 0)))
(DEFVAR *base* 0)
(DEFVAR *qqq* 0) ; why 111, set below?
(DEFVAR *all-answers* NIL)
(DEFPARAMETER *max-no-print-solutions* 50)
(DEFPARAMETER *req-no-numbers-in-answers* 16)

(DEFUN NOT-FAIL-RULE1? (answer len-answer candidate-num)
  (IF (= len-answer  (1- *req-no-numbers-in-answers*)) ; 15 i.e. ?bcd efgh ijkl mnop
      (LET (
        (B (NTH 0 answer))
        (C (NTH 1 answer))
        (D (NTH 2 answer))
        (E (NTH 3 answer))        
        (F (NTH 4 answer))
        (G (NTH 5 answer))
        (H (NTH 6 answer))
        (I (NTH 7 answer))        
        (J (NTH 8 answer))
        (K (NTH 9 answer))
        (L (NTH 10 answer)))
        (= (- (+ (* (+ (* (+ (* candidate-num *base*) B) *base*) C) *base*) D) 
       	      (+ (* (+ (* (+ (* E             *base*) F) *base*) G) *base*) H)) 
              (+ (* (+ (* (+ (* I             *base*) J) *base*) K) *base*) L)))
      T))

(DEFUN NOT-FAIL-RULE2? (answer len-answer candidate-num)
  (IF (= len-answer  7)
      (LET (      
        (J (NTH 0 answer))
        (K (NTH 1 answer))
        (L (NTH 2 answer))
        (M (NTH 3 answer))        
        (N (NTH 4 answer))
        (O (NTH 5 answer))
        (P (NTH 6 answer)))
        (= (+ (+ (* (+ (* (+ (* candidate-num *base*) J) *base*) K) *base*) L) 
              (+ (* (+ (* (+ (* M             *base*) N) *base*) O) *base*) P) ) 
          *qqq*))
      T))

(DEFUN R-SEARCH (answer len-answer  candidate-num) 
          ; beware it is (h) (g h) 
          ; (f g h)         (rule of 3) to check e
          ; (b c d e f g h) (rule of 7) to check a

  (COND 
  	((= len-answer  *req-no-numbers-in-answers*)   
  		           (SETF *all-answers* (CONS answer *all-answers*))) ; really add to answer-sets and drop
    ((= candidate-num *base*)                                  ) ; already in, drop
    ((AND (= candidate-num 0) 
    	    (= (MOD len-answer 4) 3)   (R-SEARCH answer len-answer  2) )) 
    	                    ; strange but because reverse insert order from h then g
    	                    ; when len-answer is 1 h is in and we are considering g
    	                    ; hence not allow 0 as gh not allow 0h 
    						; could drop but skip instead
    ((= candidate-num 1)       (R-SEARCH answer len-answer  2) ) ; cannot be 1 and could drop but skip instead
    (T (COND 
    	   ((MEMBER candidate-num answer)                                ) ; already in, drop
         ((NOT (NOT-FAIL-RULE1? answer len-answer candidate-num))      ) ; confirm fail, drop
         ((NOT (NOT-FAIL-RULE2? answer len-answer candidate-num))      ) ; confirm fail , drop
         (T (R-SEARCH (CONS candidate-num answer) (+ len-answer  1) 0))) 
                      ; unique ans not yet fail, add to answer list to try
                      ; and try other candidate number from 0
       (R-SEARCH answer len-answer  (+ candidate-num 1)))))
                 ; the above take the answer but
                 ; here assume move to next candidate number  

(DEFUN INTERACTIVE-SEARCH ()
  (SETF *base* (READ))
  (SETF *qqq* (+ (* *base* *base* *base* *base*) (* *base* *base* *base*) (* *base* *base*) *base* 1))
  (SETF *all-answers* NIL)
  (TIME (R-SEARCH NIL 0 0)))

(DEFUN BASE-N (base-num)
  (SETF *base* base-num)
  (SETF *qqq* (+ (* *base* *base* *base* *base*) (* *base* *base* *base*) (* *base* *base*) *base* 1))
  (SETF *all-answers* NIL)
  (TIME (R-SEARCH NIL 0 0))

  (FORMAT T "BASE:~A answer:~A~%~%~%" *base* (LENGTH *all-answers*)) 
  (DO ((N 1 (+ N 1)))
      ((> N  (min *max-no-print-solutions* (LENGTH *all-answers*))))
        ;(FORMAT T "~A: ~A~%" len-answer  (NTH (RANDOM (LENGTH *all-answers*)) *all-answers*))
        (FORMAT T "~A: ~A~%" N (NTH (- (LENGTH *all-answers*) N ) *all-answers*))) 
                                             ;;; why call the function length *all-answers*
                                             ;;; got old N or here len-answer
  (FORMAT t "~%++++++++++++++++++++++++++++++++++++++++++++++++++~%~%~%"))

(BASE-N 17)
(BASE-N 21)
(BASE-N 25)
(BASE-N 29)


