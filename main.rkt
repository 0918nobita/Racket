#lang racket/base

(require racket/class)
(require racket/gui/base)

; Make a frame by instantiating the frame% class
(define frame
  (new frame%
       [label "Racket"]
       [min-width 500]
       [min-height 400]))

(void
  (new canvas%
       [parent frame]
       [paint-callback
        (lambda (canvas dc)
          (send dc set-scale 3 3)
          (send dc set-text-foreground (make-object color% 186 85 211))
          (send dc draw-text "Hello, world!" 45 55))]))

(define msg
  (new message%
       [parent frame]
       [label "No events so far..."]))

(void
  (new button%
       [parent frame]
       [label "Click me"]
       [callback
        (lambda (button event)
          (send msg set-label "Button click"))]))

; Show the frame by calling its show method
(send frame show #t)
