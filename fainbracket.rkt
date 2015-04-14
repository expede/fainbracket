#lang racket

(require "tape/tape.rkt"
         "lexer/lexer.rkt"
         "machine/machine.rkt")

(define (fainbracket input)
  run-machine (string->tokens input) tape)
