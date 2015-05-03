#lang racket

(provide (struct-out tape)
         tape-start
         tape-left
         tape-right
         increment-cell!
         decrement-cell!)

(struct tape (passed [cursor #:mutable] incoming))

(define tape-start ('[0] 0 '[0]))

(define (tape-left tape)
  (let [safe-passed
         (if (empty? (tape-passed tape))
             '[0]
             (rest (tape-passed tape)))]
    (tape safe-passed
          (first (tape-passed tape))
          (cons (tape-cursor tape) (tape-incoming tape)))))

(define (tape-right tape)
  (let [safe-incoming
         (if (empty? (tape-incoming tape))
             '[0]
             (rest (tape-incoming tape)))]
    (tape (cons  (tape-cursor tape) (tape-passed tape))
          (first (tape-incoming tape))
          safe-incoming)))

(define (increment-cell! tape)
  (set-tape-cell! tape (+ (tape-cursor tape) 1)))

(define (decrement-cell! tape)
  (set-tape-cell! tape (- (tape-cursor tape) 1)))
