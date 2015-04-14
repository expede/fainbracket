#lang racket

(require "tape/tape.rkt"
         "lexer/lexer.rkt"
         "machine/machine.rkt")

(define (fainbracket input)
  machine tape (string->tokens input))
