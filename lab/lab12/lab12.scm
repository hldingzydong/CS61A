
(define-macro (def func args body)
    `(define ,func (lambda ,args ,body))
    )


(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define all-three-multiples
  (map-stream (lambda (x) (+ x 3)) (cons-stream 0 all-three-multiples))
)


(define (compose-all funcs)
  (if (null? funcs) (lambda (x) x)
    (lambda (x) ((compose-all (cdr funcs)) ((car funcs) x)))
  )
)

(define (helper start stream)
    (if (null? stream) stream
    (cons-stream (+ start (car stream)) (helper (+ start (car stream)) (cdr-stream stream))))
  )

(define (partial-sums stream)
  (helper 0 stream)
)

