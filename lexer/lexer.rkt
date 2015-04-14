#lang racket

(provide lexer)

(define valid-inputs
  (set "<"
       ">"
       "."
       ","
       "+"
       "-"
       "["
       "]"))

(define (char->token character)
  (case character
    ["<"  'shift-left]
    [">"  'shift-right]
    ["."  'print-cell]
    [","  'overwrite-cell]
    ["+"  'increment-cell]
    ["-"  'decrement-cell]
    ["["  'loop-start]
    ["]"  'loop-end]
    [else 'ignore]))

(define (lexer string)
  (filter-not
    (lambda [x] (= x 'ignore))
    (map char->token string)))
