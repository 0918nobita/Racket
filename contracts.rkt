#lang racket/base

(require (only-in racket/contract
                  ->
                  and/c
                  any
                  contract-out
                  define/contract
                  flat-contract?
                  or/c))

(provide (contract-out (amount number?)))

; (define amount 0) ; broke its own contract (promised: positive?, produced: 0)
(define amount 1)

; f : dom -> range
; The domain indicates the kind of values that the function can accept as arguments,
; and the range indicates the kind of values that it produces.

(provide (contract-out (deposit (-> number? any)) ; ``(-> number? any)`` <-> ``(number? . -> . any)``
                       (balance (-> number?))))

; accepts a number and returns some value that is not specified in the contract
(define (deposit a) (set! amount (+ amount a)))

; returns a number indicating the current balance of the account
(define (balance) amount)

(define/contract (my-invert b i)
  (-> boolean? integer? integer?)
  (if b (- i) i))

(my-invert #f 10) ; => 10

(define/contract (my-invert2 i #:invert? b)
  (-> integer? #:invert? boolean? integer?)
  ; <-> ``(integer? #:invert? boolean? . -> . integer?)``
  (if b (- i) i))

(my-invert2 1 #:invert? #t) ; => -1

(define number-or-boolean? (or/c number? boolean?))

(flat-contract? number-or-boolean?) ; => #t

(number-or-boolean? 100) ; => #t
(number-or-boolean? #t) ; => #t
(number-or-boolean? "foo") ; => #f

(define ((show-me n) x)
  (printf "~a " n)
  #t)

(define/contract identity-with-complex-printing-contract
  (and/c (-> (show-me 4) (show-me 5))
         (-> (show-me 3) (show-me 6))
         (-> (show-me 2) (show-me 7))
         (-> (show-me 1) (show-me 8)))
  (λ (x) x))

(identity-with-complex-printing-contract 101) ; => "1 2 3 4 5 6 7 8 "

(flat-contract? identity-with-complex-printing-contract) ; => #t
