#lang racket

(provide run-machine)

(struct machine (passed cursor incoming))

(define (string->machine raw-string)
  (let [tokens (string->tokens raw-string)]
    (machine '[] (first tokens) (rest tokens))))

(define (machine-left)
  (if (empty? (machine-passed machine))
      (error "Pushed machine beyond left end")
      (machine (rest  (machine-passed machine))
               (first (machine-passed machine))
               (cons  (machine-cursor machine) (machine-incoming machine)))))

(define (machine-right machine)
  (if (empty? (machine-incoming machine))
      (error "Pushed machine beyond right end")
      (machine (cons  (machine-cursor machine) (machine-passed machine))
               (first (machine-incoming machine))
               (rest  (machine-incoming machine)))))

(define (machine-seek-loop-start machine-state)
  (let* ([old-passed   (machine-passed machine-state)]
         [old-cursor   (machine-cursor machine-state)]
         [old-incoming (machine-incoming machine-state)]
         [halves (cons
                   (splitf-at old-passed
                              (lambda [x] (not (= x 'loop-start)))))]
         [new-passed (first halves)]
         [after      (rest halves)]
         [new-cursor (first after)]
         [new-incoming (cons (rest after) old-incoming)])
    (machine new-passed new-cursor new-incoming)))

(define (submachine-start-position submachine)
  (let [reverse-passed (reverse (machine-passed submachine))]
    (machine '[]
             (first reverse-passed)
             (cons (cons (rest reverse-passed)
                         (machine-cursor submachine))
                   (machine-incoming submachine)))))

(define (run-machine raw-string tape)
  (let ([cell (first tape)]
        [machine (string->tokens raw-string)])
    (case (first machine)
      ['print-cell (write cell)])))

(define (step machine tape)
  (case (machine-cursor machine)
    ('loop-end find start of loop if value == 0)
    ('loop-start skip past 'loop-end if value /= 0)
    (else run the command, and move ahead one)))
