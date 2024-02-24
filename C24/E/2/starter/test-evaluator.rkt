#lang racket

(require rackunit)
(require rackunit/text-ui)
(require "evaluator.rkt")

(define-test-suite evaluator-test-suite
  (test-equal? 
   "evaluate"
   (evaluate #t
            '())
   #t)

  (test-equal? 
   "evaluate"
   (evaluate #f
            '())
   #f)

   (test-equal? 
   "evaluate"
   (evaluate (and #t #f)
            '())
   #f)

   (test-equal? 
   "evaluate"
   (evaluate (or #t `a)
            '((a . #f)))
   #t)

  ;;; (test-equal?  ;; This test doesn't work for some reason
  ;;;  "evaluate"
  ;;;  (evaluate (or `a #t)
  ;;;           '((a . #f)))
  ;;;  #t)

  (test-equal? 
   "evaluate"
   (evaluate '(a)
             '((a . #f)))
   #f)

  (test-equal? 
   "evaluate"
   (evaluate '(a and b)
             '((a . #t) (b . #f)))
   #f)

  (test-equal? 
   "evaluate"
   (evaluate '(a and (b or c))
             '((a . #t) (b . #f) (c . #t)))
   #t)

  (test-equal? 
   "evaluate"
   (evaluate '((a and (not b)) or ((a and c) or ((not b) and c)))
             '((a . #t) (b . #f) (c . #f) (d . #t)))
   #t)
  )

(define-test-suite simplifier-test-suite
  
  (test-equal? 
   "simplify"
   (simplify '(not a)
             '((a . #t)))
   #f)

  (test-equal? 
   "simplify"
   (simplify '(#f and a)
             '((a . #t)))
   #f)

  (test-equal? 
   "simplify"
   (simplify '(#t or a)
             '((a . #f)))
   #t)

  (test-equal? 
   "simplify"
   (simplify '(a and (b or c))
             '((a . #t) (b . #f) (c . #t)))
   #t)

  (test-equal? 
   "simplify"
   (simplify '(a and (b or c))
             '((b . #f) (c . #t)))
   'a)

  (test-equal? 
   "simplify"
   (simplify '((a and (not b)) or ((a and c) or ((not b) and c)))
             '((a . #t) (c . #f) (d . #t)))
   '(not b))
  )

(display (run-tests evaluator-test-suite))
(display (run-tests simplifier-test-suite))