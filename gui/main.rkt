#lang racket/base

(require (only-in racket/class
                  make-object
                  new
                  send))

(require (only-in racket/gui/base
                  button%
                  canvas%
                  color%
                  frame%
                  menu%
                  menu-bar%
                  menu-item%
                  message%))

; Make a frame by instantiating the frame% class
(define frame
  (new frame%
       [label "Game"]
       [min-width 500]
       [min-height 400]))

(define menu-bar
  (new menu-bar%
       [parent frame]))

(define menu
  (new menu%
       [label "File"]
       [parent menu-bar]))

(void
  (new menu-item%
       [label "Save"]
       [parent menu]
       [callback
        (λ (menu-item control-event)
          (printf "Event type : ~a\n" (send control-event get-event-type))
          (send msg set-label "Saved!"))]))

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
