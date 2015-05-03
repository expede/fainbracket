#lang racket

(provide run-machine)

(define (run-machine raw-string tape)
  (let ([cell (first tape)]
        [machine (string->tokens raw-string)])
    (case (first machine)
      ['print-cell (write cell)])))

(define (step machine tape)
  ())

(define (left machine)
  ())

(define (right machine)
  ('[]))

(define (increment-cell! tape)
  (set-tape-cell! tape (+ (tape-cursor tape) 1)))

(define (decrement-cell! tape)
  (set-tape-cell! tape (- (tape-cursor tape) 1)))
