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
