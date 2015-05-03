#lang racket

(provide run-machine)

(define (run-machine raw-string tape)
  (let ([cell (first tape)]
        [machine (string->tokens raw-string)])
    (case (first machine)
      ['print-cell (write cell)])))

(define (step machine tape)
  ())
