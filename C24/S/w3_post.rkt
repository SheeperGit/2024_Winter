#lang racket

(require test-engine/racket-tests)

; (all-ok? ok? xs) -> boolean?
; ok? : procedure applicable to every element of xs
; xs : list?
; returns whether ok? applied to every element of xs results in true.
; returns true if xs is empty.
(define (all-ok? ok? xs)
  (or (empty? xs)
      (and (ok? (first xs)) (all-ok? ok? (rest xs)))))

(check-expect (all-ok? positive? '()) true)
(check-expect (all-ok? positive? '(42)) true)
(check-expect (all-ok? positive? '(-42)) false)
(check-expect (all-ok? positive? '(1 2 3 4)) true)
(check-expect (all-ok? positive? '(1 -2 3 -4)) false)


; (make-proc f g) -> procedure?
; f,g : procedure, the composition f o g is well-defined
; return a composition f o g ( aka f(g(x)) )
(define (make-proc f g)
  (λ (x) (f (g x))))

(check-expect ((make-proc positive? abs) -42) true)
(check-expect ((make-proc (λ (x) (= x 5)) length) '(1 2 3 4 5)) true)
(check-expect ((make-proc (λ (x) (= x 5)) length) '(1 2 3 4)) false)

; (my-map f xs) -> list?
; simulate the simplest version of map
(define (my-map f xs)
  (if (empty? xs)
      empty
      (cons (f (first xs)) (my-map f (rest xs)))))

(check-expect (my-map abs '()) '())
(check-expect (my-map positive? '(1 -2 3 -4)) '(#t #f #t #f))
(check-expect (my-map (λ (x) (+ x 42)) '(1 2 3)) '(43 44 45))

(test)
