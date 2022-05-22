#lang racket
(require racket/gui/easy
         racket/gui/easy/operator)

(define @todos (@ '(
                    (0 . "Get nothing done" . not-done)
                    (1 . "Get things done" . not-done))))

(define (mark-as-done key-state)
 (println (~a key-state "marking as done"))
 (list (car key-state) 'done))
 
(define (append-todo todos)
  (define next-id (mark-as-done (apply max (map cadr todos))))
  (append todos `((,next-id . "one more thing" . not-done))))
 
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
 
(render
 (window
  #:size '(#f 200)
  (vpanel
   (hpanel
    #:alignment '(center top)
    #:stretch '(#t #f)
    (button "Add todo" (λ () (@todos . <~ . append-todo))))
   (list-view
    @todos
    #:key car
    (λ (k @entry)
      (todo @entry
       (λ (proc)
         (@todos . <~ . (λ (todos) (update-todo todos k proc))))))))))
