#lang racket/base

(require racket/function)

(define k 'bool) ; 継続

(define continue? #f)

(define (resume)
  (set! continue? #t)
  (k 'dummy)
  (newline))

(define (suspend escape)
  (set! continue? #f)
  (set! k (call/cc identity))
  (if continue? #f (escape #f)))

(define-syntax block
  (syntax-rules ()
    [(_ escape proc) (call/cc (λ (escape) proc))]))

(define (proc _)
  (block escape
    (letrec ([iter
              (λ (i)
                (display i)
                (suspend escape)
                (iter (+ i 1)))])
      (iter 0))))

(set! k proc)
(let () (resume) (displayln "hello!"))
(resume)
