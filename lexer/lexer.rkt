#lang racket

(provide (struct-out machine)
         string->machine)

(define (char->token character)
  (case character
    [#\<  'shift-left]
    [#\>  'shift-right]
    [#\.  'print-cell]
    [#\,  'overwrite-cell]
    [#\+  'increment-cell]
    [#\-  'decrement-cell]
    [#\[  'loop-start]
    [#\]  'loop-end]
    [else 'ignore]))

(define (string->tokens raw-string)
  (filter-not
    (lambda [x] (= x 'ignore))
    (map char->token (string->list raw-string))))

(struct machine (passed cursor incoming))

(define (string->machine raw-string)
  (let [tokens (string->tokens raw-string)]
    (machine '[] (first tokens) (rest tokens))))

(define (machine-left))
  (if (empty? (machine-passed machine))
      (error "Pushed machine beyond left end")
      (machine (rest  (machine-passed machine))
               (first (machine-passed machine))
               (cons  (machine-cursor machine) (machine-incoming machine))))

(define (machine-right machine)
  (if (empty? (machine-incoming machine))
      (error "Pushed machine beyond right end")
      (machine (cons  (machine-cursor machine) (machine-passed machine))
               (first (machine-incoming machine))
               (rest  (machine-incoming machine)))
