#lang racket/base

(define (f x) (λ () x))

(define foo (f 10))
(define bar (f 20))

(displayln (foo)) ; => 10
(displayln (bar)) ; => 20
