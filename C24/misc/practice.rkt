#lang racket

(require test-engine/racket-tests)

(provide unzip-hop unzip-fold)

(define (unzip-hop pairs)
    (if (empty? pairs)
        `(`() `())
        (list (map car pairs) (map cdr pairs))))

(define (unzip-fold pairs)
  (foldr (lambda (pair acc)
           (list (cons (car pair) (car acc))
                 (cons (cdr pair) (cadr acc))))
         '(() ())
         pairs))


(define pairs1 `((1 . a) (2 . b) (3 . c)))

(check-expect (unzip-hop pairs1) `((1 2 3) (a b c)))
(check-expect (unzip-fold pairs1) `((1 2 3) (a b c)))

(module+ main
   (test)
)