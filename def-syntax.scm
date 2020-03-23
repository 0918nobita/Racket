(define-syntax nil!
  (syntax-rules ()
    ((_ x)
     (set! x '()))))

(define a 1)
(print a) ; => 1
(nil! a)
(print a) ; => ()


(define-syntax when
  (syntax-rules ()
    ((_ pred b1 ...)
     (if pred (begin b1 ...)))))

(when #t (print "a") (print "b")) ; => a, b


(define-syntax incf
  (syntax-rules ()
    ((_ x)
     (begin
       (set! x (+ x 1))
       x))
    ((_ x i)
     (begin
       (set! x (+ x i))
       x))))

(define b 1)
(print b) ; => 1
(incf b)
(print b) ; => 2
(incf b 5)
(print b) ; => 7


(define-syntax type-of
  (syntax-rules ()
    ((_ ()) 'null)
    ((_ (expr ...)) 'pair)
    ((_ #(expr ...)) 'vector)
    ((_ symbol-or-literal)
     (let-syntax
       ((test
          (syntax-rules ()
            ((_ symbol-or-literal) 'symbol)
            ((_ _) 'others))))
       (test match-me)))))

(print (type-of ()))          ; => null
(print (type-of (+ 1 2)))     ; => pair
(print (type-of #(10 20 30))) ; => vector
(print (type-of foo))         ; => symbol
(print (type-of 100))         ; => others


(define-syntax my-and
  (syntax-rules ()
    ((_) #t)
    ((_ e) e)
    ((_ e1 e2 ...)
     (if e1
         (my-and e2 ...)
         #f))))

(print (my-and))    ; => #t
(print (my-and #f)) ; => #f
(print (my-and #f (begin (print "foo") #t)))    ; => #f
(print (my-and #t #t (begin (print "bar") #f))) ; => bar, #f


(define-syntax foo
  (syntax-rules ()
    ((_ (a b)) 'ok)))

(define-syntax bar
  (syntax-rules ()
    ((_ k) (k (a b)))))

(print (bar foo)) ; => ok
