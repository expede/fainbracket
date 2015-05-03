#lang racket

(provide string->tokens)

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
