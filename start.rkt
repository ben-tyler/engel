#lang racket/base
(require racket/gui/easy
         racket/gui/easy/operator)

(define engel '(
      "foo"
      "bar"))


(define (@todo name)
  (@ (cons name 0))) ;; same as (obs (cons name 0))


(define (update-todo-state state)
  (cond
    [(zero? (cdr state)) (+1 (cdr state))]
    [else (-1 (cdr state))]))

(define (get-button-string @todo-state)
  (obs-map (obs-map @todo-state car) (string-append "***")))
  

(define ( observe-the-observable @the-obs)
  (obs-observe! @the-obs (lambda (v) (printf "observer saw ~s~n" v)))
  @the-obs)

(define (todo-button @todo-state)
  (hpanel
   (button
    #:style (list 'border 'multi-line)
    (obs-map @todo-state car)
    ;;(get-button-string @todo-state)
    (lambda () ( obs-update! @todo-state update-todo-state)))))

(define (map-to-buttons li)
  (map (lambda (v)
         (todo-button (observe-the-observable
                       (@todo v))))
       li))

(define buttons (map-to-buttons engel))


(render
 ( window
    #:title "Engel"
    (apply vpanel buttons)))
