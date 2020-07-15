#lang racket/base

(define k1 #f)

(+ 1
  (+ 2
    (call-with-current-continuation
      (λ (k)
        (set! k1 k)
        0)))) ; => 3

(* 2 (k1 0)) ; => 3


(define k2 #f)

(+ 1
  (+ 2
    (call-with-composable-continuation
      (λ (k)
        (set! k2 k)
        0)))) ; => 3

(* 2 (k2 0)) ; => 3, 6
