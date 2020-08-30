(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cdr (cdr s)))
)


(define (sign num)
 (cond ((> 0 num) -1) 
       ((< 0 num) 1)
       (else 0))
)


(define (square x) (* x x))

(define (pow x y)
  (cond ((= y 1) x)
        ((even? y) (square (pow x (/ y 2))))
        (else (* x (square (pow x (/ (- y 1) 2))))))
)


(define (unique s)
  (if (null? s) s
      (cons (car s) (filter (lambda (x) (not (eq? x (car s)))) (unique (cdr s)))))
)


(define (replicate x n)
  (define (replicate_helper x n lst)
          (if (= 0 n) lst
              (replicate_helper x (- n 1) (cons x lst)))
    )
  (replicate_helper x n nil))


(define (accumulate combiner start n term)
  (if (= 0 n) start
      (accumulate combiner (combiner start (term n)) (- n 1) term))
  )


(define (accumulate-tail combiner start n term)
  (if (= 0 n) start
      (accumulate combiner (combiner start (term n)) (- n 1) term))
)


(define-macro (list-of map-expr for var in lst if filter-expr)
  `(map (lambda (,var) ,map-expr) (filter (lambda (,var) ,filter-expr) ,lst))
)

