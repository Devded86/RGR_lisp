
(defun fi (i)
  (labels ((f (k)
             (cond 
               ((= k 1) 1d0)
        
               ((and (>= k 2) (<= k 5)) 
                (let ((prev (f (1- k))))
                  (+ (* 5d0 (expt (sin prev) 2)) 
                     (* 5d0 (expt (cos prev) 2)))))
               
               ((= k 6) 1d0)
            
               ((and (>= k 7) (<= k 20)) 
                (let ((prev (f (1- k))))
                  (sqrt (* prev (log (float k 1d0)))))) 
               
        
               (t (error "i out of range: ~A" k)))))
    (f i)))



(defun build-table ()
  (append
   (loop for i from 1 to 5 collect (list i (fi i)))
   (loop for i from 6 to 20 collect (list i (fi i)))))

(defun show-table ()
  (format t "~%  i | Fi(i)~%-----------------------~%")
  (dolist (row (build-table))
    (format t "~3D | ~,8,2E~%" (first row) (second row))))

(defun run-tests ()
  (format t "~%Tests:~%")
  (format t "F1 = 1: ~A~%" (= (fi 1) 1d0))
  (format t "F6 = 1: ~A~%" (= (fi 6) 1d0))

  (let ((range1 (loop for i from 2 to 5 collect (fi i))))
    (format t "2..5 equals ~5,2f: ~A~%" 
            5.0 
            (every (lambda (x) (< (abs (- x 5d0)) 1d-10)) range1)))

  (let ((range2 (loop for i from 7 to 20 collect (fi i))))
    (format t "7..20 increasing: ~A~%"
            (every #'< range2 (rest range2)))))

(show-table)
(run-tests)