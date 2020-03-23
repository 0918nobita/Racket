#lang racket/base

(require racket/trace)

(define (sum n)
  (if (zero? n)
    0
    (+ n (sum (sub1 n)))))

(trace sum)

(sum 10)
