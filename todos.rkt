#lang racket
(require racket/gui/easy
         racket/gui/easy/operator
         "data.rkt")

(provide todo-panel
         create-to-do-panel)
         
(define (generate-todos-from-data)
  (map (λ (i) (list i 0 'not-done))(todo-data)))

(define @todos (@ (generate-todos-from-data)))


(define (mark-as-done key-state)
 (list (car key-state) 'done))
 
(define (append-todo todos new-item)
  (define next-id (apply max (map cadr todos)))
  (append todos `((,next-id . new-item . not-done))))
 
(define (update-todo todos k proc)
  (for/list ([entry (in-list todos)])
    (if (eq? (car entry) k)
        (cons k (proc (cdr entry)))
        entry)))
 
(define (todo @todo action)
  (hpanel
   #:stretch '(#t #f)
   (text (obs-map @todo (λ (i) (~a i))))
   (button "λ" (λ () (action mark-as-done)))))

(define (create-to-do-panel)
  (hpanel
    #:alignment '(center top)
    #:stretch '(#t #f)
    (button "Add todo" (λ () (@todos . <~ . append-todo)))))

(define (todo-panel)
  (list-view
    @todos
    #:key car
    (λ (k @entry)
      (todo @entry
       (λ (proc)
         (@todos . <~ . (λ (todos) (update-todo todos k proc))))))))

