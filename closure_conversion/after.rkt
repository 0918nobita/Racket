#lang racket/base

(struct env-0 (x))
(define (f-0 env) (env-0-x env))
(define (f x) (f-0 (env-0 x)))

(define (foo) (f 10))
(define (bar) (f 20))

(displayln (foo)) ; => 10
(displayln (bar)) ; => 20
