(define (rle_helper s curr cnt)
    (cond ((null? s) (cons-stream (list curr cnt) nil))
          ((= curr (car s)) (rle_helper (cdr-stream s) curr (+ cnt 1)))
          (else (cons-stream (list curr cnt) (rle_helper s (car s) 0)))
        )
)

(define (rle s)
   (if (null? s) s
    (rle_helper s (car s) 0))
)


(define (group-by-nondecreasing-helper s last_value curr_lst)
        (cond ((null? s) (cons-stream curr_lst nil))
            ((<= last_value (car s)) (group-by-nondecreasing-helper (cdr-stream s) (car s) (append curr_lst (cons (car s) nil))))
            (else (cons-stream curr_lst (group-by-nondecreasing-helper (cdr-stream s) (car s) (list (car s))))))
    )

(define (group-by-nondecreasing s)
    (if (null? s) s
        (group-by-nondecreasing-helper (cdr-stream s) (car s) (list (car s))))
    )


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))

