(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
    (cond ((null? rests) (list (list first)))
          (else (map (lambda (x) (append (list first) x)) rests)))
  )

(define (zip pairs)
  (cond ((null? pairs) '(() ()))
        ((null? (car pairs)) nil)
        (else (append (list (map car pairs)) (zip (map cdr pairs)))))
  )

;; Problem 16
;; Returns a list of two-element lists
(define (enumerate s)
    (define (enumerate_helper index s)
        (if (null? s) s
            (cons (list index (car s)) (enumerate_helper (+ index 1) (cdr s))))
        )
    (enumerate_helper 0 s)
  )

;; Problem 17
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
    (cond ((null? denoms) '())
          ((= total 0) '())
          ((< total (car denoms)) (list-change total (cdr denoms)))
          (else (append (cons-all (car denoms) (list-change (- total (car denoms)) denoms)) (list-change total (cdr denoms))))
        )
  )

;; Problem 18
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         expr
         )
        ((quoted? expr)
         expr
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
                (append (list form params) (let-to-lambda body))
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
            (cons
             (append
               (list 'lambda (car (zip values)))
               (map let-to-lambda body))
             (map let-to-lambda (cadr (zip values))))
           ))
        (else
            (map let-to-lambda expr)
         )))