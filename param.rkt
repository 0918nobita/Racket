#lang racket/base

(define roll-my-own-param
  (let ([v #f])
    (case-lambda
      [() v]
      [(new) (set! v new)])))

(roll-my-own-param)    ; => #f
(roll-my-own-param 10)
(roll-my-own-param)    ; => 10


(define p1 (make-parameter 1))

(p1) ; => 1
(p1 10)
(p1) ; => 10

(define p2 (make-parameter 20))

; 1. Set them to new values.
; 2. Do something.
; 3. Automatically restore the original values.
(parameterize ([p1 30]
               [p2 40])
  (+ (p1) (p2))) ; => 70

(+ (p1) (p2)) ; => 30
