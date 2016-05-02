(DECLAIM (OPTIMIZE (SPEED 3)
           (COMPILATION-SPEED 0)
           (SAFETY 0)
           (DEBUG 0)))
(defparameter *no_of_solutions* 0)
(defparameter *no_of_solutions_to_print* 51)
(defparameter *p* 1)
(defparameter *ef* 0)
 
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
   (format t "~%~%~%~%~%~%-------------------------------------~%") ; print a new line
   (setf *no_of_solutions* 0)
   (dolist (e (number_seq-m 2 (1- base) )) ; no need of  uniqure 
    (dolist (f (number_seq-m-not-1 0 (1- base) 1)) ; skip over 1
      ; try ef here should use let ... 
     (setf *ef* (+ (* base e) f))
     (dolist (g (number_seq-m 2 (1- base) ))
      (dolist (h (number_seq-m-not-1 0 (1- base)  1))
       (if (= (+ *ef* ; (* base e) f
                 (* base g) h)
              (* *p* (+ (* base base)
                           base
                           1))) 
         (dolist (a (number_seq-m 2 (1- base)  ))  
          (dolist (b (number_seq-m-not-1 0 (1- base)  1))   
           (dolist (c (number_seq-m 2 (1- base) ))
            (dolist (d (number_seq-m-not-1 0 (1- base)  1))
              (when (and (= (- (+ (* base a) b)
              ;(when  (= (- (+ (* base a) b)
                               (+ (* base c) d))
                            *ef* ) ; (+ (* base e) f))     ;;; can save some cpu if use variable ef But ...
                         (all_unique_p (list a b c d e f g h *p*)))
                (progn 
                  (incf *no_of_solutions*)
                  (when (< *no_of_solutions* *no_of_solutions_to_print*)
                      (format t "~d : ~d~~~d - ~d~~~d = ~d~~~d + ~d~~~d = ~d~~~d~~~d (base ~d)~%" 
                     *no_of_solutions* a b c d e f g h *p* *p* *p* base)
                  )))
              )))))))))
    (format t "no of solutions is ~d~%~%" *no_of_solutions*)
    (format t "=======================================~%~%~%~%")) 




;(time (print_met_cond_at_base_dolist_p=1 10)) 
;(time (print_met_cond_at_base_dolist_p=1 16)) 
;(time (print_met_cond_at_base_dolist_p=1 22)) ; 5 hours old ver
;(time (print_met_cond_at_base_dolist_p=1 28)) ; never finish after 1 day
;(time (print_met_cond_at_base_dolist_p=1 34)) ; not going to try

; (load "D:/\github-repo-clone/\ABCDEFGHPPP/\lisp/\lisp-9-loop/\abcdefghppp-dolist-p=1-tryoptim1.lisp")

(defun main () 

  ;(print "hello")
  (time (print_met_cond_at_base_dolist_p=1 10)) 
  (time (print_met_cond_at_base_dolist_p=1 16)) 
  (time (print_met_cond_at_base_dolist_p=1 22)) ; 5 hours old ver
  (time (print_met_cond_at_base_dolist_p=1 28)) ; never finish after 1 day
  (time (print_met_cond_at_base_dolist_p=1 34)) ; not going to try

)

(main)

#|

;; not used and vector is another possibilities.

;; still not get c + d = d + c = e and how to save 45%

(sb-ext:save-lisp-and-die "opt1-main2c" :toplevel #'main :executable t)

(defmacro number_seq-unique-newnotfaster (startno_s endno_s &rest rest) 
    `(loop for i from ,startno_s to ,endno_s 
          unless (member i (list ,@rest)) ; '() case ok and use ,@ avoid e not 2 issues
           collect i)) 

(defmacro number_seq-unique-notused (startno_s endno_s &rest rest) 
    `(loop for i from ,startno_s to ,endno_s 
          unless (member i ',rest) ; '() case ok and not use ,@ command
           collect i)) 


(defun number_seqf (startno_s endno_s) 
    (loop for i from startno_s to endno_s collect i)) 

      

(defmacro all_unique_pm (lst) ; recursive macro alert, not necessarily bad but 
                              ; wrong idea in this case as the loop can 
                              ; only be done in run-time
    `(or (null ,lst) 
        (and (not (member (car ,lst) (cdr ,lst))) 
             (all_unique_pm (cdr ,lst))))) 

rem @ECHO OFF
rem need to reboot to get the environment for core
set PATH=C:\Program Files\Steel Bank Common Lisp\1.3.4;%PATH%
if [%1] == [3] "C:\Program Files\Steel Bank Common Lisp\1.3.4\sbcl.exe" --script D:\...\abcdefghppp-dolist-p=1-tryoptim1-fast-3.lisp
if [%1] == [t] "C:\Program Files\Steel Bank Common Lisp\1.3.4\sbcl.exe" --script D:\...\test-loop-no-unique-issue.lisp
if [%1] == [] "C:\Program Files\Steel Bank Common Lisp\1.3.4\sbcl.exe" --script D:\...\abcdefghppp-dolist-p=1-tryoptim1.lisp


|#