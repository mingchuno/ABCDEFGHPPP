(defparameter *no_of_solutions* 0)
(defparameter *no_of_solutions_to_print* 51)
(defparameter *p* 1)
      
(defun print_met_cond_at_base_dolist_p=1 (base) 
   (format t "~%") ; print a new line
   (setf *no_of_solutions* 0)
   (dolist (a (number_seq 1 (- base 1)))    ;   '(1 2 3 4 5 6 7 8 9) for base 10 
   (dolist (b (number_seq 0 (- base 1)))    ; '(0 1 2 3 4 5 6 7 8 9) for base 10 
   (dolist (c (number_seq 1 (- base 1)))
   (dolist (d (number_seq 0 (- base 1)))
   (dolist (e (number_seq 1 (- base 1)))
   (dolist (f (number_seq 0 (- base 1)))
   (dolist (g (number_seq 1 (- base 1)))
   (dolist (h (number_seq 0 (- base 1)))
            (print_if_met_cond a b c d e f g h base)))))))))
   (format t "no of solutions is ~d~%" *no_of_solutions*)) ; may try p=1

(defun print_if_met_cond (a b c d e f g h base) 
    (when (and  (all_unique_p (list a b c d e f g h *p*)) 
                (= (- (+ (* base a) b)
                      (+ (* base c) d))
                   (+ (* base e) f))     ;;; can save some cpu if use variable ef but ...
                (= (+ (* base e) f
                      (* base g) h)
                   (* *p* (+ (* base base)
                           base
                           1))))
       (progn 
         (incf *no_of_solutions*)
         (when (< *no_of_solutions* *no_of_solutions_to_print*)
             (format t "~d : ~d~~~d - ~d~~~d = ~d~~~d + ~d~~~d = ~d~~~d~~~d (base ~d)~%" 
                     *no_of_solutions* a b c d e f g h *p* *p* *p* base)))))
              
(defun all_unique_p (lst) 
    (or (null lst) 
        (and (not (member (car lst) (cdr lst))) 
             (all_unique_p (cdr lst))))) 

(defun number_seq (startno_s endno_s) 
    (loop for i from startno_s to endno_s collect i)) 

(time (print_met_cond_at_base_dolist_p=1 10)) 
(time (print_met_cond_at_base_dolist_p=1 16)) 
(time (print_met_cond_at_base_dolist_p=1 22)) 
(time (print_met_cond_at_base_dolist_p=1 28)) ; never finish after 1 day
(time (print_met_cond_at_base_dolist_p=1 34)) ; not going to try
