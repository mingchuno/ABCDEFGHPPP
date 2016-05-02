(DECLAIM (OPTIMIZE (SPEED 3)
           (COMPILATION-SPEED 0)
           (SAFETY 0)
           (DEBUG 0)))
(defvar *no_of_solutions* 0)
(defparameter *no_of_solutions_to_print* 51)
(defparameter *q* 1)
(defvar *11111* 0)
 
(defun number_seq-uniquef (startno_s endno_s &rest rest) 
    (loop for i from startno_s to endno_s 
          unless (member i rest) ; not sure need to test '() case
           collect i)) 

; macroexpand-1 '(f (number_seq-unique 0 (- base 1) e 1)) 


(defmacro number_seq-m (startno_s endno_s) 
    `(loop for i from ,startno_s to ,endno_s 
           collect i)) 

(defmacro number_seq-m-not-1 (startno_s endno_s one) 
    `(loop for i from ,startno_s to ,endno_s 
          unless (= i ,one) ; '() case ok and not use ,@ command
           collect i)) 

       
(defun all_unique_p (lst) 
    (or (null lst) 
        (and (not (member (car lst) (cdr lst))) 
             (all_unique_p (cdr lst))))) 


(defun print_met_cond_at_base_dolist_p=1 (base) 
   (format t "~%~%~%~%~%~%-------------------------------------~%") 
   (setf *no_of_solutions* 0)
   (setf *11111* (* *q* (+ (* base base base base) (* base base base) (* base base) base 1)))
   (dolist (p (number_seq-m 0 (1- base) )) 
    (dolist (o (number_seq-m 0 (1- base) )) 
      (dolist (n (number_seq-m 0 (1- base) )) 
        (dolist (m (number_seq-m-not-1 2 (1- base) 1)) 
          (let* ((ijkl (- *11111* (+ (* base (+ (* base (+ (* base m) n)) o)) p)))
                 (l    (rem ijkl base))
                 (ijk  (/ (- ijkl l) base))
                 (k    (rem ijk base))
                 (ij   (/ (- ijk k) base))
                 (j    (rem ij base))
                 (i    (/ (- ij j) base)))
            (dolist (h (number_seq-m 0 (1- base)  ))  
              (dolist (g (number_seq-m 0 (1- base)  ))  
                (dolist (f (number_seq-m 0 (1- base)  ))  
                  (dolist (e (number_seq-m-not-1 2 (1- base)  1))   
                    (let* ((efgh  (+ (* base (+ (* base (+ (* base e) f)) g)) h))
                           (abcd  (+ efgh ijkl))
                           (d    (rem abcd base))
                           (abc  (/ (- abcd d) base))
                           (c    (rem abc base))
                           (ab   (/ (- abc c) base))
                           (b    (rem ab base))
                           (a    (/ (- ab b) base)))
              ;(format t "*11111* is ~d -- not solution ~d : ~d~~~d - ~d~~~d = ~d~~~d + ~d~~~d = ~d~~~d~~~d (base ~d)~%" 
              ;       *11111* *no_of_solutions* a b c d e f g h *q* *q* *q* base)
                      (when (and (< a  base) ;; no need to check all but just i I think
                                 (all_unique_p (list a b c d e f g h i j k l m n o p *q*)))
                        (progn 
                          (incf *no_of_solutions*)
                          (when (< *no_of_solutions* *no_of_solutions_to_print*)
                            (format t "~2d : ~2d~~~2d~~~2d~~~2d - ~2d~~~2d~~~2d~~~2d = ~2d~~~2d~~~2d~~~2d + ~2d~~~2d~~~2d~~~2d = ~d~~~d~~~d~~~d~~~d (base ~2d)~%" 
                                    *no_of_solutions* 
                                    a b c d 
                                    e f g h 
                                    i j k l
                                    m n o p
                                    *q* *q* *q* *q*  *q*
                                    base))))))))))))))
    (format t "no of solutions is ~d~%~%" *no_of_solutions*)
    (format t "=======================================~%~%~%~%")) 




;(time (print_met_cond_at_base_dolist_p=1 10)) 
;(time (print_met_cond_at_base_dolist_p=1 16)) 
;(time (print_met_cond_at_base_dolist_p=1 22)) ; 5 hours old ver
;(time (print_met_cond_at_base_dolist_p=1 28)) ; never finish after 1 day
;(time (print_met_cond_at_base_dolist_p=1 34)) ; not going to try

; (load "D:/\github-repo-clone/\ABCDEFGHPPP/\lisp/\lisp-9-loop/\abcdefghppp-dolist-p=1-tryoptim1.lisp")

; use sbcl 
; sbcl --script ...../opt4-after-c.lisp

#|
(defun main () 

  (print "hello abcdefghijklmnopQQQ w4")
  (print "")
  (time (print_met_cond_at_base_dolist_p=1 17)) ; 1430          1202 sec
  (time (print_met_cond_at_base_dolist_p=1 21)) ; 1595019       7043 sec 
  (time (print_met_cond_at_base_dolist_p=1 25)) ; 62811420     30367 sec ( 8 hours)
  (time (print_met_cond_at_base_dolist_p=1 29)) ; 796724927   106933 sec (29 hours) 
                                                                         ; vs c 37.59 seconds or 2845 times slower
)
|#

(defun main () 

  (print "hello abcdefghijklmnopQQQ w4 test other bases")
  (print "")
  (time (print_met_cond_at_base_dolist_p=1 17)) 
  (time (print_met_cond_at_base_dolist_p=1 18)) 
  (time (print_met_cond_at_base_dolist_p=1 19)) ; 
  (time (print_met_cond_at_base_dolist_p=1 20)) ; 
)


(main)

#|

;; see the comments on the opt2 one

;; just loop c not generative c version

|#