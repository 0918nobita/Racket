#lang racket/base

(require (only-in "./typed.rkt"
                  distance
                  pt))

(distance (pt 10 0) (pt 10 20)) ; => 20
