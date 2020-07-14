#lang racket/base

(define k #f) ; 継続

; 大域変数
(define a 1)
(define b 3)

(+
  a
  (call/cc
    (λ (cont)
      (set! k cont)
      2))
  b) ; => 6

; 環境破壊
(set! a 10)
(set! b 30)

(k 2) ; => (+ 1 {2} 30) => 33
