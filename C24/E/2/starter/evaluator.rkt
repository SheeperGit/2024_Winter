#lang racket

(provide evaluate simplify)

(define unary-op first)
(define operand second)
(define binary-op second)
(define left first)
(define right third)
(define (variable? v) (not (or (boolean? v) (list? v))))
(define (unary? expr) (and (list? expr) (= 2 (length expr))))
(define (binary? expr) (and (list? expr) (= 3 (length expr))))
(define (bracketed? expr) (and (list? expr) (= 1 (length expr))))

; (value-of k values) -> any
; k: any
; values: list of key/value pairs
; If k is a key in values, then return the value for that key.
; Otherwise, return k itself.
(define (value-of k values)
  (dict-ref values k k))

(define ops
  (list (cons 'and (λ (a b) (and a b)))
        (cons 'or (λ (a b) (or a b)))
        (cons 'not not)
        (cons 'implies (λ (a b) (or (not a) b)))
        ))

(define (and-simplifier a b)
  (cond
    [(eq? a #t) b]
    [(eq? b #t) a]
    [(eq? a #f) #f]
    [(eq? b #f) #f]
    [else `(and ,a ,b)]))

(define (or-simplifier a b)
  (cond
    [(eq? a #t) #t]
    [(eq? b #t) #t]
    [(eq? a #f) b]
    [(eq? b #f) a]
    [else `(or ,a ,b)]))

(define (implies-simplifier a b)
  (cond
    [(eq? a #t) #t]
    [(eq? b #t) #t]
    [(eq? a #f) (not b)]
    [(eq? b #f) #t]
    [else `(implies ,a ,b)]))

(define (not-simplifier x)
  (cond
    [(eq? x #t) #f]
    [(eq? x #f) #t]
    [(and (list? x) (eq? (unary-op x) 'not)) ; Double negation
     (operand x)]
    [else `(not ,x)]))


(define simplifiers
  (list (cons 'and and-simplifier)
        (cons 'or or-simplifier)
        (cons 'not not-simplifier)
        (cons 'implies implies-simplifier)
        ))

; (evaluate expr context) -> boolean?
; expr: a valid representation of an expression
; context: list of pairs of the form (variable . #t/#f)
; Return the value of expr under the truth assignment context.
; Pre: every variable that appears in expr also appears in context.
(define (evaluate expr context)
  (cond
    [(boolean? expr) expr]
    [(variable? expr) (value-of expr context)]
    [(unary? expr) (not (evaluate (operand expr) context))]
    [(binary? expr)
     (let* ((op (binary-op expr))
            (left-val (evaluate (left expr) context))
            (right-val (evaluate (right expr) context)))
       (cond
         [(eq? op 'and) (and left-val right-val)]
         [(eq? op 'or) (or left-val right-val)]
         [(eq? op 'implies) (or (not left-val) right-val)]))]

         [(bracketed? expr) (evaluate (car expr) context)]))



; (simplify expr context) -> valid expression
; expr: a valid representation of an expression
; context: list of pairs of the form (variable . #t/#f)
; Return an expression that is equivalent to expr,
; but is simplified as much as possible, according to
; the given rules.
(define (simplify expr context)
  (cond
    [(boolean? expr) expr]
    [(variable? expr) (value-of expr context)]
    [(unary? expr)
     (let ((op (unary-op expr))
        (subexpr (simplify (operand expr) context)))
      (cond
        [(assq op simplifiers) => (lambda (LEQV-rule) ((cdr LEQV-rule) subexpr))]
        [else expr]))] ;; No (unary) simplification rule found ;;
    [(binary? expr)
     (let* ((op (binary-op expr))
        (left-val (simplify (left expr) context))
        (right-val (simplify (right expr) context)))
      (cond
        [(assq op simplifiers) => (lambda (LEQV-rule) ((cdr LEQV-rule) left-val right-val))]
        [else expr]))] ;; No (binary) simplification rule found ;;
    [else expr]))

;; Note: This function uses `assq` which searches for the first pair in a list (simplifiers) whose car is equal to the given key (op).                          ;;
;;       If at some point during assq's for-loop it finds `op`, then it returns the entire pair.                                             vvvvvvvvvvvvvv     ;;
;;       However, since we want the rule (e.g., and-simplifier), we need to call the cdr in the pair to use the simplifier (e.g., (cons 'and and-simplifier))   ;;
;;                                                                                                                                           ^^^^^^^^^^^^^^     ;;
;;       Lastly, the `=>` syntax is used similarly to Linux piping, wherein the result of one function is passed as the input of another.                       ;;
;;       In this case, if `assq` finds an (op, rule) pair, such as (cons 'and and-simplifier), then this pair is passed into different (lambda) function        ;;
;;       that simply applies a simplifier to its args, whether unary or binary.                                                                                 ;;