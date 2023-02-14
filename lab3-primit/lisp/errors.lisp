(defvar errors-results 
    '((fp-rounding . abitdifferent) (fp-overflow . infinity) (fp-underflow . zero) (int-overflow . verydifferent)))
    ; a list of pairs

(defvar errors
    (mapcar 'car errors-results))
     ; take the first element from each pair and put them in a list

(defvar results
    (remove-duplicates 
        (mapcar 'cdr errors-results)))
        ; take the second element from each pair and put them in a list

(defun errorp (x)
    (member x errors))
    ; check whether x is in the list errors
    ; errorp means "is x an error?" - predicate

(defun resultp (x)
    (member x results))
    ; check whether x is in the list results
    ; resultp means "is x a result?" - predicate

(defun error-to-result (name)
    (cdr (assoc name errors-results)))
    ; lookup a pair by the first element (ie error)
    ; and return the second element (ie a result)

(defun result-to-error (code)
    (car (rassoc code errors-results)))
    ; lookup a pair by the second element (ie result)
    ; and return the first element of the first matching pair (ie error)


(defun get-result ()
    (write-string (format nil "input result: ~%"))
    (let*
        ((line (read-line)) ;get a line as a string
         (element (read-from-string line))) ;parse the line
        (if (resultp element) ;is element a valid error?
            ; then:
            element ;yes, return it
            ; else:
            (progn ; progn = evaluate a sequence of expressions and return the result of the last one
                (write-line "Invalid result, please try again.")
                (get-result))))) ;start over using recursion

(write-string "Known Results: ")
(write-string (format nil "~A~%" results)) 
    ;"~%" means end of line
    ;"~A" means format a symbol / Lisp program

(let ((result (get-result)))
    (write-string
        (format nil "~A is the result of error: ~A~%" result (result-to-error result))))



; Reverse (Takes result as an input and then outputs the error)
;(defun get-result ()
;   (write-string (format nil "input result: ~%"))
;   (let*
;       ((line (read-line)) ;get a line as a string
;        (element (read-from-string line))) ;parse the line
;       (if (resultp element) ;is element a valid error?
;           ; then:
;           element ;yes, return it
;           ; else:
;           (progn ; progn = evaluate a sequence of expressions and return the result of the last one
;               (write-line "Invalid result, please try again.")
;               (get-result))))) ;start over using recursion

;(write-string "Known Results: ")
;(write-string (format nil "~A~%" results)) 
    ;"~%" means end of line
    ;"~A" means format a symbol / Lisp program

;(let ((result (get-result)))
;    (write-string
;        (format nil "~A is the result of error: ~A~%" result (result-to-error result))))

