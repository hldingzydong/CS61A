(define (split-at-helper former-lst lst n)
    (cond ((null? lst) (list former-lst))
          ((= 0 n) (cons former-lst lst))
          (else (split-at-helper (append former-lst (list (car lst))) (cdr lst) (- n 1))))
)

(define (split-at lst n)
  (cond ((null? lst) lst)
        ((<= n 0) (cons nil lst))
        (else (split-at-helper (cons (car lst) nil) (cdr lst) (- n 1))))
)


(define-macro (switch expr cases)
	(cons _________
		(map (_________ (_________) (cons _________ (cdr case)))
    			cases))
)

