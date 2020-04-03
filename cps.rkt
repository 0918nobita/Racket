#lang racket/base

(require (only-in racket/function
                  identity))

(define (fact/cps n k)
  (if (= n 1)
    (k 1)
    (fact/cps
      (- n 1)
      (λ (x) (k (* n x))))))

(fact/cps 4 identity) ; => 24
