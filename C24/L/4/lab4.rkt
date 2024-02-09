#lang racket

(require test-engine/racket-tests)

(provide my-length length-tail my-reverse reverse-tail
         num-els num-els-hop num-els-tail
         sum-els sum-els-hop sum-els-tail
         flatten flatten-hop flatten-tail)

; (my-length xs) -> integer?
; xs: list?
; returns the number of elements in xs
(define (my-length xs)  ; return length[xs]
  (if (empty? xs)
      0
      (+ 1 (my-length (rest xs)))))

(check-expect (my-length '()) 0)
(check-expect (my-length '(42)) 1)
(check-expect (my-length '(1 2 (3 6) 4 5)) 5)

; [my-length '[1 2]]
; [+ 1 [my-length '[2]]]
; ...

; (length-tail xs) -> integer?
; xs: list?
; returns the number of elements in xs
; a tail-recursive version
(define (length-tail xs)  ; return length[xs]
  (local [(define (len-t xs acc)  ; return length[xs] + acc
            (if (empty? xs)
                acc
                (len-t (rest xs) (+ acc 1))))]
    (len-t xs 0)))

(check-expect (length-tail '()) 0)
(check-expect (length-tail '(42)) 1)
(check-expect (length-tail '(1 2 (3 6) 4 5)) 5)

; [len-t '[1 2] 0]
; ...

; (my-reverse xs) -> list?
; xs: list?
; returns the reverse of xs
(define (my-reverse xs)  ; return reverse[xs]
  (if (empty? xs)
      '()
      (append (my-reverse (rest xs)) (list (first xs)))))

(check-expect (my-reverse '()) '())
(check-expect (my-reverse '(42)) '(42))
(check-expect (my-reverse '(1 2 3)) '(3 2 1))

; What is the time complexity of my-reverse?    O(N)?
; What is the space complexity of my-reverse?   O(N^2)?

; (reverse-tail xs) -> list?
; xs: list?
; returns the reverse of xs
; a tail recursive version
(define (reverse-tail xs) ; return reverse[xs]
  (define (reverse-helper xs acc)
    (if (empty? xs)
        acc
        (reverse-helper (rest xs) (cons (first xs) acc))))
  (reverse-helper xs '()))

;; Explanation: We append the last elem of `xs` (using rest) to the list `acc`
;;              When `xs` is empty, we return `acc`.

(check-expect (reverse-tail '()) '())
(check-expect (reverse-tail '(42)) '(42))
(check-expect (reverse-tail '(1 2 3)) '(3 2 1))

; What is the time complexity of reverse-tail?    O(N)?
; What is the space complexity of reverse-tail?   O(N)?

; (num-els xs) -> integer?
; xs: list?
; Returns the number of elements in xs, including any sublists, on any nesting level.
; Recursive. Not tail-recursive.
(define (num-els xs)
  (cond [(empty? xs) 0]
        [(list? (first xs))
         (+ (num-els (first xs)) (num-els (rest xs)))]
        [else (+ 1 (num-els (rest xs)))]))

(check-expect (num-els '(1 (2 (3 4 ((((5))) 6) 7)) 8)) 8)

; using HOPs (and recursion)
(define (num-els-hop xs)
  (define (num-els-hop-helper xs)
    (if (empty? xs)
        0
        (if (list? (first xs))
            (+ (num-els-hop-helper (first xs)) (num-els-hop-helper (rest xs)))
            (+ 1 (num-els-hop-helper (rest xs))))))
  (num-els-hop-helper xs))



(check-expect (num-els-hop '(1 (2 (3 4 ((((5))) 6) 7)) 8)) 8)
(check-expect (num-els-hop '(1 2 3)) 3)
(check-expect (num-els-hop '()) 0)
(check-expect (num-els-hop '(1)) 1)

; tail-recursive version
(define (num-els-tail xs)
  (define (num-els-tail-helper xs acc)
    (if (empty? xs)
        acc
        (if (list? (first xs))
            (num-els-tail-helper (rest xs) (+ acc (num-els-tail (first xs))))
            (num-els-tail-helper (rest xs) (+ acc 1)))))
  (num-els-tail-helper xs 0))


(check-expect (num-els-tail '(1 (2 (3 4 ((((5))) 6) 7)) 8)) 8)
(check-expect (num-els-tail '(1 2 3)) 3)
(check-expect (num-els-tail '()) 0)
(check-expect (num-els-tail '(1)) 1)

; (sum-els xs) -> number?
; xs: list of number?
; Returns the sum of elements in xs, including any sublists, on any nesting level.
; Returns 0 if xs is empty.
; Recursive. Not tail-recursive.
(define (sum-els xs)
  (cond [(empty? xs) 0]
        [(list? (first xs))
         (+ (sum-els (first xs)) (sum-els (rest xs)))]
        [else (+ (first xs) (sum-els (rest xs)))]))

(check-expect (sum-els '(1 (2 (3 4 ((((5))) 6) 7)) 8)) 36)

; using HOPs (and recursion)
(define (sum-els-hop xs)
  (define (sum-els-hop-helper xs)
    (if (empty? xs)
        0
        (if (list? (first xs))
            (+ (sum-els-hop-helper (first xs)) (sum-els-hop (rest xs)))
            (+ (first xs) (sum-els-hop-helper (rest xs))))))
  (sum-els-hop-helper xs))

(check-expect (sum-els-hop '(1 (2 (3 4 ((((5))) 6) 7)) 8)) 36)

; tail-recursive version
(define (sum-els-tail xs)
  (define (sum-els-tail-helper xs acc)
    (if (empty? xs)
        acc
        (if (list? (first xs))
            (sum-els-tail-helper (rest xs) (+ acc (sum-els-tail (first xs))))
            (sum-els-tail-helper (rest xs) (+ acc (first xs))))))
  (sum-els-tail-helper xs 0))

(check-expect (sum-els-tail '(1 (2 (3 4 ((((5))) 6) 7)) 8)) 36)

; (flatten xs) -> list?
; xs: list?
; Returns the flattened version of xs.
; Recursive. Not tail-recursive.
(define (flatten xs)
  (cond
    ((empty? xs) '())   ; Base Case 1: xs is empty (and so is flat.)
    ((not (pair? xs)) (list xs))  ; Base Case 2: xs is not a list, and so xs is not nested.
    (else (append (flatten (first xs)) (flatten (rest xs))))))  ; Recursive Step: Flatten the car and cdr of xs, and append the results.


(check-expect (flatten '(1 (2 (3 4 ((((5))) 6) 7)) 8))
              '(1 2 3 4 5 6 7 8))

; using HOPs (and recursion)
(define (flatten-hop xs)
  (define (flatten-hop-helper xs)
    (cond
      ((empty? xs) '())  ; Base Case 1: xs is empty (and so is flat.)
      ((not (pair? xs)) (list xs))  ; ; Base Case 2: xs is not a list, and so xs is not nested.
      (else (append-map flatten-hop xs))))  ; Recursive Step: Use `append-map` to flatten each elem of xs.
  (flatten-hop-helper xs))
;; Note: `append-map` applies a function to each elem of a list and appends the results.
;;        Effectively, `map` then `append`. (Neat function!)


(check-expect (flatten-hop '(1 (2 (3 4 ((((5))) 6) 7)) 8))
              '(1 2 3 4 5 6 7 8))

; tail-recursive version
(define (flatten-tail xs)
  (define (flatten-tail-helper xs acc)
    (cond
      ((empty? xs) acc)   ; Base Case 1: xs is empty, return `acc`.
      ((not (pair? xs)) (cons xs acc))    ; Base Case 2: xs is not a list, add xs to `acc`.
      (else (flatten-tail-helper (rest xs)    ; Recursive Step: Found nested list. Process first elem (will be added to the accumulator eventually.)
                            (flatten-tail-helper (first xs) acc))))) ; Flatten the first of xs, then add it `acc`.

  (reverse (flatten-tail-helper xs '())))   ; Reverse `acc` since we're doing this process backwards.


(check-expect (flatten-tail '(1 (2 (3 4 ((((5))) 6) 7)) 8))
              '(1 2 3 4 5 6 7 8))

(module+ main
   (test)
)