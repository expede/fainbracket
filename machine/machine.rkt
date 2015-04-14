#lang racket

(provide run-machine)


(define (run-machine machine tape)
  (let ([cell (first tape)])
    (case (first machine)
      ['print-cell (write cell)])))

(define (step machine tape))
(define (left machine))
(define (right machine))
(define (increment cell))
(define (decrement cell))
(define (overwrite cell))
