#lang racket/base

(require (only-in racket/trace
                  trace
                  untrace))

(define (sum n)
  (if (zero? n)
    0
    (+ n (sum (sub1 n)))))

(trace sum)
(sum 10)
(untrace sum)

; 1 から n までの自然数の和を返す関数 wa
(define (wa n)
  (if (>= 0 n)
    0
    (+ n (wa (- n 1)))))

; 1 から n までの自然数の和から n を引いた数を返す関数 wa-n
(define (wa-n n)
  (if (>= 0 n)
    0
    (- (wa n) n)))

; wa-n を、λ を使ってひとつの関数だけで実現したいけれど上手く行かない

(define ((make-wa f) n)
  (if (>= 0 n)
    0
    (+ n (f (- n 1)))))

((make-wa wa) 3)
; => ((λ (n)
;       (if (>= 0 n)
;         0
;         (+ n (wa (- n 1)))))
;     3)
; => 6

; (define wa (make-wa wa)) とすることは当然出来ない

; ここで (X X) => wa とする

(define ((make-wa2 X) n)
  (if (>= 0 n)
    0
    (+ n ((X X) (- n 1)))))

; make-wa2 もまた、X を受け取って wa を返す関数
; (make-wa2 make-wa2)
; => (#<procedure:make-wa2> #<procedure:make-wa2>)
; => (λ (n) (if (>= 0 n) 0 (+ n ((make-wa2 make-wa2) (- n 1)))))
; 全体が λ 抽象になったので、ここで簡約は終了

; make-wa2 の定義を展開したうえで wa を定義
(define wa2
  ((λ (X)
     (λ (n)
       (if (>= 0 n)
         0
         (+ n ((X X) (- n 1))))))
   (λ (X)
     (λ (n)
       (if (>= 0 n)
         0
         (+ n ((X X) (- n 1))))))))

(wa2 3) ; => 6

; 1. 再帰関数の、自分自身への呼び出しを (X X) に置き換える
; 2. 関数全体を (λ (X) ...) でくるむ
; 3. くるんで出来た λ 式に、同じ λ 式を適用する
; という手順を手続きとして定義する

; wa のタネ
(define ((wa-seed wa) n)
  (if (>= 0 n)
    0
    (+ n (wa (- n 1)))))

; 愚直に書くと ↓ のようになるが、
; 値呼び戦略を採用しているため (X X) の部分で呼び出しが止まらなくなる
; (define ((Y seed) n)
;   ((λ (X) (seed (X X)))
;    (λ (X) (seed (X X)))))

; (X X) の評価を遅延するために λ 式でくるむ
(define (Z seed)
  ((λ (X) (seed (λ (x) ((X X) x))))
   (λ (X) (seed (λ (x) ((X X) x))))))

((Z wa-seed) 3) ; => 6
