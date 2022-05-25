#lang racket
(require racket/gui/easy
         racket/gui/easy/operator
         "spellcaster.rkt"
         "todos.rkt")

(render
 (window
  #:title "Engel"
  #:size '(150 450)
  (vpanel
   (spell-caster-panel)
   (create-to-do-panel)
   (todo-panel))))