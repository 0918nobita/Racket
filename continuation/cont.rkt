#lang racket/base

; 大域脱出
(define (f)
  (call/cc
    (λ (k)
      (begin (display 1) (newline)
             (display 2) (newline)
             (k 10)
             (display 3) (newline)))))

(f) ; => 1, 2, 10

(define cont #f)
(+ 5
   (call/cc
     (λ (c)
        (set! cont c)
        10))) ; => 15

(cont 100) ; => 105
