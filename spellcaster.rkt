#lang racket
(require racket/gui/easy
         racket/gui/easy/operator)

(provide spell-caster-panel)

(define @spellcaster (obs #f))

(define (drawer dc d)
  (send dc draw-ellipse 0 0 (* 2 90) (* 2 90)))

(define (spell-caster-panel)
  (hpanel
    #:alignment '(center top)
    #:stretch '(#t #t)
    (canvas @spellcaster drawer)))