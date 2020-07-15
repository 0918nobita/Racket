#lang racket/base

(require racket/port json)

(with-output-to-string
  (λ () (write-json 1))) ; => "1"

(with-output-to-string
  (λ () (write-json "foo"))) ; => "\"foo\""

(with-output-to-string
  (λ ()
    (write-json
      #hasheq(
        (foo . "hello")
        (bar . (1 2 3)))))) ; => "{\"bar\":[1,2,3],\"foo\":\"hello\"}"

(with-input-from-string
  "{\"arr\": [1, 2, 3, 4]}"
  (λ () (read-json))) ; => '#hasheq((arr . (1 2 3 4)))
